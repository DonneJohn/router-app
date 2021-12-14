import 'package:flutter/material.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    SpUtil.getInstance();

    String nextRouter;
    if (Util.isLogin()) {
      ///已登录跳转到首页
      nextRouter = Constant.routeMain;
    } else {
      ///未登录到登录页
      nextRouter = Constant.routeLogin;
    }

    ///默认展示2秒启动图。
    Future.delayed(new Duration(milliseconds: 2000), () async {
      RouteUtil.pushReplacementNamed(context, nextRouter);
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d("splash page build");
    return new Scaffold(
      body: new ConstrainedBox(
        child: new Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.fill,
        ),
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}
