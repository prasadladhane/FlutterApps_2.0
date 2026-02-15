import 'package:bloc_demo1/core/bmi_calculator.dart';
import 'package:equatable/equatable.dart';

class BMIState extends Equatable{
  final double weight;
  final double height;
  final double? bmi;
  final BmiCategory? category;
  final bool isValidInput;

  const BMIState({
    this.weight=0,
    this.height=0,
    this.bmi,
    this.category,
    this.isValidInput=false,
  });

  BMIState copyWith({
    double? weight,
    double? height,
    double? bmi,
    BmiCategory? category,
    bool? isValidInput,
  }) {
    return BMIState(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      category: category ?? this.category,
      isValidInput: isValidInput ?? this.isValidInput,
    );
  }

  @override
  List<Object?> get props=> [weight,height,bmi,category,isValidInput];
}