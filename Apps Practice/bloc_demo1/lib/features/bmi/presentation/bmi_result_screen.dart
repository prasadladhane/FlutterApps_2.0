import 'package:bloc_demo1/features/bmi/bloc/bmi_bloc.dart';
import 'package:bloc_demo1/features/bmi/bloc/bmi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiResultScreen extends StatelessWidget {
  const BmiResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result Screen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<BMIBloc, BMIState>(
          builder: (context, state) {
            if (state.bmi == null) {
              return const Center(
                child: Text(
                  "No BMI calculated yet",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Your BMI is ${state.bmi!.toStringAsFixed(1)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Category: ${state.category.toString().split('.').last}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
