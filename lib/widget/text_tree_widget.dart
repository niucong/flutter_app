import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/util/event_bus.dart';

import 'node.dart';

typedef void OnClickCallback(arg);

class TextTreeWidget extends StatefulWidget {
  TextTreeWidget({Key key, this.node, this.onClickCallback}) : super(key: key);
  final Node node;
  final OnClickCallback onClickCallback;

  factory TextTreeWidget.fromStr(String me, List<String> children) {
    return TextTreeWidget(
        node: Node(
      me: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          me,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20.0,
          ),
        ),
      ),
      children: children
          .map((e) => Node(
                  me: InkWell(
                onTap: () {
                  bus.emit("enterPage", e);
                },
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )))
          .toList(),
    ));
  }

  @override
  _TextTreeWidgetState createState() => _TextTreeWidgetState();
}

class _TextTreeWidgetState extends State<TextTreeWidget> {
  Node node;
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return showNode(widget.node, showList);
  }

  Widget showNode(Node node, bool show) {
    var me = InkWell(
        child: formWidget(node.me),
        onTap: () {
          showList = !showList;
          if (widget.onClickCallback != null) {
            widget.onClickCallback(!showList);
          }
          setState(() {});
        });
    if (show) {
      var children = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: node.children.map((node) => node.me).toList(),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          me,
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: children,
          ),
        ],
      );
    } else {
      return me;
    }
  }

  Widget formWidget(Widget me) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: !showList ? 0 : 90 / 180 * pi,
            child: Icon(Icons.arrow_right),
          ),
          me
        ]);
  }
}
