import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/parentControl/addInternetConnectBloc.dart';
import 'package:hg_router/bloc/updateInternetConnect3Bloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/toolbox/routerSetting/rebootSchedulePage.dart';
import 'package:hg_router/utils/utils.dart';

///
///Created by slkk on 2019/9/6/0006 14:58
///更新和添加限制断网 复用这一个page
class SetTimingDisconnectionPage extends StatefulWidget {
  final TimingModle timingModel;
  final String mac;

  const SetTimingDisconnectionPage({Key key, this.timingModel, this.mac})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetTimingDisconnectionPageState();
}

class _SetTimingDisconnectionPageState
    extends State<SetTimingDisconnectionPage> {
  UpdateInternetConnect3Bloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TimeOfDay disconnectTime;
  bool isUpdateSuccess = false;
  TimeOfDay restoreTime;
  var showSnackBar;
  String repeatType;
  List<String> weekList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> repeatTypeList = ['执行一次', '每天', '周一至周五', '自定义'];

  @override
  void initState() {
    bloc = UpdateInternetConnect3Bloc();

    repeatType =
        widget.timingModel != null ? widget.timingModel.repeatType.type : "每天";
//    disconnectTime = widget.timingModel != null
//        ? TimeOfDay(
//            hour: int.parse(widget.timingModel.disconnectTime.split(":")[0]),
//            minute: int.parse(widget.timingModel.disconnectTime.split(":")[1]))
//        : TimeOfDay(hour: 0, minute: 0);
//    restoreTime = widget.timingModel != null
//        ? TimeOfDay(
//            hour: int.parse(widget.timingModel.restoreTime.split(":")[0]),
//            minute: int.parse(widget.timingModel.restoreTime.split(":")[1]))
//        : TimeOfDay(hour: 0, minute: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '时间设置',
          style: ITextStyles.appBarTitleStyle,
        ),
        actions: <Widget>[
          OutlineButton(
            onPressed: () {
              _handleUpdateConnect3(context);
            },
            child: Text(
              '确定',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.subject.stream,
        builder: (context, AsyncSnapshot<CommonResponseModel> snapshot) {
          if (snapshot.hasData) {
            String status = snapshot.data.return_parameter.status;
            if (status == "0") {
              showSnackBar.close();
              _pop();
            }
          }
          return ListView(
            children: <Widget>[
              MyListTile(
                onTap: () {
                  _showRepeatSheet(repeatType ?? '每天');
                },
                title: Text('重复'),
                subtitle: Text(repeatType ?? '每天'),
                trailing: Icon(Icons.chevron_right),
              ),
              MyDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '时间设置',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
              MyDivider(),
              MyListTile(
                onTap: () {
                  showMyTimePicker().then((onValue) {
                    setState(() {
                      disconnectTime = onValue;
                    });
                  });
                },
                title: Text('断网时间'),
                subtitle: Text(disconnectTime?.format(context) ?? '00:00'),
                trailing: Icon(Icons.chevron_right),
              ),
              MyDivider(),
              MyListTile(
                onTap: () {
                  showMyTimePicker().then((onValue) {
                    setState(() {
                      restoreTime = onValue;
                    });
                  });
                },
                title: Text('恢复时间'),
                subtitle: Text(restoreTime?.format(context) ?? '23:59'),
                trailing: Icon(Icons.chevron_right),
              )
            ],
          );
        },
      ),
    );
  }

  _handleUpdateConnect3(BuildContext context) {
    showSnackBar = _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 20),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text('正在更新')
          ],
        )));

    if (widget.timingModel != null) {
      bloc.updateInternetConnect3();
    } else {
//      var addInternetConnectBloc = AddInternetConnectBloc();
//      addInternetConnectBloc.addInternetConnect(
//          host: widget.mac,
//          status: "on",
//          start: disconnectTime.toString(),
//          end: restoreTime.toString(),
//          repeatType: repeatType,
//          repeatWeekdays: "");
//      addInternetConnectBloc.outAddInternetConnect.listen((onData) {
//        if (onData.return_parameter.status == '0') {
//          logger.i("add success");
//          showSnackBar.close();
//          _pop();
//        } else {
//          Util.showSnackBar(context, "更新失败");
//        }
//      });
    }
  }

  _pop() {
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.pop(_scaffoldKey.currentContext, [
        disconnectTime?.format(_scaffoldKey.currentContext) ?? '00:00',
        restoreTime?.format(_scaffoldKey.currentContext) ?? "23:59",
        repeatType ?? '每天'
      ]);
    });
  }

  _showRepeatSheet(String result) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Container(
                  width: double.infinity,
                  height: 1000,
                  child: ListView.separated(
                      itemCount: 4,
                      separatorBuilder: (context, index) {
                        return MyDivider();
                      },
                      itemBuilder: (context, index) {
                        return MyListTile(
                            onTap: () {
                              if (index == 3) {
                                _showCustomTimeRepeatSheet();
                              } else {
                                ///这个地方的state 已经不是母空间的context setState,是子控件自己的context

                                state(() {
                                  result = repeatTypeList[index];
                                });

                                ///这里的setState才是更新母控件的状态
                                setState(() {
                                  repeatType = repeatTypeList[index];
                                });
                                logger.i('index:$index tap result: $result');
                                Navigator.pop(context, result);
                              }
                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            leading: Icon(
                              Icons.chevron_right,
                              color: (result == repeatTypeList[index])
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                            title: Text(repeatTypeList[index]));
                      }));
            },
          );
        });
  }

  _showCustomTimeRepeatSheet() {
    logger.i('_showCustomTimeRepeatSheet');
    showBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: 1000,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          onChanged: (value) {},
                          title: Text(weekList[index]),
                          value: true,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    ),
//                    Row(
//                      children: <Widget>[
//                        FlatButton(
//                          child: Text('取消'),
//                        )
//                      ],
//                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Future<TimeOfDay> showMyTimePicker() async {
    return await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
}
