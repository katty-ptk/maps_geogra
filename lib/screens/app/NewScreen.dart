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
      appBar: AppBar(),
      body: Stepper(
        type: stepperType,
        physics: const ScrollPhysics(),
        currentStep: _currentStep,
        onStepTapped: (step) => tapped(step),
        onStepContinue: continued,
        onStepCancel: cancel,
        steps: [
          Step(
            title: const Text("stepul 1"),
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
              ],
            ),
            isActive: _currentStep == 0,
          ),

          Step(
            title: const Text("steul 222"),
            content: Container(),
            isActive: _currentStep == 1,
          ),

          Step(
            title: const Text("steul 3"),
            content: Container(),
            isActive: _currentStep == 2,
          ),

        ],

      )
    );
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
        setState(() => _currentStep += 1): null;
  }

  cancel(){
    _currentStep > 0 ?
        setState(() => _currentStep -= 1) : null;
  }

}