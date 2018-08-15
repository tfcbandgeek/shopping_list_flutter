import 'package:flutter/material.dart';

import 'package:shopping_list/additional.dart';
import 'package:shopping_list/data.dart';
import 'package:shopping_list/myfab.dart';
import 'package:shopping_list/settings.dart';
import 'package:shopping_list/shoppinglist.dart';

// 0133, 0133

// Home View Classes -------------------------------------------------------------------------------
class ShoppingListHomePage extends StatefulWidget {
  ShoppingListHomePage({Key key, this.title}): super(key: key);
  final String title;

  @override
  _ShoppingListHomePageState createState() => _ShoppingListHomePageState();
}

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
        itemBuilder: _homeListItemBuilder,
      ),
      floatingActionButton: CustomFab(_addList, text: ADD, narrow: settings.narrowFab,
        background: Colors.teal, splash: Colors.tealAccent),
    );
  }
}

// Menu --------------------------------------------------------------------------------------------
enum HomeMenu {save, settings, about, export, import}

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
Padding _homeListItemBuilder(BuildContext context, int index) {
  return Padding(
    padding: EdgeInsets.only(
      left: 4.0,
      right: 4.0,
      top: 2.0,
      bottom: 2.0,
    ),
    child: Container(
      color: Color(0xFFB2DFDB),
      child: Padding(
        padding: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
          top: 2.0,
          bottom: 2.0,
        ),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                current = lists[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => ShoppingListView(),
                  fullscreenDialog: true,
                ));
              },
              child: Column(
                children: <Widget> [
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(lists[index].getTitle()),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(lists[index].note),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}