import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/modifyAdminPwd/modifyAdminPwdBloc.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/29/0029 16:26
///
class ModifyAdminPwdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifyAdminPwdPageState();
}

class _ModifyAdminPwdPageState extends State<ModifyAdminPwdPage> {
  var pwdControl = TextEditingController();
  var repeatPwdControl = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: key,
      appBar: MyAppBar(
        title: "管理员密码设置",
        preferredSize: Size(double.infinity, 100),
        action: <Widget>[
          FlatButton(
            onPressed: () {
              modifyPwd();
            },
            child: Text(
              '保存',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "新密码:",
                      style: ITextStyles.pageTextStyle,
                    ),
                  ),
                  Gaps.hGap10,
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: pwdControl,
                      decoration: InputDecoration(),
                    ),
                  )
                ],
              ),
              Gaps.vGap20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "确认密码:",
                      style: ITextStyles.pageTextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: repeatPwdControl,
                      decoration: InputDecoration(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _setPwd(String pwd) {
    var bloc = ModifyAdminPwdBloc();
    bloc.setPwd(pwd);
    bloc.subject.listen((onData) {
      key.currentState.removeCurrentSnackBar();
      if (onData.return_parameter.status == "0") {
        key.currentState.showSnackBar(SnackBar(
          content: Text("设置成功"),
        ));
        return;
      }else{
        key.currentState.showSnackBar(SnackBar(
            content: Text("设置失败")));
      }
    });

  }

  modifyPwd() {
    key.currentState.removeCurrentSnackBar();
    key.currentState.showSnackBar(SnackBar(
      content: Container(
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Gaps.hGap10,
            Text("请稍后")
          ],
        ),
      ),
    ));
    String pwd = pwdControl.text.toString();
    String repeatPwd = repeatPwdControl.text.toString();
    if (pwd != repeatPwd) {
      key.currentState.showSnackBar(SnackBar(content: Text("密码不一致")));
      return;
    }
    _setPwd(pwd);
  }
}
