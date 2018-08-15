import 'dart:convert';

import 'package:flutter/material.dart';
// Data Class, Needs A ton of Help

// Data --------------------------------------------------------------------------------------------
/// List of ShoppingLists
List<ShoppingList> lists = List<ShoppingList>();
/// The currently selected Shopping List
ShoppingList current;

// Data Classes ------------------------------------------------------------------------------------
/// ShoppingList
/// The class that encapsulates all of the data needed for each of the Shopping Lists
class ShoppingList {
  // Data ------------------------------------------------------------------------------------------
  Image icon;
  bool hasImage = false;
  String title = "";
  String note = "";
  List<ShoppingItem> items = List<ShoppingItem>();

  // Helper Methods --------------------------------------------------------------------------------
  String getTitle() {
    if (title == "") {
      return "Unnamed List";
    } else if (title == " ") {
      return "Unnamed List";
    } else if (title == "No Title") {
      return "Unnamed List";
    } else {
      return title;
    }
  }

  void addItem() {
    items.add(ShoppingItem());
  }

  void removeItem(int position) {
    items.removeAt(position);
  }

  // JSON Methods ----------------------------------------------------------------------------------
  void loadJSON(String string) {
    Map<String, dynamic> data = json.decode(string);

    title = data["title"];
    note = data["note"];
    List<dynamic> temp = data["items"];
    items = temp.map((dynamic string) {
      ShoppingItem item = ShoppingItem();
      item.loadJSON(string as String);
      return item;
    }).toList();
  }

  String toJSON() {
    Map<String, dynamic> data = Map();
    List<String> temp = items.map((ShoppingItem item) {
      return item.toJSON();
    }).toList();

    data["title"] = title;
    data["note"] = note;
    data["items"] = temp;

    return json.encode(data);
  }
}

/// ShoppingItem
/// This class encapsulates all of the data in a shopping list item, It will be getting more and more
/// complex as time goes by
class ShoppingItem {
  // Controllers -----------------------------------------------------------------------------------
  TextEditingController titleController;
  TextEditingController noteController;

  // Data ------------------------------------------------------------------------------------------
  bool checked = false;
  bool expanded = false;
  Image icon;
  bool hasImage = false;
  String title = "";
  String notes = "";
  List<String> tags = List<String>();

  // Helper Methods --------------------------------------------------------------------------------
  String getTitle() {
    if (title == "") {
      return "Unnamed Item";
    } else if (title == " ") {
      return "Unnamed Item";
    } else {
      return title;
    }
  }

  TextEditingController getTitleController() {
    if (titleController == null) {
      titleController = TextEditingController(text: title);
    }

    return titleController;
  }

  TextEditingController getNoteController() {
    if (noteController == null) noteController = TextEditingController(text: notes);
    return noteController;
  }

  // JSON Methods ----------------------------------------------------------------------------------
  void loadJSON(String string) {
    Map<String, dynamic> data = json.decode(string);

    try {
      checked = data["checked"];
    } catch(Exception) {
      checked = false;
    }

    try {
      title = data["title"];
    } catch(Exception) {
      title = "";
    }

    try {
      notes = data["notes"];
    } catch(Exception) {
      notes = "";
    }

    try {
      List<dynamic> d = data["tags"];
      tags = d.map((dynamic c) {
        return c as String;
      }).toList();
    } catch(Exception) {
      tags = List<String>();
    }
  }

  String toJSON() {
    Map<String, dynamic> data = Map();

    data["checked"] = checked;
    data["title"] = title;
    data["notes"] = notes;
    data["tags"] = tags;

    return json.encode(data);
  }
}