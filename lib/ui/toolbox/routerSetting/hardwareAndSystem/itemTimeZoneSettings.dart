import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/getTimeBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/hardwareAndSystem/TimeZoneMap.dart';
import 'package:hg_router/models/hardwareAndSystem/getTimeResponseModel.dart'
    as responseModel;
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/routerSetting/hardwareAndSystem/selectTimeZonePage.dart';

class ItemTimeZoneSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemTimeZoneSettingsState();
}

class _ItemTimeZoneSettingsState extends State<ItemTimeZoneSettings> {
  List<String> itemTitle = ['选择时区', '日期设置', '时间设置'];
  GetTimeBloc getTimeBloc;
  String timezone;
  responseModel.Date date;
  responseModel.Time time;
  String firstNTPValue = "不配置";
  String secondNTPValue = "不配置";
  bool autoConfig = true;
  bool firstNTPOffStage = true;
  bool secondNTPOffStage = true;
  TextEditingController firstCustomNtpController = TextEditingController();
  TextEditingController secondCustomNtpController = TextEditingController();

  @override
  void initState() {
    getTimeBloc = GetTimeBloc();
    getTimeBloc.getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: '时区设置',
        preferredSize: Size(double.infinity, 100),
      ),
      body: StreamBuilder(
        stream: getTimeBloc.outGetTime,
        builder: (context,
            AsyncSnapshot<responseModel.GetTimeResponseModel> snapshot) {
          if (snapshot.hasData) {
            timezone = snapshot.data.return_parameter.result.timezone;
            date = snapshot.data.return_parameter.result.date;
            time = snapshot.data.return_parameter.result.time;
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectTimezonePage(timezone: timezone)))
                          .then((onValue) {
                        getTimeBloc.getTime();
                      });
                    },
                    title: Text("选择时区"),
                    trailing: Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("北京时间"),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("当前系统时间"),
                    trailing: Text("2019/10/25 11:03"),
                  ),
                  CheckboxListTile(
                    title: Text('自动同步'),
                    onChanged: (value) {
                      setState(() {
                        autoConfig = value;
                      });
                    },
                    value: autoConfig,
                  ),
                  Offstage(
                    offstage: !autoConfig,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("第一NTP时间服务器"),
                          trailing: Theme(
                            data: Theme.of(context)
                                .copyWith(canvasColor: Colors.white),
                            child: DropdownButton<String>(
                              value: firstNTPValue,
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                              ),
                              iconSize: 20,
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colours.priRed,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  firstNTPValue = newValue;
                                  if (firstNTPValue == "其他") {
                                    setState(() {
                                      firstNTPOffStage = false;
                                    });
                                  } else {
                                    setState(() {
                                      firstNTPOffStage = true;
                                    });
                                  }
                                });
                              },
                              items: <String>[
                                "不配置",
                                "clock.fmt.he.net",
                                "clock.nyc.he.net",
                                "clock.sjc.he.net",
                                "clock.via.net",
                                "ntp1.tummy.com",
                                "time.cachenetworks.com",
                                "time.nist.gov",
                                "time.windows.com",
                                "其他"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: firstNTPOffStage,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(150, 10, 10, 10),
                            child: TextField(
                              controller: firstCustomNtpController,
                              decoration:
                                  InputDecoration(hintText: "请输入自定义NTP服务器"),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("第二NTP时间服务器"),
                          trailing: Theme(
                            data: Theme.of(context)
                                .copyWith(canvasColor: Colors.white),
                            child: DropdownButton<String>(
                              value: secondNTPValue,
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                              ),
                              iconSize: 20,
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colours.priRed,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  secondNTPValue = newValue;
                                  if (secondNTPValue == "其他") {
                                    setState(() {
                                      secondNTPOffStage = false;
                                    });
                                  } else {
                                    setState(() {
                                      secondNTPOffStage = true;
                                    });
                                  }
                                });
                              },
                              items: <String>[
                                "不配置",
                                "clock.fmt.he.net",
                                "clock.nyc.he.net",
                                "clock.sjc.he.net",
                                "clock.via.net",
                                "ntp1.tummy.com",
                                "time.cachenetworks.com",
                                "time.nist.gov",
                                "time.windows.com",
                                "其他"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: secondNTPOffStage,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(150, 10, 10, 10),
                            child: TextField(
                              controller: secondCustomNtpController,
                              decoration:
                                  InputDecoration(hintText: "请输入自定义NTP服务器"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return (Center(child: Text('请先连接路由器')));
          }
        },
      ),
    );
  }
}
