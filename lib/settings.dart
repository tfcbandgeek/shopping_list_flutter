import "dart:async";

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shopping_list/additional.dart';
// All of the Settings data and Views

// Data --------------------------------------------------------------------------------------------
Settings settings = Settings();

// Data Class --------------------------------------------------------------------------------------
class Settings {
  SharedPreferences prefs;
  bool narrowFab = false;

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    try {
      narrowFab = prefs.getBool("narrowFab");
    } catch(Exception) {
      narrowFab = true;
    }
  }

  void setNarrowFab(bool value) async {
    narrowFab = value;
    prefs.setBool("narrowFab", narrowFab);
  }
}

// Setting View Classes ----------------------------------------------------------------------------
class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() {
    return _SettingsViewState();
  }
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SETTINGS),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children: <Widget>[
                Text(NARROW_FAB_SETTING),
                Spacer(),
                Switch(
                  value: settings.narrowFab,
                  onChanged: (bool value) {
                    setState(() {
                      settings.setNarrowFab(!settings.narrowFab);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// About View Classes ------------------------------------------------------------------------------
class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() {
    return _AboutViewState();
  }
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ABOUT),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Shopping List"),
            Text("Version: $VERSION"),
            Text("Build: $BUILD"),
          ],
        ),
      ),
    );
  }
}