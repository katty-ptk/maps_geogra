import 'package:flutter/material.dart';

class PendingPlacesScreen extends StatefulWidget {
  const PendingPlacesScreen({super.key});

  @override
  State<PendingPlacesScreen> createState() => _PendingPlacesScreenState();
}

class _PendingPlacesScreenState extends State<PendingPlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Here will be shown the pending for approval places :)")
          ],
        ),
      ),
    );
}
}