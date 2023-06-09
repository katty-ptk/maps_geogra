import 'package:flutter/material.dart';

class RespondToPlaceScreen extends StatefulWidget {
  final String plcaeID;

  const RespondToPlaceScreen({super.key, required this.plcaeID});

  @override
  State<RespondToPlaceScreen> createState() => _RespondToPlaceScreenState();
}

class _RespondToPlaceScreenState extends State<RespondToPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repond to Place"),
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Text(widget.plcaeID),
              )
            ],
          )
        ],
      ),
    );
  }
}