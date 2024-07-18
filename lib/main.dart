import 'package:flutter/material.dart';
import 'package:task_ayot/app_startup.dart';
import 'package:task_ayot/services/database/database_service.dart';

Future<void> main() async {
  DatabaseService db = DatabaseService();
  await db.initHiveFlutter();
  await db.initDB();

  runApp(const AppStartup());
}
