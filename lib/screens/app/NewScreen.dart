// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';

class NewPlaceScreen extends StatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text("Add a new place"),
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
          //  primary: Color.fromARGB(255, 23, 90, 25)
            primary: Colors.indigo
          )
        ),
        child: Stepper(
          type: stepperType,
          physics: const ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepContinue: continued,
            onStepCancel: cancel,
            steps: [
              buildTitle(),
              buildClimate(),
              buildNature(),
              buildCTourism(),
            buildEconomy(),
            buildBorders()
          ],
              
        ),
      ),
    );
  }

  Step buildTitle() {
    return 
      Step(
        title: const Text("Place's Name"),
        isActive: _currentStep == 0,
        content: TextFormField(
          decoration: const InputDecoration(
            labelText: "What place are you entering?",
            hintText: "ex: Asia"
          ),
        ),
      );
  }

  Step buildClimate() {
    return 
      Step(
        title: const Text("Climate"),
        isActive: _currentStep == 1,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "What is the climate of this place?",
                hintText: "Give a short description of the climate.",
                focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 0,)
          ],
        ),
      );
  }

  Step buildNature() {
    return 
      Step(
        title: const Text("Nature"),
        isActive: _currentStep == 2,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "What is the nature like?",
                hintText: "Give a short description of the nature.",
                focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 0,)
          ],
        ),
      );
  }

  Step buildCTourism() {
    return 
      Step(
        title: const Text("Tourism"),
        isActive: _currentStep == 3,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "What can you say about the tourism there?",
                hintText: "Give a short description of the tourism.",
                focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 0,)
          ],
        ),
      );
  }

  Step buildEconomy() {
    return 
      Step(
        title: const Text("Economy"),
        isActive: _currentStep == 4,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "What is the economy of this place?",
                hintText: "Give a short description of the economy.",
                focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 0,)
          ],
        ),
      );
  }

  Step buildBorders() {
    return 
      Step(
        title: const Text("Borders"),
        isActive: _currentStep == 5,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "What are the borders of this place?",
                hintText: "Give a short description of the the borders.",
                focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 0,)
          ],
        ),
      );
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 5 ?
        setState(() => _currentStep += 1): null;
  }

  cancel(){
    _currentStep > 0 ?
        setState(() => _currentStep -= 1) : null;
  }

}