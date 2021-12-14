import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/antiSteal/getAntiStealBloc.dart';
import 'package:hg_router/bloc/toolbox/antiSteal/setAntiStealBloc.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/routerSetting/hardwareAndSystem/itemResetAdminPwd.dart';
import '../../../main.dart';
import 'AntiStealBlackWhiteList.dart';
import '../wifiSettings/wifiSettingPage.dart';
import 'itemAntiStealRecord.dart';
import 'itemAntiStealSafeLevel.dart';

class AntiStealPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AntiStealPageState();
}

class _AntiStealPageState extends State<AntiStealPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  GetAntiStealBloc getAntiStealBloc;
  List<String> listTitle = [
    '防蹭网安全等级',
    '拦截黑名单',
    '拦截记录',
    'WI-FI密码安全等级',
    '路由器管理密码安全等级'
  ];
  List<String> listSubTitle = [
    '拦截黑名单，风险设备提示，新设备上线提醒',
    '加入黑名单会被自动拦截',
    '详细记录拦截信息',
    '建议中英文组合为密码',
    '建议与WI-FI不一样的密码'
  ];

  bool isAntiSteal = false;

  String mode = "whitelist";

  @override
  void initState() {
    getAntiStealStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        appBar:
            MyAppBar(title: "防蹭网", preferredSize: Size(double.infinity, 100)),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                activeTrackColor: Colors.green,
                activeColor: Colors.white,
                title: Text("启用防蹭网"),
                onChanged: (value) {
                  setAntiStealStatus(value);
                },
                value: isAntiSteal,
              ),
              Offstage(
                offstage: !isAntiSteal,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('防蹭网策略'),
                      trailing: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.grey),
                        child: DropdownButton<String>(
                          value: mode,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colours.priRed,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              mode = newValue;
                            });
                          },
                          items: <String>["whitelist", "blacklist"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: mode == "whitelist",
                      child: ListTile(
                        title: Text("黑名单"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AntiStealListPage(
                                        type: "blacklist",
                                      )));
                        },
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                    Offstage(
                      offstage: mode == "blacklist",
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AntiStealListPage(
                                        type: "whitelist",
                                      )));
                        },
                        title: Text("白名单"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void getAntiStealStatus() {
    getAntiStealBloc = GetAntiStealBloc();
    getAntiStealBloc.getAntiSteal();
    getAntiStealBloc.subject.stream.listen((onData) {
      if (onData.errorCode == 900) {
        return;
      }
      if (onData.return_parameter.status == "0") {
        setState(() {
          isAntiSteal = onData.return_parameter.result.status == "on";
        });
      }
    });
  }

  void setAntiStealStatus(bool status) {
    var showSnackBar = _globalKey.currentState.showSnackBar(SnackBar(
      content: Container(
          child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('正在保存配置')
        ],
      )),
    ));
    var setAntiStealBloc = SetAntiStealBloc();
    setAntiStealBloc.setAntiSteal(status ? "on" : "off");
    var stream = setAntiStealBloc.subject.stream;
    stream.listen((onData) {
      logger.i(onData.return_parameter);
      if (onData.return_parameter.status == "0") {
        setState(() {
          isAntiSteal = status;
        });
        logger.i("success");
        showSnackBar.close();
      }
    });
  }
}
