import 'package:flutter/material.dart';
// This file Contains all the necessary classes needed to operate a tag system. As of the current
// moment it is still very experimental.


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