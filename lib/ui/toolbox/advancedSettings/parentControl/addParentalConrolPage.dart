import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/parentControl/addInternetConnectBloc.dart';
import 'package:hg_router/models/toolbox/advancedSettings/addInternetConnectRequestModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../../../main.dart';

///
///Created by slkk on 2019/10/29/0029 14:32
///
class AddParentalControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddParentControlPageState();
}

class _AddParentControlPageState extends State<AddParentalControlPage> {
  TimeOfDay beginTime;
  TimeOfDay endTime;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<String> repeatDay = new List<String>();
  List<String> days = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];

  var macControl = TextEditingController();
  List<TimingRequestModel> timing;

  @override
  void initState() {
    repeatDay = ["周一", "周二"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "添加家长控制",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              if (macControl.text.isNotEmpty) {
                timing = List<TimingRequestModel>();
                    timing.add(TimingRequestModel(
                    status: "on",
                    start: beginTime?.format(_globalKey.currentContext),
                    end: endTime?.format(_globalKey.currentContext),
                    repeat: RequestRepeat(weekdays: repeatDay.toString())));
                addInternetConnect(macControl.text.toString(), timing);
              } else {
                _globalKey.currentState.showSnackBar(SnackBar(
                  content: Text("mac不能为空"),
                ));
              }
            },
            child: Text(
              '保存',
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "禁止MAC",
                    style: ITextStyles.pageTextStyle,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: macControl,
                    decoration: InputDecoration(),
                  ),
                )
              ],
            ),
            ListTile(
              onTap: () {
                beginTime = getTime();
              },
              title: Text('禁止开始时间'),
              trailing: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      (beginTime == null ? '12:00' : beginTime.format(context)),
                    ),
                    Gaps.hGap10,
                    Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                endTime = getTime();
              },
              title: Text('禁止结束时间'),
              trailing: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      (endTime == null ? '12:00' : endTime.format(context)),
                    ),
                    Gaps.hGap10,
                    Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ),
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
      ),
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
                      repeatDay.add(days[index]);
                    });
                  } else {
                    setState(() {
                      repeatDay.remove(days[index]);
                    });
                  }
                },
              )
            ],
          );
        });
  }

  void addInternetConnect(String host, List<TimingRequestModel> timing) {
    var addInternetConnectBloc = AddInternetConnectBloc();
    addInternetConnectBloc.subject.stream.listen((onData) {
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("添加成功"),
      ));
      Navigator.pop(context);
    });
    addInternetConnectBloc.addInternetConnect(host: host, list: timing);
  }

  getTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        beginTime = value;
      });
    });
  }
}
