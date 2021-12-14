import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/api.dart';
import 'package:hg_router/bloc/rebootBloc.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/toolbox/wifiSettings/wifiSettingPage.dart';
import 'package:hg_router/ui/toolbox/deviceInfo/deviceInfoPage.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemAreaSelect.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemCleanAppCache.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemNetSettings.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemNotifySettings.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemUserAndPrivacyAgreement.dart';
import 'package:hg_router/ui/profile/itemUserFeedback.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemUserOptimizeExperience.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemLanguageSelect.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import 'hardwareAndSystem/itemHardwareAndSystem.dart';

class RouterSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouterSettingsPageState();
}

class _RouterSettingsPageState extends State<RouterSettingsPage> {
  List<Icon> iconList = [
    Icon(
      Icons.wifi,
      color: Colors.redAccent,
    ),
    Icon(Icons.wifi_tethering, color: Colors.green),
    Icon(Icons.power_settings_new, color: Colors.yellow),
    Icon(Icons.devices, color: Colors.blue),
    Icon(Icons.edit, color: Colors.green),
    Icon(Icons.arrow_forward_ios, color: Colors.red),
    Icon(Icons.link_off, color: Colors.yellow),
    Icon(Icons.share, color: Colors.blue),
    Icon(Icons.add_alert, color: Colors.greenAccent),
    Icon(Icons.location_city, color: Colors.blue),
    Icon(Icons.language, color: Colors.yellow),
    Icon(Icons.sentiment_satisfied, color: Colors.green),
    Icon(Icons.help, color: Colors.red),
    Icon(Icons.clear, color: Colors.green),
    Icon(Icons.bookmark, color: Colors.blue)
  ];

  @override
  Widget build(BuildContext context) {
    ///条目列表
    List<String> itemTitleList = [
      S.of(context).wifiSetings,
      S.of(context).internetSetting,
      S.of(context).rebootRouter,
      S.of(context).HardwareSystem,
      S.of(context).userFeedback,
      S.of(context).logoutSetting,
      S.of(context).unbindRouter,
      S.of(context).shareRouter,
      S.of(context).InformSettings,
      S.of(context).locationSelection,
      S.of(context).LanguageSetting,
      S.of(context).UserExperiencePlan,
      S.of(context).userPolicy,
      S.of(context).cleanCache,
      S.of(context).aboutRouter
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(S.of(context).routerSettings),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return _getListTile(
                context, index, iconList[index], itemTitleList[index]);
          },
          separatorBuilder: (context, index) {
            return MyDivider(
              myHeight: 1,
            );
          },
          itemCount: 15),
    );
  }

  Widget _getListTile(
      BuildContext context, int index, Icon icon, String title) {
    return MyListTile(
      onTap: () {
        _itemNavigator(context, index);
      },
      leading: icon,
      title: Text(
        title,
        style: ITextStyles.pageTextStyle,
      ),
    );
  }

  void _logout(BuildContext context) {
    Future<MyDioResponse> response = RestfulUtils.getInstance().post(
        true, Api.baseUrl + Api.logoutUrl,
        data: {"email": SpUtil.getString(Constant.keyUserName)});
    response.then((onValue) {
      var data = onValue.statusCode;
      logger.i('logout result code $data');
      String result;
      if (data == 200) {
        result = S.of(context).logoutSuccess;
        SpUtil.putString(Constant.keyUserName, "");
        SpUtil.putString(Constant.keyAppToken, "");
        Navigator.of(context).pushNamedAndRemoveUntil(
            Constant.routeLogin, (route) => route == null);
      } else {
        result = S.of(context).logoutFail;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    });
  }

  void _unbind(BuildContext context) {
    Future<MyDioResponse> response = RestfulUtils.getInstance()
        .put(true, Api.baseUrl + Api.unBindRouterUrl, data: {
      "account": SpUtil.getString(Constant.keyUserName),
      "mac": SpUtil.getString(Constant.routerMac),
    }); //TODO unbind mac
    response.then((onValue) {
      var data = onValue.response.data['code'];
      logger.i('unbind result code $data');
      String result;
      if (data == 200) {
        result = S.of(context).unbindSuccess;
        SpUtil.putString(Constant.routerUUID, "");
      } else {
        result = S.of(context).unbindFail;
      }
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    });
  }

  void _itemNavigator(BuildContext context, int index) {
    if (index == 2) {
      //reboot pop bottomsheet not navigator;
      showRebootBottomSheet('重启后将自动中断当前所有连接，需要1分钟恢复重启后需要手工连接WiFi', '立即重启', () {
        //TODO REBOOT
        RebootBloc rebootBloc = RebootBloc();
        rebootBloc.reboot();
        rebootBloc.outRebootBloc.listen((onData) {
          if (onData.return_parameter.status == '0') {
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("请等待路由器重启后重启软件"),
              ),
            );
          }
        });
      });

      return;
    } else if (index == 5) {
      showRebootBottomSheet(S.of(context).logoutTIitle, S.of(context).logout,
          () {
        _logout(context);
      });
      return;
    } else if (index == 6) {
      showRebootBottomSheet(S.of(context).unbindTitle, S.of(context).unbind,
          () {
        _unbind(context);
      });
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (index) {
            case 0:
              return WifiSettingPage();
            case 1:
              return ItemNetSettings();
            case 3:
              return ItemHardwareAndSystem();
            case 4:
              return ItemUserFeedback();
            case 7:
              break;
            case 8:
              return ItemNotifySettings();
            case 9:
              return ItemAreaSelect();
            case 10:
              return ItemLanguageSelect();
            case 11:
              return ItemUserOptimizeExperience();
            case 12:
              return ItemUserAndPrivacyAgreement();
            case 13:
              return ItemCleanAppCache();
            case 14:
              return DeviceInfoPage();
          }
          return null;
        },
      ),
    );
  }

  void showRebootBottomSheet(
      String title, String actionTitle, VoidCallback onPressed) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    title,
                    style: ITextStyles.pageTextStyle,
                  ),
                ),
                FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    actionTitle,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  bgColor: Colors.blue,
                  text: S.of(context).cancel,
                  width: 200,
                ),
              ],
            ),
          );
        });
  }
}
