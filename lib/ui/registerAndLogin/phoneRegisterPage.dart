import 'dart:async';

///
///Created by slkk on 2019/11/7/0007 11:43
///
import 'package:flutter/material.dart';
import 'package:hg_router/api/getPhoneCodeApi.dart';
import 'package:hg_router/api/phoneRegisterApi.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/registerAndLogin/emailRegisterPage.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/api/emailRegisterApi.dart';
import 'package:hg_router/models/loginAndLogout/identifyingCodeModel.dart';
import 'package:hg_router/api/api.dart';
import 'package:hg_router/models/loginAndLogout/registerResponseModel.dart';

import 'loginPage.dart';

class PhoneRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhoneRegisterPageState();
}

class _PhoneRegisterPageState extends State<PhoneRegisterPage> {
  RegExp exp = RegExp(Constant.cellPhoneReg);
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerPwd = new TextEditingController();
  final TextEditingController _controllerIdenCode = new TextEditingController();
  String identifyingCodeUrl;
  bool isAgreeProtocol = false;

  Timer _timer;
  int _countdownTime = 0;

  void _userRegister(BuildContext context) async {
    print('userlogin');
    String photoNumber = _controllerName.text.toString();
    String password = _controllerPwd.text.toString();
    String code = _controllerIdenCode.text.toString();

    if (!isAgreeProtocol) {
      Util.showSnackBar(context, "请先同意用户协议");
      return;
    }
    if (password.isEmpty || password.length < 6) {
      Util.showSnackBar(context, password.isEmpty ? "请输入密码～" : "密码至少6位～");
      return;
    }
    if (code.isEmpty) {
      Util.showSnackBar(context, "请输入验证码");
      return;
    }

    RegisterResponseModel responseModel;
    var registerApi = new PhoneRegisterApi();
    responseModel =
        await registerApi.doPhoneRegister(photoNumber, password, code);

    ///注册成功返回登录界面
    if (responseModel.code == 201) {
      _globalKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text("注册成功～,请登录"),
      ));
      Future.delayed(new Duration(milliseconds: 3000), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else if (responseModel.code == 403) {
      ///验证验证码
      Util.showSnackBar(context, "请输入正确的验证码");
    } else {
      Util.showSnackBar(context, "注册失败");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCode(context));
  }

  getCode(BuildContext context) async {
    IdentifyingCodeModel modle;
    var registerApi = new EmailRegisterApi();
    modle = await registerApi.getIdentifyingCode();
    setState(() {
      if (modle.code == 201) {
        ///服务器返回201 成功
        identifyingCodeUrl = Api.baseUrl + modle.data.code;
      } else {
        Future.delayed(new Duration(milliseconds: 2000), () {
          _globalKey.currentState.showSnackBar(SnackBar(content: Text("出错了")));
        });
      }
    });
    logger.d("code : $identifyingCodeUrl");
  }

  @override
  Widget build(BuildContext context) {
    print('build,RegisterPage');
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => Column(
          children: <Widget>[
            new Expanded(
                child: new Container(
              margin: EdgeInsets.only(left: 20, top: 50, right: 20),
              child: new Column(
                children: <Widget>[
                  ///注册
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "手机号注册",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      )),
                  Gaps.vGap20,

                  ///手机号
                  LoginItem(
                    controller: _controllerName,
                    prefixIcon: Icons.person,
                    hintText: "手机号",
                  ),

                  Row(
                    children: <Widget>[
                      ///验证码
                      Expanded(
                        child: Container(
                          child: LoginItem(
                            controller: _controllerIdenCode,
                            prefixIcon: Icons.image,
                            hintText: Str.identifyingCode,
                          ),
                          width: 200,
                        ),
                      ),

                      Gaps.vGap15,

                      ///点击获取验证码图片
                      OutlineButton(
                        child: Text(
                          _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
                          style: TextStyle(
                            fontSize: 14,
                            color: _countdownTime > 0
                                ? Color.fromARGB(255, 183, 184, 195)
                                : Color.fromARGB(255, 17, 132, 255),
                          ),
                        ),
                        onPressed: () {
                          if (_controllerName.text.isEmpty) {
                            _globalKey.currentState.showSnackBar(SnackBar(
                              content: Text("请输入手机号"),
                            ));
                            return;
                          }
                          if (!exp.hasMatch(_controllerName.text.toString())) {
                            _globalKey.currentState.showSnackBar(SnackBar(
                              content: Text("请输入合法的手机号"),
                            ));
                            return;
                          }

                          if (_countdownTime == 0) {
                            getPhoneNumber(_controllerName.text.toString());
                            setState(() {
                              _countdownTime = 60;
                            });
                            //开始倒计时
                            startCountdownTimer();
                          }
                        },
                      )
                    ],
                  ),

                  ///密码
                  LoginItem(
                    controller: _controllerPwd,
                    prefixIcon: Icons.lock,
                    hasSuffixIcon: true,
                    hintText: Str.password,
                  ),
                  Gaps.vGap15,

                  ///注册代表同意
                  Row(
                    children: <Widget>[
                      Checkbox(
                        onChanged: (onValue) {
                          setState(() {
                            isAgreeProtocol = onValue;
                          });
                        },
                        value: isAgreeProtocol,
                        activeColor: Color.fromARGB(255, 44, 185, 176),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 20,
                          width: 120,
                          child: Container(
                            child: Text(Str.tianyiRouteUserPolicy,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///注册
                  new GradientButton(
                    text: Str.register,
                    onPressed: () {
                      _userRegister(context);
                    },
                  ),
                  Gaps.vGap15,
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmailRegisterPage()));
                        },
                        child: Text(
                          '邮箱注册',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String number) async {
    GetPhoneCodeApi api = GetPhoneCodeApi();
    MyDioResponse response = await api.getPhoneCode(number);
    if (response.response.statusCode == 201) {}
  }

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      });
    };

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
