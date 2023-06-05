import 'package:flutter/material.dart';

class NavigationUtil {
  navigateTo( BuildContext context, String pageToNavigateTo ) {
    Navigator.pushNamed(context, pageToNavigateTo);
  }
}