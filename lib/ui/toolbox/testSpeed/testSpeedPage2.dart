import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///Created by slkk on 2019/9/28/0028 11:18
///
class TestSpeedPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestSpeedPage2State();
}

class _TestSpeedPage2State extends State<TestSpeedPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('深度测速'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('路由器连接到互联网'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getWidget("000.0", "MB/S"),
                getWidget("000.0", "MB/S"),
                getWidget("000.0", "MB/S")
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Text('手机连接到互联网'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getWidget("000.0", "MB/S"),
                getWidget("000.0", "MB/S"),
                getWidget("000.0", "MB/S")
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.phone_android,
                  size: 50,
                  color: Colors.blue,
                ),
                Icon(Icons.more_horiz, size: 50, color: Colors.blue),
                Icon(Icons.router, size: 50, color: Colors.blue),
                Icon(Icons.more_horiz, size: 50, color: Colors.blue),
                Icon(FontAwesomeIcons.internetExplorer,
                    size: 50, color: Colors.blue)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getWidget(String title, String subtitle) {
    return Column(
      children: <Widget>[Text(title), Text(subtitle)],
    );
  }
}
