import 'package:flutter/material.dart';

import 'package:shopping_list/home.dart';
import 'package:shopping_list/settings.dart';
import 'package:shopping_list/additional.dart';

// Main Method -------------------------------------------------------------------------------------
void main() {
  settings.load().then((void t) => load().then((void t) => runApp(ShoppingApp())));
}

// Application Root --------------------------------------------------------------------------------
class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: HOME_TITLE,
      theme: ThemeData(primarySwatch: PRIMARY),
      home: ShoppingListHomePage(title: HOME_TITLE),
    );
  }
}