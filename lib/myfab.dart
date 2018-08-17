import 'package:flutter/material.dart';

String myFabVersion = "0.1.0";
int myFabBuild = 1;

/// CustomFab
/// A custom Floating Action Button that can be either the traditional circle or a newer text button.
class CustomFab extends StatelessWidget {
  // The action to be called on the fab being pressed
  final Function pressed;
  // The text of the fab
  final String text;
  // The icon of the fab
  final Icon icon;
  // The background color of the fab
  final Color background;
  // The press color of the fab
  final Color splash;
  // The foreground color of the fab
  final Color foreground;
  // Select true it you want the narrow fab (Cirle)
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