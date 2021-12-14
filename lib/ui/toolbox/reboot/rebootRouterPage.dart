import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/rebootBloc.dart';
import 'package:hg_router/bloc/toolbox/reboot/getListCronRebootBloc.dart';
import 'package:hg_router/bloc/toolbox/reboot/setRebootScheduleBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/toolbox/reboot/getListCronRebootResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/reboot/setTimingRebootPage.dart';
import 'package:hg_router/utils/utils.dart';

///
///Created by slkk on 2019/10/28/0028 15:21
///
class RebootRouterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RebootRouterPageState();
}

class _RebootRouterPageState extends State<RebootRouterPage> {
  GetListCronRebootBloc bloc;
  bool cronRebootStatus = false;
  String time;
  String weekdays;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getListCronReboot();
  }

  Widget getBody(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (isError) {
        return Center(child: Text('出错了'));
      } else {
        return Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              ListTile(
                onTap: () {
                  showRebootBottomSheet(
                      '重启后将自动中断当前所有连接，需要1分钟恢复重启后需要手工连接WiFi', '立即重启', () {
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
                },
                title: Text("立即重启"),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetTimingRebootPage(
                                time: time,
                                weekday: weekdays,
                              )));
                },
                title: Text("定时重启"),
                trailing: Switch(
                  value: cronRebootStatus,
                  onChanged: (value) {
                    _setRebootSchedule(context, value ? "on" : "off");
                  },
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  void _getListCronReboot() {
    logger.d("_getListCronReboot");
    bloc = GetListCronRebootBloc();
    bloc.getRebootSchedule();
    bloc.subject.listen((onData) {
      if (onData.errorCode == 900) {
        setState(() {
          isLoading = false;
          isError = true;
        });
        return;
      }
      if (onData.return_parameter.status == "0") {
        logger.d("reboot: ");
        Schedule schedule = onData.return_parameter.result.schedules[0];
        setState(() {
          isLoading = false;
          cronRebootStatus = schedule.status == "on";
          weekdays = schedule.repeat.weekdays;
          time = schedule.time;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "立即重启",
      ),
      body: Builder(
        builder: (context) {
          return getBody(context);
        },
      ),
    );
  }

  _setRebootSchedule(BuildContext context, String status) {
    Scaffold.of(context).removeCurrentSnackBar();
    Util.showCircularSnackBar(context, "请稍后");
    SetRebootScheduleBloc setRebootScheduleBloc = SetRebootScheduleBloc();
    setRebootScheduleBloc.setRebootSchedule(status: status);
    setRebootScheduleBloc.outSetRebootSchedule.listen((onData) {
      if (onData.return_parameter.status == "0") {
        Scaffold.of(context).removeCurrentSnackBar();
        setState(() {
          cronRebootStatus = !cronRebootStatus;
        });
        Util.showSnackBar(context, "开启成功");
      }
    });
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
