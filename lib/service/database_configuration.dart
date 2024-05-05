import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

databaseConfiguration() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env["Url"]!, anonKey: dotenv.env["AnonKey"]!);
}
