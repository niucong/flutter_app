import 'package:flutter/material.dart';
import 'package:flutterapp/util/event_bus.dart';
import 'package:flutterapp/util/show_util.dart';
import 'package:flutterapp/widget/battery.dart';
import 'package:flutterapp/widget/map_view.dart';
import 'package:flutterapp/widget/text_tree_widget.dart';

import 'widget/node.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'FlutterAPP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    bus.on("enterPage", (arg) {
      showToast(arg);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AMapView();
      }));
    });

//    var friendsNode=[
//      Node(me: Text("张三丰")),
//      Node(me: Text("独孤九剑")),
//      Node(me: Text("令狐冲")),
//      Node(me: Text("魏无羡")),
//    ];
//    var node = Node(me: Text("我的好友",),
//        children: [
//          Node(me: NodeWidget(node: Node(me: Text("损友",), children: friendsNode))),
//          Node(me: Text("好友")),
//          Node(me: Text("道友",)),
//          Node(me: Text("漫友",)),
//          Node(me: Text("普友",)),
//        ]);
//    var show = NodeWidget(node: node,);

    var node = Node(me: fristWidget("我的好友"), children: [
      Node(me: TextTreeWidget.fromStr("损友", ["张三丰", "独孤九剑", "令狐冲", "魏无羡"])),
      Node(me: TextTreeWidget.fromStr("好友", ["西施", "杨玉环", "王昭君", "貂蝉"])),
      Node(me: TextTreeWidget.fromStr("道友", [])),
      Node(
        me: fristWidget("漫友"),
      ),
      Node(
        me: fristWidget("普友"),
      ),
      Node(
        me: fristWidget("跑友"),
      ),
    ]);

    var show = TextTreeWidget(
      node: node,
      onClickCallback: (closed) {
        print(closed);
      },
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: show,
//        child: Column(
//          children: <Widget>[
//            show,
//            show,
//            show,
//          ],
//        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NativeSamples();
          }));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget fristWidget(String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
