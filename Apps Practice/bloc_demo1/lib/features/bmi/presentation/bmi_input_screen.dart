import "package:bloc_demo1/features/bmi/bloc/bmi_bloc.dart";
import "package:bloc_demo1/features/bmi/bloc/bmi_event.dart";
import "package:bloc_demo1/features/bmi/bloc/bmi_state.dart";
import "package:bloc_demo1/features/bmi/presentation/bmi_result_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class BmiInputScreen extends StatelessWidget{
  BmiInputScreen({super.key});

  final TextEditingController _weightController=TextEditingController();
  final TextEditingController _heightController=TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator",style:TextStyle(fontSize: 22,fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter your Weight in Kg",style: TextStyle(fontSize: 18),),
            SizedBox(
              width:MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: "Enter Weight",
                  border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  final weight=double.tryParse(value)??0;
                  context.read<BMIBloc>().add(WeightChanged(weight));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: const Text("Enter your Height in cm",style: TextStyle(fontSize: 18),),
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: "Enter Height",
                  border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  final height = double.tryParse(value) ?? 0;
                  context.read<BMIBloc>().add(HeightChanged(height));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:30,left:MediaQuery.of(context).size.width*0.22),
              child: BlocBuilder<BMIBloc,BMIState>(
                builder:(context,state){
                return GestureDetector(
                  onTap:state.isValidInput ?(){
                    context.read<BMIBloc>().add(CalculateBMI());
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context)=>const BmiResultScreen()
                      )
                    );
                  }
                  : null,
                  child: Container(
                    height: 56,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text("Calculate"),
                  ),
                );
                }
              ),
            )
          ],
        ),
      )
    );
  }
}