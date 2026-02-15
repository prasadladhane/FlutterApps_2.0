import "package:bloc_demo1/core/bmi_calculator.dart";
import "package:bloc_demo1/features/bmi/bloc/bmi_event.dart";
import "package:bloc_demo1/features/bmi/bloc/bmi_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class BMIBloc extends Bloc<BMIEvent,BMIState>{
  BMIBloc():super(const BMIState()){

    //weight change
    on<WeightChanged>((event,emit){
      final isValid=event.weight > 0 && state.height > 0;
      emit(state.copyWith(weight:event.weight,isValidInput:isValid));
    });

    //height change
    on<HeightChanged>((event,emit){
      final isValid=state.weight > 0 && state.height > 0;
      emit(state.copyWith(height:event.height,isValidInput:isValid));
    });

    //calculate bmi
    on<CalculateBMI>((event,emit){
      if(state.isValidInput){
        final bmi=calculateBmi(weightKg:state.weight,heightCm:state.height);
        final category=classifyBmi(bmi);
        emit(state.copyWith(bmi:bmi,category:category));
      }
    });
  }
}