import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/30/0030 15:58
///
class AboutUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "关于我们",
      ),
      body: Center(child: Text("公司信息介绍")),
    );
  }
}
