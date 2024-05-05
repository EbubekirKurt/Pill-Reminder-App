import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBServices {
  //supabase client
  final supabase = Supabase.instance.client;
  int pellCount = 0;
  int pellPireod = 0;
  TimeOfDay time = TimeOfDay.now();
  String email = "";
  String nameUser = "بك";

  // ----- Auth ------

  //Sign up
  Future signUp({required String email, required String password}) async {
    await supabase.auth.signUp(
      password: password,
      email: email,
    );
  }

  //create user
  Future createUser({required String name, required String email}) async {
    await supabase.from('user').insert({'email': email, 'username': name});
    nameUser = name;
  }

  Future getUser({required String id}) async {
    var userInfo =
        await supabase.from('user').select('*').match({'id': id}).single();
    nameUser = userInfo['username'];
  }

  //Login
  Future login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(password: password, email: email);
  }

  //Logout
  Future logout() async {
    supabase.auth.signOut();
  }

  //get current session
  Future getCurrentSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      return session;
    } else {
      return;
    }
  }

  //get current session
  Future getCurrentUserId() async {
    final session = supabase.auth.currentSession!.user.id;
    return session;
  }

  //reset password
  Future resetPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(
      email,
    );
  }

  //send OTP
  Future sendOtp({required String email}) async {
    await supabase.auth.signInWithOtp(
      email: email,
      shouldCreateUser: false,
    );
  }

  //verify OTP
  Future verifyOtp({required String email, required String otpToken}) async {
    await supabase.auth
        .verifyOTP(token: otpToken, type: OtpType.email, email: email);
  }

  Future resend() async {
    email = supabase.auth.currentSession!.user.email!;
    await supabase.auth.resend(type: OtpType.signup, email: email);
  }

  //Update user
  Future changePassword({required String password}) async {
    await supabase.auth.updateUser(UserAttributes(password: password));
  }

  Future<List<MedicineModel>> getAllMedicine() async {
    final medicineListData = await supabase
        .from('mediction')
        .select('*')
        .match({'user_id': supabase.auth.currentUser!.id});
    List<MedicineModel> listOfMedicine = [];
    for (var element in medicineListData) {
      listOfMedicine.add(MedicineModel.fromJson(element));
    }
    return listOfMedicine;
  }

  //insert mediction
  Future insertMediationData(MedicineModel medicine) async {
    await supabase.from('mediction').insert({
      'user_id': medicine.userId,
      'time': medicine.time!.substring(9, 15),
      "count": medicine.count,
      "piriod": medicine.period,
      "name": medicine.name,
      'stats': medicine.state.toString()
    });
  }

  //update mediction
  Future upDateMediationData(MedicineModel medicine, String id) async {
    final usetID = await getCurrentUserId();
    await supabase.from('mediction').update({
      'user_id': usetID,
      'time': medicine.time!.substring(9, 15),
      'count': medicine.count,
      'piriod': medicine.period,
      'name': medicine.name,
      'stats': medicine.state.toString()
    }).eq("id", id);
  }

  //delete mediction
  Future deleteMediationData(String id) async {
    await supabase.from('mediction').delete().eq("id", id);
  }
}
