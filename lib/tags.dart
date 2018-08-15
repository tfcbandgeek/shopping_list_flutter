import 'package:flutter/material.dart';

// 102, 0243

// Tag List Chips ----------------------------------------------------------------------------------
class TagsWidget extends StatefulWidget {
  final List<String> tags;
  final bool avatar;

  TagsWidget(this.tags, {Key key, this.avatar = false}): super(key: key);

  @override
  _TagsWidgetState createState() {
    return _TagsWidgetState();
  }
}

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

// Tag Selection Dialog ----------------------------------------------------------------------------
class TagSelectionDialogWidget extends StatefulWidget {
  final Function onResponse;
  final List<String> all;
  final List<String> selected;

  TagSelectionDialogWidget(this.onResponse, this.all, this.selected);

  @override
  _TagSelectionDialogState createState() {
    return _TagSelectionDialogState();
  }
 }

 class _TagSelectionDialogState extends State<TagSelectionDialogWidget> {
  List<String> _all;
  List<String> _selected;

  void addTag(String tag) {
    setState(() {
      _all.add(tag);
      _selected.add(tag);
    });
  }

  void selectTag(String tag) {
    setState(() {
      _selected.add(tag);
    });
  }

  void unselectTag(String tag) {
    setState(() {
      _selected.remove(tag);
    });
  }

  bool checkExists(String tag) {
    return _all.contains(tag);
  }

  bool checkSelected(String tag) {
    return _selected.contains(tag);
  }

  _TagSelectionDialogState() {
    _all = List();
    _selected = List();

    if (widget.all.length != 0) {
      for (var item in widget.all) {
        _all.add(item);
      }
    }

    if (widget.selected.length != 0) {
      for (var item in widget.selected) {
        _selected.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TagSelectionAdderWidget(addTag, selectTag, checkExists, checkSelected),
        ListView.builder(
          itemCount: _all.length,
          itemBuilder: (BuildContext context, int position) {
            return _TagSelectionListItemWidget(selectTag, unselectTag, _selected.contains(_all[position]), _all[position]);
          },
        ),
      ],
    );
  }
 }

 class _TagSelectionAdderWidget extends StatefulWidget {
  final Function add;
  final Function select;
  final Function checkExists;
  final Function checkSelected;

  _TagSelectionAdderWidget(this.add, this.select, this.checkExists, this.checkSelected);

  @override
  _TagSelectionAdderState createState() {
    return _TagSelectionAdderState();
  }
 }

 class _TagSelectionAdderState extends State<_TagSelectionAdderWidget> {
   TextEditingController t = TextEditingController();
  String add = "";

  @override
   Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 2.0,
        bottom: 2.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Create Tag",
                filled: true,
              ),
              onChanged: (text) {
                add = text;
              },
              controller: t,
            ),
          ),
          RaisedButton(
            child: Text("Add"),
            onPressed: () {
              if (widget.checkExists()) {
                if (!widget.checkSelected()) {
                  setState(() {
                    widget.select(add);
                    t.clear();
                  });
                }
              } else {
                setState(() {
                  widget.add(add);
                  t.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }
 }

 class _TagSelectionListItemWidget extends StatefulWidget {
  final bool selected;
  final String tag;

  final Function select;
  final Function unselect;

  _TagSelectionListItemWidget(this.select, this.unselect, this.selected, this.tag);

  @override
   _TagSelectionListItemState createState() {
    return _TagSelectionListItemState();
  }
 }

 class _TagSelectionListItemState extends State<_TagSelectionListItemWidget> {
  @override
   Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 2.0,
        bottom: 2.0,
      ),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: widget.selected,
            onChanged: (newValue) {
              setState(() {
                if (newValue) widget.select(widget.tag);
                else widget.unselect(widget.tag);
              });
            },
          ),
          Text(widget.tag),
        ],
      ),
    );
  }
 }