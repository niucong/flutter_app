import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AMapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AMapViewState();
  }
}

class AMapViewState extends State<AMapView> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter AMapView',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('AMapView'),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: AndroidView(viewType: 'AMapView',),
            ),
          ],
        ),
      ),
    );
  }
}