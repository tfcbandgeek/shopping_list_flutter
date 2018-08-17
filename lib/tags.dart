import 'package:flutter/material.dart';
// This file Contains all the necessary classes needed to operate a tag system. As of the current
// moment it is still very experimental.

String tagsVersion = "0.1.0";
int version = 1;

// Tag List ----------------------------------------------------------------------------------------
/// TaqWidget
/// This class is used to display a grid like patterns of tags which can be removed. (Currently untested)
class TagsWidget extends StatefulWidget {
  // The selected Tags
  final List<String> tags;
  // Display Tag Avatars, (NYI)
  final bool avatar;

  TagsWidget(this.tags, {Key key, this.avatar = false}): super(key: key);

  @override
  _TagsWidgetState createState() {
    return _TagsWidgetState();
  }
}

/// TagWidgetState
/// The State for the TagWidget, Internal class
class _TagsWidgetState extends State<TagsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.tags.map((String tag) {
        return Padding(
          padding: EdgeInsets.only(left: 2.0, right: 2.0),
          child: Chip(
            label: Text(tag),
            onDeleted: () {
              setState(() {
                widget.tags.remove(tag);
              });
            },
          ),
        );
      }).toList(),
    );
  }
}

// Tag Editing Dialog ------------------------------------------------------------------------------
AlertDialog buildAlertDialog(BuildContext context, List<String> selectedTags, List<String> allTags, Function updateTags) {
  return AlertDialog(
    content: Column(
      children: <Widget>[

      ],
    ),
    actions: <Widget>[
      FlatButton(
        child: Text("Cancel"),
        onPressed: () {},
      ),
      FlatButton(
        child: Text("Save"),
        onPressed: updateTags(selectedTags),
      ),
    ],
  );
}

class _TagSearchAndAddWidget extends StatefulWidget {
  final TextEditingController t = TextEditingController(text: "");
  @override
  _TagSearchAndAddState createState() {
    return _TagSearchAndAddState();
  }
}
class _TagSearchAndAddState extends State<_TagSearchAndAddWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Search",
        filled: true,
      ),
      controller: widget.t,
      onSubmitted: (String temp) {

      },
    );
  }
}

class _TagListWidget extends StatefulWidget {
  @override
  _TagListState createState() {
    _TagListState();
  }
}

class _TagListState extends State<_TagListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

    );
  }
}