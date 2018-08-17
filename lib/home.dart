import 'package:flutter/material.dart';

import 'package:shopping_list/additional.dart';
import 'package:shopping_list/data.dart';
import 'package:shopping_list/myfab.dart';
import 'package:shopping_list/settings.dart';
import 'package:shopping_list/shoppinglist.dart';

// Home View Classes -------------------------------------------------------------------------------
/// ShoppingListHomePage
/// The HomeView of the Application
class ShoppingListHomePage extends StatefulWidget {
  ShoppingListHomePage({Key key, this.title}): super(key: key);
  final String title;

  @override
  _ShoppingListHomePageState createState() => _ShoppingListHomePageState();
}

/// ShoppingListHomePageState
/// The State for the Home Page, (Internal)
class _ShoppingListHomePageState extends State<ShoppingListHomePage> {
  void _addList() {
    setState(() {
      current = ShoppingList();
      lists.add(current);
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => ShoppingListView(),
        fullscreenDialog: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: _buildMenuActions(context),
      ),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeListItem(lists[index]);
        },
      ),
      floatingActionButton: CustomFab(_addList, text: ADD, narrow: settings.narrowFab,
        background: Colors.teal, splash: Colors.tealAccent),
    );
  }
}

// Menu --------------------------------------------------------------------------------------------
/// Home Menu Enum for the various options
enum HomeMenu {save, settings, about, export, import}

/// Method to build the Home Options MEnu
List<Widget> _buildMenuActions(BuildContext context) {
  return <Widget>[
    PopupMenuButton<HomeMenu>(
      onSelected: (HomeMenu state) {
        if (state == HomeMenu.settings) Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingsView()));
        else if (state == HomeMenu.save) save();
        else if (state == HomeMenu.about) Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AboutView()));
      },
      itemBuilder: (BuildContext context) => const <PopupMenuItem<HomeMenu>>[
        PopupMenuItem<HomeMenu>(
          value: HomeMenu.save,
          child: Text(SAVE),
        ),
        PopupMenuItem<HomeMenu>(
          value: HomeMenu.settings,
          child: Text(SETTINGS),
        ),
        PopupMenuItem<HomeMenu>(
            value: HomeMenu.about,
            child: Text(ABOUT)
        ),
      ],
    ),
  ];
}

// Home List ItemBuilder ---------------------------------------------------------------------------
/// HomeListItem
/// The Widget used to show each of the ShoppingLists
class HomeListItem extends StatelessWidget {
  final ShoppingList _shoppingList;

  HomeListItem(this._shoppingList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.0,
        right: 4.0,
      ),
      child: GestureDetector(
        onTap: () {
          current = _shoppingList;
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => ShoppingListView(),
            fullscreenDialog: true,
          ));
        },
        child: Card(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Text(_shoppingList.getTitle()),
                Spacer(),
                Text(_shoppingList.getUnGrabbedListItems().toString() + "/" + _shoppingList.items.length.toString() + "Left"),
              ]),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_shoppingList.note),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}