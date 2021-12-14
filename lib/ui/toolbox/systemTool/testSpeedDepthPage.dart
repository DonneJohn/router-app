import 'package:flutter/material.dart';
import 'package:hg_router/res/strings.dart';

///
///Created by slkk on 2019/8/30/0030 14:46
///

class TestSpeedDepthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestSpeedDepthPageState();
}

class TestSpeedDepthPageState extends State<TestSpeedDepthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Str.depthSpeed),
      ),
    );
  }
}
