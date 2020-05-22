import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widget/node.dart';

class NodeWidget extends StatefulWidget {
  NodeWidget({Key key, this.node}) : super(key: key);
  final Node node;

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
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
          print(showList);
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
            padding: EdgeInsets.only(left: 20),
            child: children,
          )
        ],
      );
    } else {
      return me;
    }
  }

  Widget formWidget(Widget me) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: !showList ? 0 : 90 / 180 * pi,
            child: Icon(Icons.arrow_right),),
          me]
    );
  }
}
