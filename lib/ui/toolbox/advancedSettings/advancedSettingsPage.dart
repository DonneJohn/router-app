import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/usb30/getUsb30Bloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/usb30/setUsb30Bloc.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/modifyAdminPwdPage.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/parentControl/parentalControlPage.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/restoreDefaultPage.dart';
import 'package:hg_router/ui/toolbox/routerSetting/hardwareAndSystem/itemTimeZoneSettings.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/vpn/vpnSettingsPage.dart';

///
///Created by slkk on 2019/10/29/0029 13:38
///
class AdvancedSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdvancedSettingsPageState();
}

class _AdvancedSettingsPageState extends State<AdvancedSettingsPage> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  bool usb30Status = true;

  @override
  void initState() {
    super.initState();
    _getUsb30Status();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "高级设置",
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('VPN'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VpnSettingsPage();
                }));
              },
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ParentalControlPage();
                }));
              },
              title: Text("家长控制"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ModifyAdminPwdPage();
                }));
              },
              title: Text("管理员密码控制"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RestoreDefaultPage();
                }));
              },
              title: Text("恢复出厂设置"),
              trailing: Icon(Icons.chevron_right),
            ),
            SwitchListTile(
              title: Text('USB3.0'),
              value: usb30Status,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              onChanged: (value) {
                setUsb30Status(value ? "on" : "off");
              },
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ItemTimeZoneSettings();
                }));
              },
              trailing: Icon(Icons.chevron_right),
              title: Text("时区设置"),
            ),
          ],
        ),
      ),
    );
  }

  _getUsb30Status() {
    var getUsb30Bloc = GetUsb30Bloc();
    getUsb30Bloc.getUsb30();
    getUsb30Bloc.subject.listen((onData) {
      if (onData.return_parameter.status == "0") {
        setState(() {
          usb30Status = onData.return_parameter.result.status == "on";
        });
      }
    });
  }

  setUsb30Status(String status) {
    globalKey.currentState.removeCurrentSnackBar();
    globalKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('请稍后')
          ],
        ),
      ),
    );
    var setUsb30Bloc = SetUsb30Bloc();
    setUsb30Bloc.setUsb30(status);
    setUsb30Bloc.subject.listen((onData) {
      globalKey.currentState.removeCurrentSnackBar();
      if (onData.return_parameter.status == "0") {
        globalKey.currentState.showSnackBar(SnackBar(content: Text('设置成功')));
        setState(() {
          usb30Status = !usb30Status;
        });
      }
    });
  }
}
