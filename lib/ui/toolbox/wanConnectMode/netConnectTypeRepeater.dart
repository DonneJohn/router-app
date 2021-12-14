import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wanSettings/setNetworkBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/models/toolbox/wanSettings/setNetworkModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/wanConnectMode/wanConnectSetPage.dart';

import '../../../main.dart';

///
///Created by slkk on 2019/11/5/0005 09:38
///
class NetConnectTypeRepeater extends StatefulWidget {
  static const name = 'ItemNetConnectRepeater';
  @override
  State<StatefulWidget> createState() => _NetConnectTypeRepeaterState();
}

class _NetConnectTypeRepeaterState extends State<NetConnectTypeRepeater> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool _isObscure = true;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        title: "中继模式设置",
        preferredSize: Size(double.infinity, 100),
      ),
      body: Column(
        children: <Widget>[
          ///宽带账号
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "中继路由SSID",
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///宽带密码
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              obscureText: _isObscure,
              controller: pwdController,
              decoration: InputDecoration(
                  labelStyle: ITextStyles.pageTextStyleGrey,
                  labelText: "密码",
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
            ),
          ),
          OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(
                    color: Color(0xFFFFFF00),
                    style: BorderStyle.solid,
                    width: 2)),
            onPressed: () {
              setRepeaterMode();
            },

            ///确定
            child: Container(
              alignment: Alignment.center,
              width: 300,
              child: Text(S.of(context).ok),
            ),
          ),
        ],
      ),
    );
  }

  void setRepeaterMode() {
    var ssid = nameController.text.toString();
    var pwd = pwdController.text.toString();
    if (ssid.isEmpty || pwd.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.of(context).emptyToastMessage),
      ));
    }
    var showSnackBar = _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
          child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text(S.of(context).saveSetting)
        ],
      )),
    ));
    var setNetworkBloc = SetNetworkBloc();
    setNetworkBloc.setNetwork('Repeater', repeaters: Repeaters(ssid, pwd));
    var stream = setNetworkBloc.subject.stream;
    stream.listen((onData) {
      logger.i(onData.return_parameter);
      if (onData.return_parameter.status == '0') {
        showSnackBar.close();
        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("设置成功"),
        ));
        Navigator.popUntil(
            _scaffoldKey.currentContext, ModalRoute.withName(WanConnectSettingPage.name));
      }
    });
  }
}
