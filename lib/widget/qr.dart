import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/util/show_util.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScan extends StatefulWidget {
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  String barcode = "";

  @override
  initState() {
    super.initState();
    showToast(barcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("二维码"),
        actions: <Widget>[
          // 非隐藏的菜单
          new IconButton(
            icon: new Icon(Icons.photo_camera),
            tooltip: '扫码',
            onPressed: scan,
          ),
        ],
      ),
      body: _createBody(),
    );
  }

  Future scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() => this.barcode = barcode);
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Widget _createBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: QrImage(
            data: "Flutter生成二维码文字",
            //生成二维码的文字
            size: 200.0,
            //生成二维码大小
//            embeddedImage: AssetImage("images/image_logo_wechat.png"),//二维码中心图片
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(30, 30), //二维码中心图片大小
            ),
          ),
        )
      ],
    );
  }
}
