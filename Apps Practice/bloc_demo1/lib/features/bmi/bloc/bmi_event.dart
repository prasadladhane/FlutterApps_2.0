
import 'package:equatable/equatable.dart';

abstract class BMIEvent extends Equatable{
  @override
  List <Object?> get props=>[];
}

// Triggered when weight input changes
class WeightChanged extends BMIEvent{
  final double weight;
  WeightChanged(this.weight);

  @override
  List<Object?> get props=>[weight];
}

//Triggered when height input changes
class HeightChanged extends BMIEvent{
  final double height;
  HeightChanged(this.height);

  @override
  List<Object?> get props=> [height];
}

//Triggered when user taps "Calculate"
class CalculateBMI extends BMIEvent{}