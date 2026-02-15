import "package:bloc_demo1/features/bmi/bloc/bmi_bloc.dart";
import "package:bloc_demo1/features/bmi/presentation/bmi_input_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
void main() {
  runApp(
    BlocProvider(
      create: (_) => BMIBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      home: BmiInputScreen(),
    );
  }
}
