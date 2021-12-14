import 'package:flutter/material.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/utils/utils.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuidePageState();
  }
}

class _GuidePageState extends State<GuidePage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Image.asset(
          'assets/images/guide.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void _init() {
    Future.delayed(new Duration(milliseconds: 3000), () {
      RouteUtil.pushReplacementNamed(context, Constant.routeLogin);
    });
  }
}
