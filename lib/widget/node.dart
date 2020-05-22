import 'package:flutter/cupertino.dart';

///记录节点信息的Node类
class Node {
  Widget me; //节点自身Widget
  List<Node> children; //节点所包含的Node
  Node({this.me, this.children});
}
