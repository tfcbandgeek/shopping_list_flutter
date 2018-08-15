import "dart:async";
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shopping_list/data.dart';

// Version Constants -------------------------------------------------------------------------------
const String VERSION = "0.2.3";
const int BUILD = 5;

// String Constants --------------------------------------------------------------------------------
const String ABOUT = "About";
const String ADD = "Add";
const String ADD_A_TAG = "Add a Tag";
const String CANCEL = "Cancel";
const String DELETE = "Delete";
const String EDIT_ICON = "Edit Icon";
const String EDIT_TAGS = "Edit Tags";
const String HOME_TITLE = "Shopping List";
const String SAVE = "Save";
const String SAVE_QUESTION = "Save";
const String SETTINGS = "Settings";
const String NARROW_FAB_SETTING ="Narrow Floating Action Button";
const String NOTES = "Notes";
const String TITLE = "Title";

// Color Constants ---------------------------------------------------------------------------------
const Color PRIMARY = Colors.teal;
const Color PRIMARY_SPLASH = Colors.tealAccent;
const Color PRIMARY_TEXT = Colors.black;
const Color SECONDARY_TEXT = Colors.white;

// Enums -------------------------------------------------------------------------------------------
enum DismissDialogAction {
  cancel, discard, save,
}

// Alert Dialog Builder ----------------------------------------------------------------------------
AlertDialog buildAlertDialog(BuildContext context, Widget content, String cancelText, Function cancelAction, String acceptText, Function acceptAction) {
  return AlertDialog(
    content: content,
    actions: <Widget>[
      FlatButton(
        child: Text(cancelText),
        onPressed: cancelAction,
      ),
      FlatButton(
          child: Text(acceptText),
          onPressed: acceptAction,
      ),
    ],
  );
}

// Saving And Loading ------------------------------------------------------------------------------
Future<void> save() async {
  File file = File("${(await getApplicationDocumentsDirectory()).path}/data.txt");
  file.createSync();

  file.writeAsStringSync(json.encode(lists.map((ShoppingList list) {
    return list.toJSON();
  }).toList()));
}

Future<void> load() async {
    File file = File("${(await getApplicationDocumentsDirectory()).path}/data.txt");

    String string = await file.readAsString();
    print(string);
    List<dynamic> data = json.decode(string);
    print(string);
    lists = data.map((dynamic t) {
      ShoppingList temp = ShoppingList();
      temp.loadJSON(t as String);
      return temp;
    }).toList();
}