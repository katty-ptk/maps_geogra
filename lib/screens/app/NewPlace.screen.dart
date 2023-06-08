// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:maps_geogra/utils/navigation.utils.dart';
import 'package:maps_geogra/utils/api_paths.utils.dart';
import 'package:maps_geogra/utils/routes.utils.dart';

class NewPlaceScreen extends StatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  // controllers
  final _nameController = TextEditingController();
  final _climateController = TextEditingController();
  final _natureController = TextEditingController();
  final _tourismController = TextEditingController();
  final _economyController = TextEditingController();
  final _bordersController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

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
              buildLAT(),
              buildLNG(),
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
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: "What place are you entering?",
            hintText: "ex: Asia"
          ),
        ),
      );
  }

  Step buildLAT() {
    return 
      Step(
        title: const Text("Latitude"),
        isActive: _currentStep == 1,
        content: TextFormField(
          controller: _latitudeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "What is the Latitude of this place?",
            hintText: "ex: 47.500801 ( Austria )"
          ),
        ),
      );
  }

  Step buildLNG() {
    return 
      Step(
        title: const Text("Longitude"),
        isActive: _currentStep == 2,
        content: TextFormField(
          controller: _longitudeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "What is the Longitude of this place?",
            hintText: "ex: 14.796495 ( Austria )"
          ),
        ),
      );
  }

  Step buildClimate() {
    return 
      Step(
        title: const Text("Climate"),
        isActive: _currentStep == 3,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              controller: _climateController,
              maxLines: 2,
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
        isActive: _currentStep == 4,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              controller: _natureController,
              maxLines: 2,
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
        isActive: _currentStep == 5,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              controller: _tourismController,
              maxLines: 2,
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
        isActive: _currentStep == 6,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              controller: _economyController,
              maxLines: 2,
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
        isActive: _currentStep == 7,
        content: Column(
          children: [
            const SizedBox(height: 5,),

            TextFormField(
              controller: _bordersController,
              maxLines: 2,
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

  String checkEmptyField() {

    if ( _nameController.text == "" ) {
      return "Place's Name";
    }

    if ( _latitudeController.text == "" ){
      return "LATITUDE";
    }

    if ( _longitudeController.text == "" ) {
      return "LONGITUDE";
    }

    if ( _climateController.text == "" ){
      return "CLIMATE";
    }

    if ( _natureController.text == "" ) {
      return "NATURE";
    }

    if ( _tourismController.text == "" ) {
      return "TOURISM";
    }

    if ( _economyController.text == "" ) {
      return "ECONOMY";
    }

    if ( _bordersController.text == "" ) {
      return "BORDERS";
    }

    return "";
  }

  continued() async {
    String emptyFields = checkEmptyField();

    if ( _currentStep < 7 ) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      if ( emptyFields != "" ){
          ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  "$emptyFields cannot be empty!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                )
              )  
            );
        } else {
          var data = {
            "title": _nameController.text,
            "lat": _latitudeController.text,
            "lng": _longitudeController.text,
            "climate": _climateController.text,
            "nature": _natureController.text,
            "tourism": _tourismController.text,
            "economy": _economyController.text,
            "borders": _bordersController.text
          };

          http.Response response = await http.post(
            Uri.parse(Paths().BASE_URL + Paths().PENDING_PLACES),
            headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data)
          );
          print(response.body);

          ScaffoldMessenger.of(context)
            .showSnackBar(
              const SnackBar(
                backgroundColor: Colors.lightGreen,
                content: Text(
                  "successfully added",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                )
              )  
            );

            print("this is before delay");

            Future.delayed(const Duration(milliseconds: 1000), () {
              NavigationUtil().navigateTo(context, Routes().HOME_SCREEN);
            });
        }

    }
  }

  cancel(){
    _currentStep > 0 ?
        setState(() => _currentStep -= 1) : null;
  }

}