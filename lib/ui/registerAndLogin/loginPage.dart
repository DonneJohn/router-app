import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/queryBindListApi.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/loginAndLogout/getBindListResponseModel.dart';
import 'package:hg_router/models/loginAndLogout/loginResponseModel.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/api/loginApi.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerPwd = new TextEditingController();

  void _userLogin(BuildContext context) async {
    print('userlogin');
    String user = _controllerName.text.toString();
    String password = _controllerPwd.text.toString();
    RegExp emailExp = RegExp(Constant.emailReg);
    RegExp phoneExp = RegExp(Constant.cellPhoneReg);

    if (user.isEmpty || user.length < 6) {
      Util.showSnackBar(context, user.isEmpty ? "请输入邮箱～" : "用户名至少6位～");
      return;
    }
    if (password.isEmpty || password.length < 6) {
      Util.showSnackBar(context, password.isEmpty ? "请输入密码～" : "密码至少6位～");
      return;
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var loginApi = LoginApi();
      LoginResponseModel model;
      if (emailExp.hasMatch(user)) {
        model = await loginApi.doEmailLogin(user, password);
      } else if (phoneExp.hasMatch(user)) {
        model = await loginApi.doPhoneLogin(user, password);
        logger.d("login after ${model.toString()}");
      } else {
        Util.showSnackBar(context, "邮箱或者手机号格式不合法");
        return;
      }
      logger.d(model.code);
      if (model != null && model.code == 200) {
        SpUtil.putString(Constant.keyAppToken, model.data.token);
        SpUtil.putString(Constant.keyUserName, user);
        SpUtil.putString(Constant.appUUID, model.data.uuid);
        SpUtil.putString(Constant.clinetid, model.data.clientid);
        Util.showSnackBar(context, "登录成功～");

        Future.delayed(new Duration(milliseconds: 500), () {
          RouteUtil.goMain(context);
        });
      } else if (model.code == 401) {
        Util.showSnackBar(context, "用户名或者密码错误");
      } else {
        Util.showSnackBar(context, "登录失败～");
      }
    } else {
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("网络异常"),
      ));
      logger.d("Network not connect");
      return;
    }
  }

  void getBindDeviceList() async {
    GetBindListResponseModel bindList = await QueryBindListApi().getBindList();
    if (bindList.code == 200) {
      SpUtil.putObjectList(Constant.bindDeviceList, bindList.data);

      if (bindList.data.length != 0) {
        ///拿到设备列表，选取第一个为当前设备///TODO 如何知道是当前设备,去访问当前的路由器拿取他的mac
        SpUtil.putString(Constant.routerUUID, bindList.data[0].uuid);
        SpUtil.putString(Constant.routerMac, bindList.data[0].mac);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Image.asset("assets/images/loginBackground.png"),

            ///注册账号
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 20, 0),
              child: FlatButton(
                onPressed: () {
                  RouteUtil.goRegister(context);
                },
                child: Text(
                  Str.registerAccount,
                  style: ITextStyles.pageTitleStyle,
                ),
              ),
            ),

            Column(
              children: <Widget>[
                new Expanded(
                    child: new Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  margin: EdgeInsets.only(top: 200),
                  child: new Column(
                    children: <Widget>[
                      ///登录
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              Str.login,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Gaps.vGap15,

                      ///邮箱
                      LoginItem(
                        controller: _controllerName,
                        prefixIcon: Icons.person,
                        hintText: "邮箱/手机号",
                      ),
                      Gaps.vGap15,

                      ///密码
                      LoginItem(
                        controller: _controllerPwd,
                        prefixIcon: Icons.lock,
                        hasSuffixIcon: true,
                        hintText: Str.password,
                      ),

                      ///登录
                      GradientButton(
                        text: Str.login,
                        onPressed: () {
                          _userLogin(context);
                        },
                      ),
                      Gaps.vGap15,
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[Text('or'), Divider()],
//                      ),
                      Text("or"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ///忘记密码
                          FlatButton(
                            onPressed: () {
//                          Util.showSnackBar(context, Str.forgetPwd);
                              RouteUtil.goForgetPwd(context);
                            },
                            child: Text(Str.forgetPwd,
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
