import 'package:flutter/material.dart' show IconData, Widget;

class MainMenu {
  final String route;
  final IconData icon;
  final String name;
  final Widget? screen;
  final IconData icon2;

  MainMenu(
      {required this.route,
      required this.icon,
      required this.name,
      this.screen,
      required this.icon2});
}
