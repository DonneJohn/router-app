import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/reboot/setRebootScheduleBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/28/0028 16:45
///
class SetTimingRebootPage extends StatefulWidget {
  final String time;
  final String weekday;

  const SetTimingRebootPage({Key key, this.time, this.weekday})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetTimingRebootPageState();
}

class _SetTimingRebootPageState extends State<SetTimingRebootPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TimeOfDay time;

  List<String> repeatDay = new List<String>();
  List<String> repeatIndex;

  List<String> days = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];

  @override
  void initState() {
    time = TimeOfDay(
        hour: int.parse(widget.time.split(":")[0]),
        minute: int.parse(widget.time.split(":")[1]));

    repeatIndex = widget.weekday.split(",").toList();
    for (int i = 0; i < repeatIndex.length; i++) {
      repeatDay.add(days[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "重启设置",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              var str = StringBuffer();
              for (int i = 0; i < repeatIndex.length; i++) {
                str.write(repeatIndex[i]);
                if (i == repeatIndex.length - 1) continue;
                str.write(',');
              }
              var strTime = StringBuffer();
              strTime.write(time.hour);
              strTime.write(":");
              strTime.write(time.minute);
              _setRebootSchedule(context,
                  time: strTime.toString(), weekdays: str.toString());
//              Navigator.pop(context);
            },
            child: Text(
              '保存',
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: Builder(builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  onTap: () {
                    time = getTime();
                  },
                  title: Text('重启时间'),
                  trailing: Builder(
                    builder: (context) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: Text((time == null
                            ? '12:00'
                            : time.format(
                                context,
                              ))),
                      );
                    },
                  )),
              Container(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "重复日期",
                  style: ITextStyles.pageTextStyle,
                ),
              ),
              Expanded(
                child: repeatDayWidget(),
              ),
            ],
          ),
        );
      }),
    );
  }

  repeatDayWidget() {
    return GridView.builder(
        padding: EdgeInsets.only(left: 30),
        itemCount: 7,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.7),
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Text(
                days[index],
                style: TextStyle(color: Colors.blue),
              ),
              Checkbox(
                value: repeatDay.contains(days[index]),
                onChanged: (value) {
                  if (value) {
                    setState(() {
                      logger.i(days[index]);
                      repeatIndex.add((index + 1).toString());
                      repeatDay.add(days[index]);
                    });
                  } else {
                    setState(() {
                      repeatIndex.remove((index + 1).toString());
                      repeatDay.remove(days[index]);
                    });
                  }
                },
              )
            ],
          );
        });
  }

  _setRebootSchedule(BuildContext context,
      {String status, String time, String weekdays}) {
    _globalKey.currentState.removeCurrentSnackBar();

    _globalKey.currentState.showSnackBar(SnackBar(content: Text("请稍后")));
    SetRebootScheduleBloc setRebootScheduleBloc = SetRebootScheduleBloc();
    setRebootScheduleBloc.setRebootSchedule(
        status: status, time: time, weekdays: weekdays);
    setRebootScheduleBloc.outSetRebootSchedule.listen((onData) {
      if (onData.return_parameter.status == "0") {
        _globalKey.currentState.removeCurrentSnackBar();
        setState(() {});
        _globalKey.currentState.showSnackBar(SnackBar(content: Text("开启成功")));
      }
    });
  }

  getTime() {
    showTimePicker(
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
      context: context,
      initialTime: time ?? TimeOfDay.now(),
    ).then((value) {
      setState(() {
        time = value;
      });
    });
  }
}
