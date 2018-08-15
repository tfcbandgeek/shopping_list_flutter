import 'package:flutter/material.dart';

// 0054, 0056

class CustomFab extends StatelessWidget {
  final Function pressed;
  final String text;
  final Icon icon;
  final Color background;
  final Color splash;
  final Color foreground;
  final bool narrow;

  CustomFab(
    this.pressed,
    {this.text = "",
    this.icon = const Icon(Icons.add),
    this.background = Colors.blue,
    this.splash = Colors.lightBlue,
    this.foreground = Colors.white,
    this.narrow = false});

  @override
  Widget build(BuildContext context) {
    try {
      if (narrow) {
        return FloatingActionButton(
          backgroundColor: background,
          foregroundColor: foreground,
          onPressed: pressed,
          child: icon,
        );
      } else {
        return RawMaterialButton(
          fillColor: background,
          splashColor: splash,
          shape: const StadiumBorder(),
          child: Text(
              text,
              style: TextStyle(color: foreground)),
          onPressed: pressed,
        );
      }
    } catch(Exception) {
      return RawMaterialButton(
        fillColor: background,
        splashColor: splash,
        shape: const StadiumBorder(),
        child: Text(
            text,
            style: TextStyle(color: foreground)),
        onPressed: pressed,
      );
    }
  }
}