import "package:flutter/material.dart";

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizzApp(),
      
    );
  }
}
class QuizzApp extends StatefulWidget{
  const QuizzApp({super.key});

  @override

  State createState()=>_QuizzAppState();

}
class _QuizzAppState extends State<QuizzApp>{

List<Map<String,dynamic>> totalQuestions=[
  {
    "Question":"Who was the Winner of 2007 Cricket World Cup?",
    "Options":["Sri Lanka","South Africa","Australia","India"],
    "Correct Answer":2
  },
  {"Question":"Who was the Winner of 2011 Cricket World Cup?",
    "Options":["Pakistan","Sri Lanka","West Indies","India"],
    "Correct Answer":3
    },
  {"Question":"Who was the Winner of 2015 Cricket World Cup?",
    "Options":["India","Australia","New Zealand","South Africa"],
    "Correct Answer":1
    },
  {"Question":"Who was the Winner of 2019 Cricket World Cup?",
    "Options":["England","New Zealand","Australia","Scotland"],
    "Correct Answer":0
    },
  {"Question":"Who was the Winner of 2023 Cricket World Cup?",
    "Options":["India","Australia","Afghanistan","Netherland"],
    "Correct Answer":1
    }
];
int currentQuestionIndex = 0;
int selectedAnswerIndex = -1;
bool questionPage = true;
int score = 0;

WidgetStateProperty<Color?> checkAnswer(int answerIndex){
  if(selectedAnswerIndex != -1){
    
    if(answerIndex == totalQuestions[currentQuestionIndex]["Correct Answer"]){
      if(answerIndex == selectedAnswerIndex){
      score++;
    }

      return const WidgetStatePropertyAll(Colors.green);

    }else if(selectedAnswerIndex == answerIndex){

      return const WidgetStatePropertyAll(Colors.red);

    }else{
      return const WidgetStatePropertyAll(null);
    }
  }else{
    return const WidgetStatePropertyAll(null);
  }
}


  @override

  Widget build(BuildContext context){
    return isQuestionScreen();
  }
  Scaffold isQuestionScreen(){
    if(questionPage==true){
      return Scaffold(
        appBar:AppBar(
          title: const Text(
            "Quizz App",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   width: 130,
                // ),
                Text("Question:${currentQuestionIndex + 1}/${totalQuestions.length}",
                style: 
                const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 45,
            ),

            ///Question

            SizedBox(
              width: 380,
              height: 70,
              child: Text(
                totalQuestions[currentQuestionIndex]["Question"],
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
           
           ///option 1
           
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: checkAnswer(0),
                ),
                onPressed: (){ 
                  if(selectedAnswerIndex == -1){
                    selectedAnswerIndex=0;
                    setState(() {});
                  }
                },
                child: Text("A.${
                  totalQuestions[currentQuestionIndex]["Options"][0]}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            
            ///option 2
            
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                 style: ButtonStyle(
                  backgroundColor: checkAnswer(1),
                ),
                onPressed: (){ 
                  if(selectedAnswerIndex == -1){
                    selectedAnswerIndex=1;
                    setState(() {});
                  }
                },
                child: Text("B.${
                  totalQuestions[currentQuestionIndex]["Options"][1]}",
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            ),
           
           
           //oprion 3
           
            const SizedBox(
              height: 45,
            ),
             SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                 style: ButtonStyle(
                  backgroundColor: checkAnswer(2),
                ),
                onPressed: (){
                   if(selectedAnswerIndex == -1){
                    selectedAnswerIndex=2;
                    setState(() {});
                  }
                },
                child: Text("C.${
                  totalQuestions[currentQuestionIndex]["Options"][2]}",
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            ),
            
            
            ///option 4
            
            
            const SizedBox(
              height: 45,
            ),
             SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                 style: ButtonStyle(
                  backgroundColor: checkAnswer(3),
                ),
                onPressed: (){
                   if(selectedAnswerIndex == -1){
                    selectedAnswerIndex=3;
                    setState(() {});
                  }
                },
                child: Text("D.${
                  totalQuestions[currentQuestionIndex]["Options"][3]}",
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            if(selectedAnswerIndex !=-1){
              if(currentQuestionIndex < totalQuestions.length-1){
                currentQuestionIndex++;
              }else{
                questionPage=false;
              }
              selectedAnswerIndex=-1;
              setState(() {});
            }
          },
    
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.forward,
            color: Colors.white,
          ),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text("Quizz Result",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: [
              Image.network("https://images-cdn.ubuy.co.in/64d2615cdc228748e4296a77-juvale-large-gold-1st-place-trophy-cup.jpg",
              height: 300,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Congratulations!!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.orange
                ),
              ),
              const SizedBox(height: 30,),
              Text("Score: $score / ${totalQuestions.length}",
                style:const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),  
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: (){

                      score = 0;
                      currentQuestionIndex = 0;
                      questionPage = true;
                      selectedAnswerIndex= -1;

                      setState(() {});
                    },

                    child:
                      const Text(
                        "Reset",    
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),                    
                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}