import 'package:flutter/material.dart';

import 'package:shopping_list/home.dart';
import 'package:shopping_list/settings.dart';
import 'package:shopping_list/tags.dart';
import 'package:shopping_list/additional.dart';

// 0024, 0053

List<String> poop = ["Soup", "Top", "Popcorn", "Lovely", "True", "Topical", "Gilmore", "Poop", "Until"];

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

class TestShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: HOME_TITLE,
      theme: ThemeData(primarySwatch: PRIMARY),
      home: TestHome(),
    );
  }
}

class TestHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestHomeState();
  }
}

class TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TagSelectionDialogWidget((){}, List<String>(), List<String>()),
    );
  }
}