import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:medicine_reminder_app/data_layer/data_layer.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final serviceLocator = DataInjection().locator.get<DBServices>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<SignUpEvent>(signUpNewUser);
    on<LoginEvent>(login);
    on<CheckSessionAvailability>(getSession);
    on<LogoutEvent>(logout);
    on<ResendOtpEvent>(resendOtp);
    on<SendOtpEvent>(sendOtp);
    on<ConfirmOtpEvent>(confirmOtp);
    on<ChangePasswordEvent>(updatePassword);
  }

  FutureOr<void> signUpNewUser(
      SignUpEvent event, Emitter<AuthState> emit) async {
    if (event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.name.trim().isNotEmpty) {
      try {
        await serviceLocator.signUp(
            email: event.email, password: event.password);

        await serviceLocator.createUser(name: event.name, email: event.email);
        final userId = await serviceLocator.getCurrentUserId();
        await serviceLocator.getUser(id: userId);

        emit(AuthSuccessState(msg: "Kayıt işlemi başarıyla tamamlandı."));
      } on AuthException catch (e) {
        emit(AuthErrorState(
            msg:
                "Kayıt başarısız: ${e.statusCode}. Lütfen e-postanızı ve şifrenizi kontrol edin"));
      } on Exception catch (e) {
        emit(AuthErrorState(msg: "Kayıt işlemi sırasında bir hata oluştu: $e"));
      }
    } else {
      emit(AuthErrorState(msg: "Lütfen tüm gerekli alanları doldurunuz"));
    }
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        await serviceLocator.login(
            email: event.email, password: event.password);

        emit(AuthSuccessState(msg: "Başarıyla giriş yaptınız"));
      } on AuthException catch (e) {
        emit(AuthErrorState(
            msg:
                "Yanlış e-posta veya şifre: ${e.statusCode}. Lütfen bilgilerinizi kontrol edin ve tekrar deneyin."));
      } on Exception catch (e) {
        emit(AuthErrorState(msg: "Oturum açma işlemi sırasında bir hata oluştu: $e"));
      }
    } else {
      emit(AuthErrorState(
          msg: "Lütfen hem e-posta hem de şifre alanlarını doldurun."));
    }
  }

  FutureOr<void> getSession(
      CheckSessionAvailability event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final sessionData = await serviceLocator.getCurrentSession();
      emit(SessionAvailabilityState(isAvailable: sessionData));
      final userId = await serviceLocator.getCurrentUserId();
      await serviceLocator.getUser(id: userId);
      emit(SessionAvailabilityState(isAvailable: sessionData));
    } catch (e) {}
  }

  FutureOr<void> logout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.logout();
      emit(AuthSuccessState(msg: "Başarıyla çıkış yaptınız"));
    } catch (e) {
      emit(AuthErrorState(msg: "Oturum kapatma işlemi sırasında bir hata oluştu"));
    }
  }

  FutureOr<void> sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.trim().isNotEmpty) {
      try {
        await serviceLocator.sendOtp(email: event.email);
        serviceLocator.email = event.email;
        emit(AuthSuccessState(
            msg:
              "E-postanıza şifre sıfırlama OTP kodu gönderildi. Lütfen gelen kutunuzu kontrol edin"));      } on AuthException catch (e) {
        emit(AuthErrorState(
            msg:
                "E-posta adresi geçerli değil. Lütfen geçerli bir e-posta adresi girin"));
      } on Exception catch (e) {
        emit(AuthErrorState(
            msg:
                "Bir sorunla karşılaşıldı. Sonra tekrar deneyin."));
      }
    } else {
      emit(AuthErrorState(msg: "Lütfen e-mail adresinizi yazınız"));
    }
  }

  FutureOr<void> confirmOtp(
      ConfirmOtpEvent event, Emitter<AuthState> emit) async {
    if (event.otpToken.trim().isNotEmpty) {
      try {
        await serviceLocator.verifyOtp(
            email: event.email, otpToken: event.otpToken);
        emit(AuthSuccessState(
            msg: "OTP kodu onaylandı, lütfen yeni şifreyi girin"));
      } on AuthException catch (e) {
        emit(AuthErrorState(msg: "Geçersiz OTP kodu, lütfen tekrar deneyin"));
      } on Exception catch (e) {
        emit(AuthErrorState(
            msg: "Bir sorunla karşılaştık. Daha sonra tekrar deneyin."));
      }
    } else {
      emit(AuthErrorState(msg: "Lütfen OTP kodunu girin"));
    }
  }

  FutureOr<void> updatePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.password == event.confirmPassword) {
      if (event.password.trim().isNotEmpty && event.password.length >= 6) {
        try {
          await serviceLocator.changePassword(password: event.password);
          emit(AuthSuccessState(msg: "Şifre başarıyla değiştirildi"));
          await serviceLocator.logout();
        } on AuthException catch (e) {
          emit(AuthErrorState(msg: "Parolanızı değiştirmenize izin verilmiyor."));
        } on Exception catch (e) {
          emit(AuthErrorState(
              msg:
                  "Sunucularımızda bir sorun var, lütfen daha sonra tekrar deneyiniz."));
        }
      } else {
        emit(AuthErrorState(
            msg: "Lütfen geçerli bir şifre girin (en az 6 karakter)"));
      }
    } else {
      emit(AuthErrorState(
          msg: "Parolalar uyuşmuyor. Lütfen şifrelerin eşleştiğinden emin olun"));
    }
  }

  FutureOr<void> resendOtp(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.resend();
      emit(AuthSuccessState(
          msg: "OTP kodu şu adrese yeniden gönderildi: ${serviceLocator.email}"));
    } catch (e) {
      emit(AuthErrorState(msg: "Bir hatayla karşılaştık. \nDaha sonra tekrar dene."));
    }
  }
}
