import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wanSettings/setNetworkBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/models/toolbox/wanSettings/setNetworkModel.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';

import 'wanConnectSetPage.dart';


///
///Created by slkk on 2019/9/10/0010 14:39
///
class NetConnectTypeStatic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetConnectTypeStaticState();
}

class _NetConnectTypeStaticState extends State<NetConnectTypeStatic> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController ipController = TextEditingController();
  TextEditingController netMaskController = TextEditingController();
  TextEditingController gatewayController = TextEditingController();
  TextEditingController dns1Controller = TextEditingController();
  TextEditingController dns2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.height, 120),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colours.priBlue, Colours.priRed],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            flexibleSpace: Container(
              alignment: Alignment.center,
              child: Text(
                '静态IP',
                style: ITextStyles.pageTitleStyle,
              ),
              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ///ip地址
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: TextField(
              controller: ipController,
              decoration: InputDecoration(
                  labelText: S.of(context).ip,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///子网掩码
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: TextField(
              controller: netMaskController,
              decoration: InputDecoration(
                  labelText: S.of(context).netMask,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///网关
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: TextField(
              controller: gatewayController,
              decoration: InputDecoration(
                  labelText: S.of(context).gateway,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///DNS1
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: TextField(
              controller: dns1Controller,
              decoration: InputDecoration(
                  labelText: 'DNS1',
                  hintText: S.of(context).required,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///DNS2
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: TextField(
              controller: dns2Controller,
              decoration: InputDecoration(
                  labelText: 'DNS2',
                  hintText: S.of(context).optional,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///确定
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Color(0xFFFFFF00),
                      style: BorderStyle.solid,
                      width: 2)),
              onPressed: () {
                _setStatic();
              },
              child: Container(
                alignment: Alignment.center,
                width: 300,
                child: Text('确定'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setStatic() {
    var setNetworkBloc = SetNetworkBloc();
    var ip = ipController.text.toString();
    var netmask = netMaskController.text.toString();
    var gateway = gatewayController.text.toString();
    var dns1 = dns1Controller.text.toString();
    var dns2 = dns2Controller.text.toString();
    if (ip.isEmpty || netmask.isEmpty || gateway.isEmpty || dns1.isEmpty) {
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text('ip ,netmask,gateway,dns1 不能为空'),
      ));
      return;
    }
    _globalKey.currentState.showSnackBar(
      SnackBar(
        content: Container(
          child: Row(children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 10,
            ),
            Text('正在保存配置')
          ]),
        ),
      ),
    );
    setNetworkBloc.setNetwork('static',
        static: Statics(ip, netmask, gateway, dns1, dns2: dns2 ?? ''));
    setNetworkBloc.subject.stream.listen((onData) {
      if (onData.return_parameter.status == '0') {
        Navigator.popUntil(
            context, ModalRoute.withName(WanConnectSettingPage.name));
      }
    });
  }
}
