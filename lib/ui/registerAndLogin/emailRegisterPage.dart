import 'package:flutter/material.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/registerAndLogin/loginPage.dart';
import 'package:hg_router/ui/registerAndLogin/phoneRegisterPage.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/api/emailRegisterApi.dart';
import 'package:hg_router/models/loginAndLogout/identifyingCodeModel.dart';
import 'package:hg_router/api/api.dart';
import 'package:hg_router/models/loginAndLogout/registerResponseModel.dart';

class EmailRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailRegisterPageState();
}

class _EmailRegisterPageState extends State<EmailRegisterPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerPwd = new TextEditingController();
  final TextEditingController _controllerIdenCode = new TextEditingController();
  String identifyingCodeUrl;
  bool isAgreeProtocol = false;

  void _userRegister(BuildContext context) async {
    print('userlogin');
    String email = _controllerName.text.toString();
    String password = _controllerPwd.text.toString();
    String code = _controllerIdenCode.text.toString();
    RegExp exp = RegExp(Constant.emailReg);
    bool matched = exp.hasMatch(_controllerName.text.toString());

    if (!isAgreeProtocol) {
      Util.showSnackBar(context, "请先同意用户协议");
      return;
    }
    if (email.isEmpty || email.length < 6) {
      Util.showSnackBar(context, email.isEmpty ? "请输入邮箱～" : "邮箱至少6位～");
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
    if (!matched) {
      Util.showSnackBar(context, "邮箱格式不合法");
      return;
    }

    RegisterResponseModel modle;
    var registerApi = new EmailRegisterApi();
    modle = await registerApi.doEmailRegister(email, password, code);
    //注册成功返回登录界面
    if (modle.code == 201) {
      _globalKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text("注册成功～,请到邮箱中激活账号后登录"),
      ));
      Future.delayed(new Duration(milliseconds: 3000), () {
        Navigator.pop(context);
      });
    } else if (modle.code == 403) {
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
                            "邮箱注册",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      )),
                  Gaps.vGap20,

                  ///邮箱
                  LoginItem(
                    controller: _controllerName,
                    prefixIcon: Icons.person,
                    hintText: Str.email,
                  ),
                  Gaps.vGap15,

                  ///密码
                  LoginItem(
                    controller: _controllerPwd,
                    prefixIcon: Icons.lock,
                    hasSuffixIcon: true,
                    hintText: Str.password,
                  ),
                  Gaps.vGap15,

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

                      ///验证码图片
                      GestureDetector(
                        onTap: () {
                          getCode(context);
                          print('tap');
                        },
                        child: Container(
                          height: 70,
                          width: 120,
                          child: (identifyingCodeUrl == null)
                              ? Image.asset(
                                  'assets/images/icon_photo_default.png')
                              : Image.network(identifyingCodeUrl),
                        ),
                      ),
                      Gaps.vGap15,
                    ],
                  ),

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
                                  builder: (context) => PhoneRegisterPage()));
                        },
                        child: Text(
                          '手机号注册',
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
}
