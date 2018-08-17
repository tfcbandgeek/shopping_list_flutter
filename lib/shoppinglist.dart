import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shopping_list/additional.dart';
import 'package:shopping_list/data.dart';
import 'package:shopping_list/myfab.dart';
import 'package:shopping_list/settings.dart';
import 'package:shopping_list/tags.dart';

// Data --------------------------------------------------------------------------------------------
/// Marked true when the data has been changed on this page
bool edited = false;

// Shopping List View Classes ----------------------------------------------------------------------
/// ShoppingListView
/// The Root View for the ShoppingList
class ShoppingListView extends StatefulWidget {
  @override
  _ShoppingListViewState createState() {
    return _ShoppingListViewState();
  }
}

/// ShoppingListViewState
/// The State of the ShoppingListViewState, (Internal)
class _ShoppingListViewState extends State<ShoppingListView> {
  TextEditingController t = TextEditingController(text: current.title);
  TextEditingController n = TextEditingController(text: current.note);

  Future<bool> _onWillPop() async {
    if (edited) save();
    return true;
  }

  void _setState(Function action) {
    setState(() {
      action();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(current.getTitle()),
        actions: _buildMenuActions(context),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              onWillPop: _onWillPop,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: TITLE,
                      filled: true,
                    ),
                    onChanged: (text) {
                      edited = true;
                      current.title = text;
                    },
                    controller: t,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: NOTES,
                      filled: true,
                    ),
                    maxLines: null,
                    onChanged: (text) {
                      edited = true;
                      current.note = text;
                    }, controller: n,
                  ),
                ],
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool expanded) {
                setState(() {
                  current.items[index].expanded = !current.items[index].expanded;
                });
              },
              children: current.items.map((ShoppingItem item) {
                return _buildShoppingListItem(context, item, _setState);
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFab(() {
        setState(() {
          edited = true;
          current.addItem();
          current.items.last.expanded = true;
        });
      }, text: ADD, narrow: settings.narrowFab,
          background: Colors.teal, splash: Colors.tealAccent),
    );}
}

// Shopping List Menu ------------------------------------------------------------------------------
/// Enum for the Options Menu
enum ShoppingMenu { image, tags }

/// Function used to build the ShoppingListOptions Menu Items
List<Widget> _buildMenuActions(BuildContext context) {
  return <Widget>[
    FlatButton(
        child: Text(
          SAVE,
          style: TextStyle(color: SECONDARY_TEXT),
        ),
        onPressed: () {
          edited = false;
          save();
        }
    ),
    FlatButton(
      child: Text(
        DELETE,
        style: TextStyle(color: SECONDARY_TEXT),
      ),
      onPressed: () {
        lists.remove(current);
        current = null;
        Navigator.pop(context);
      },
    ),
    PopupMenuButton<ShoppingMenu>(
      onSelected: (ShoppingMenu menu) {
        if (menu == ShoppingMenu.image) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Edit Image Pressed"),
            duration: Duration(seconds: 3),
          ));
        } else if (menu == ShoppingMenu.tags) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Edit the Tags"),
            duration: Duration(seconds: 3),
          ));
        }
      },
      itemBuilder: (BuildContext context) => const <PopupMenuItem<ShoppingMenu>>[
        PopupMenuItem<ShoppingMenu>(
          value: ShoppingMenu.image,
          child: Text(EDIT_ICON),
        ),
        PopupMenuItem<ShoppingMenu>(
          value: ShoppingMenu.tags,
          child: Text(EDIT_TAGS),
        )
      ],
    ),
  ];
}

// ShoppingList List Builder -----------------------------------------------------------------------
/// Function for building the Shopping List
ExpansionPanel _buildShoppingListItem(BuildContext context, ShoppingItem item, Function setState) {
  return ExpansionPanel(
    headerBuilder: (BuildContext context, bool expanded) {
      return Container(
        child: Row(
          children: <Widget>[
            Checkbox(
              onChanged: (bool status) {
                setState(() {
                  edited = true;
                  item.checked = !item.checked;
                });
              },
              value: item.checked,
            ),
            Text(item.getTitle()),
            Spacer(),
            FlatButton(
                child: Icon(
                  Icons.delete_forever,
                  color: PRIMARY,
                ),
                onPressed: () {
                  setState(() {
                    current.items.remove(item);
                  });
                }
            ),
          ],
        ),
      );
    },
    body: Column(
      children: <Widget>[
        TextField(
          decoration: const InputDecoration(
            labelText: TITLE,
            filled: true,
          ),
          onChanged: (text) {
            edited = true;
            item.title = text;
          },
          controller: item.getTitleController(),
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: NOTES,
            filled: true,
          ),
          onChanged: (text) {
            edited = true;
            item.notes = text;
          },
          controller: item.getNoteController(),
        ),
        TagsWidget(item.tags),
        RawMaterialButton(
          fillColor: PRIMARY,
          splashColor: PRIMARY_SPLASH,
          shape: const StadiumBorder(),
          child: Text(
              ADD_A_TAG,
              style: TextStyle(color: SECONDARY_TEXT)),
          onPressed: () async {

          },
        ),
      ],
    ),
    isExpanded: item.expanded,
  );
}