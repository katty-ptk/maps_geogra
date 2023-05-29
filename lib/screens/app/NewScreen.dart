// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';

class NewPlaceScreen extends StatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              buildTitle(),
              const SizedBox(height: 24,),
        
              buildSubmitButton()
            ],
          ),
        ),
      )
    );
  }

  Widget buildTitle() {
    return
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Name of place',
          border: OutlineInputBorder()          
        ),

        onSaved: (newValue) => print("Value of title field: $newValue"),
      );
  }

  Widget buildSubmitButton() {
    return 
      TextButton(
        onPressed: () {
          print("pressed submit!");
        },

        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),

        child: const Text(
          "Submit",
        ),
    );
  }
}