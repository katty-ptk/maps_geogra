// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class Roles {
  final String ADMIN = "admin";
  final String USER = "user";
}

class StateManager extends ChangeNotifier {
  String ROLE = "";
  String USER_EMAIL = "";

  setRole(String role) {
    ROLE = role;
    notifyListeners();
  }

  setUserEmail( String email ) {
    USER_EMAIL = email;
    notifyListeners();
  }
}