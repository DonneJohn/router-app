import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/guestWifi/getGuestWifiBloc.dart';
import 'package:hg_router/bloc/toolbox/guestWifi/setGuestWifiBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/28/0028 13:49
///
class GuestWifiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuestWifiPageState();
}

class _GuestWifiPageState extends State<GuestWifiPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var nameControl = TextEditingController();
  var pwdControl = TextEditingController();
  GetGuestWifiBloc getGuestWifiBloc;
  bool guestWifiStatus = false;
  String ssid;
  String password;
  bool isLoading = true;
  bool isSecure = true;
  bool isError = false;

  @override
  void initState() {
    _getGuestWifi();
    super.initState();
  }

  _setGuestWifi({String status, String ssid, String password}) {
    _globalKey.currentState.showSnackBar(SnackBar(
      content: Container(
          child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          Gaps.hGap10,
          Text('请稍后')
        ],
      )),
    ));
    SetGuestWifiBloc bloc = SetGuestWifiBloc();
    bloc.setGuestWifi(status: status, ssid: ssid, password: password);
    bloc.subject.stream.listen((onData) {
      if (onData.return_parameter.status == "0") {
        _globalKey.currentState.removeCurrentSnackBar();
        _getGuestWifi();
        _globalKey.currentState.showSnackBar(SnackBar(
          content: Container(child: Text('设置成功')),
        ));
      }
    });
  }

  _getGuestWifi() {
    getGuestWifiBloc = GetGuestWifiBloc();
    getGuestWifiBloc.getGuestWifi();
    getGuestWifiBloc.subject.stream.listen((onData) {
      if (onData.errorCode == 900) {
        logger.d("guest wifi error");
        if (!mounted) {
          return;
        }
        setState(() {
          isError = true;
          isLoading = false;
        });
        return;
      }
      if (onData.return_parameter.status == "0") {
        isLoading = false;
        var result = onData.return_parameter.result;
        setState(() {
          guestWifiStatus = result.status == "on";
          ssid = result.ssid;
          nameControl.text = ssid;
          password = result.password;
          pwdControl.text = password;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "访客网络",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              _setGuestWifi(
                  status: guestWifiStatus ? "on" : "off",
                  ssid: ssid,
                  password: password);
            },
            child: Text(
              "保存",
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: Builder(builder: (context) {
        return getBody(context);
      }),
    );
  }

  Widget getBody(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (isError) {
        return Center(
          child: Text('出错了'),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                title: Text("访客网络"),
                value: guestWifiStatus,
                onChanged: (value) {
                  _setGuestWifi(status: value ? "on" : "off");
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
              ),
              Offstage(
                offstage: !guestWifiStatus,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 10, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Wi-Fi名称: '),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                              controller: nameControl,
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Wi-Fi密码: '),
                          Expanded(
                            child: TextField(
                              obscureText: isSecure,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isSecure = !isSecure;
                                        });
                                      },
                                      icon: isSecure
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility))),
                              controller: pwdControl,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    }
  }
}
