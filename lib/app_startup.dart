import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ayot/logic/main_screen_cubit.dart';
import 'package:task_ayot/ui/screens/main_screen.dart';

class AppStartup extends StatelessWidget {
  const AppStartup({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AYOT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => MainScreenCubit(),
        child: const MainScreen(),
      ),
    );
  }
}