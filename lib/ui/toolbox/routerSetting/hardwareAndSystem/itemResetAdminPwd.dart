import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/resetAdminPasswordBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/utils/utils.dart';

class ItemResetAdminPwd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemResetAdminPwdState();
}

class _ItemResetAdminPwdState extends State<ItemResetAdminPwd> {
  bool pwdIsObSecure = true;
  TextEditingController pwdController = TextEditingController();
  TextEditingController repeatPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        ///重置密码
        title: Text(
          S.of(context).resetPassword,
          style: ITextStyles.appBarTitleStyle,
        ),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: pwdIsObSecure,
                  controller: pwdController,
                  decoration: InputDecoration(
                    hintText: '不少于8位',
                    labelStyle: ITextStyles.pageTextStyleGrey,
                    hintStyle: ITextStyles.pageTextStyleGrey,

                    ///密码
                    labelText: S.of(context).password,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pwdIsObSecure = !pwdIsObSecure;
                        });
                      },
                      icon: pwdIsObSecure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: pwdIsObSecure,
                  controller: repeatPwdController,
                  decoration: InputDecoration(
                    hintText: '不少于8位',
                    labelStyle: ITextStyles.pageTextStyleGrey,
                    hintStyle: ITextStyles.pageTextStyleGrey,

                    ///重复密码
                    labelText: S.of(context).ConfirmPassword,

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pwdIsObSecure = !pwdIsObSecure;
                        });
                      },
                      icon: pwdIsObSecure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  onPressed: () {
                    //TODO reset router admin pwd
                    _doResetPassword(context);
                  },
                  color: Colors.blue,

                  ///立即重置
                  child: Text(S.of(context).ResetNow,
                      style: ITextStyles.pageTextStyle),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _doResetPassword(BuildContext context) {
    var pwd = pwdController.text.toString();
    var repeatPwd = repeatPwdController.text.toString();
    if (pwd.isEmpty || repeatPwd.isEmpty) {
      Util.showSnackBar(context, '密码不能为空');
      return;
    }

    if (pwd == repeatPwd) {
      var showCircularSnackBar = Util.showCircularSnackBar(context, '正在设置');
      var resetAdminPasswordBloc = ResetAdminPasswordBloc();
      resetAdminPasswordBloc.resetPassword(pwd);
      resetAdminPasswordBloc.outResetPassword.listen((onData) {
        if (onData.return_parameter.status == '0') {
          showCircularSnackBar.close();
          Util.showSnackBar(context, '设置成功');
        }
      });
    } else {
      Util.showSnackBar(context, '两次输入的密码不一致');
    }
  }
}
