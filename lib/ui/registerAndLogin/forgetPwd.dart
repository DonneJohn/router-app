import 'package:flutter/material.dart';
import 'package:hg_router/api/api.dart';
import 'package:hg_router/api/emailRegisterApi.dart';
import 'package:hg_router/api/resetPwdApi.dart';
import 'package:hg_router/models/loginAndLogout/identifyingCodeModel.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/registerAndLogin/resetPhonePwdPage.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/res/strings.dart';

import '../../main.dart';

class ForgetPwdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgetPwdPageState();
}

class _ForgetPwdPageState extends State<ForgetPwdPage> {
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerIdenCode = new TextEditingController();
  String identifyingCodeUrl;

  void _resetPwd(BuildContext context) {
    print('resetPwd');
    String email;
    String code;
    if (_controllerName.text.isEmpty || _controllerIdenCode.text.isEmpty) {
      Util.showSnackBar(context, "邮箱或者验证码不能为空");
      return;
    }
    email = _controllerName.text.toString();
    code = _controllerIdenCode.text.toString();

    var resetPwdApi = ResetPwdApi();
    resetPwdApi.resetPwd(email, code).then((onResponse) {
      if (onResponse.code == 202) {
        logger.i('发送重置邮件成功');
        Util.showSnackBar(context, "发送重置邮件成功～");
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else if (onResponse.code == 400) {
        Util.showSnackBar(context, "邮箱不存在");
      } else {
        Util.showSnackBar(context, "重置失败～");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => Column(
          children: <Widget>[
            new Expanded(
                child: new Container(
              margin: EdgeInsets.only(left: 20, top: 100, right: 20),
              child: new Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          Str.forgetPwdTitle,
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap20,
                  LoginItem(
                    controller: _controllerName,
                    prefixIcon: Icons.person,
                    hintText: Str.email,
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

                      ///验证码图片
                      GestureDetector(
                        onTap: () {
                          getCode();
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
                  Gaps.vGap15,
                  GradientButton(
                    text: Str.resetPwd,
                    margin: EdgeInsets.only(left: 10, top: 30, bottom: 30),
                    onPressed: () {
                      _resetPwd(context);
                    },
                  ),
                  Gaps.vGap15,
                  FlatButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPhonePwdPage()));
                    },
                    child: Text(
                      "重置手机账号密码",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  getCode() async {
    IdentifyingCodeModel modle;
    var registerApi = new EmailRegisterApi();
    modle = await registerApi.getIdentifyingCode();
    setState(() {
      identifyingCodeUrl = Api.baseUrl + modle.data.code;
      print(identifyingCodeUrl);
    });
    print("code : $identifyingCodeUrl");
  }
}
