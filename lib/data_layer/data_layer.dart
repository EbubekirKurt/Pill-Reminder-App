import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';

class DataInjection {
  final locator = GetIt.I;

  setup() {
    locator.registerSingleton<DBServices>(DBServices());
  }
}
