import 'package:flutter/material.dart';
import 'package:hg_router/common/common.dart';

import 'SpUtil.dart';
import 'objectUtil.dart';

class Util {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      BuildContext context, String msg) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showCircularSnackBar(BuildContext context, String msg) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 1),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text("$msg")
            ],
          )),
    );
  }

  static bool isLogin() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(Constant.keyAppToken));
  }

  static bool isBind() {

    return ObjectUtil.isNotEmpty(SpUtil.getObjectList(Constant.bindDeviceList));
  }
}

class RouteUtil {
  static void goMain(BuildContext context) {
//    Navigator.of(context).popAndPushNamed(Constant.routeMain);
    pushReplacementNamed(context, Constant.routeMain);
  }

  static void goLogin(BuildContext context) {
    pushNamed(context, Constant.routeLogin);
  }

  static void goRegister(BuildContext context) {
    Navigator.of(context).popAndPushNamed(Constant.routeRegister);
  }

  static void goForgetPwd(BuildContext context) {
    pushNamed(context, Constant.routeForgetPwd);
  }

  static void pushNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushNamed(pageName);
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }
}
