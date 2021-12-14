import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/reboot/getListCronRebootBloc.dart';

import 'package:hg_router/main.dart';
import 'package:hg_router/models/toolbox/reboot/getListCronRebootResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/routerStatus/setTimingDisconnectionPage.dart';

///
///Created by slkk on 2019/9/6/0006 14:46
///

class RebootSchedulePage extends StatefulWidget {
  const RebootSchedulePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RebootSchedulePageState();
}

class _RebootSchedulePageState extends State<RebootSchedulePage> {
  List<Schedule> schedulesList = new List();
  GetListCronRebootBloc getInternetConnectBloc;

  @override
  void initState() {
    getInternetConnectBloc = GetListCronRebootBloc();
    getInternetConnectBloc.getRebootSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build");
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "设置重启计划",
      ),
      body: StreamBuilder(
        stream: getInternetConnectBloc.outGetRebootSchedule,
        builder:
            (context, AsyncSnapshot<GetListCronRebootResponseModel> snapshot) {
          if (snapshot.hasData) {
            logger.i("_TimingDisconnectionPageState has data");
            schedulesList = snapshot.data.return_parameter.result.schedules;
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _getItem(context, index, schedulesList);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: schedulesList.length,
                ),
                Expanded(
                    child: Container(
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
//                              addItem();
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.add),
                              Text(
                                '添加定时',
                                style: ITextStyles.pageTextStyle,
                              )
                            ],
                          ),
                        )))
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _getItem(BuildContext context, int index, List<Schedule> timing) {
    Schedule model = schedulesList[index];
    bool status = model.status == 'on' ? true : false;
    return MyListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SetTimingDisconnectionPage(
            timingModel: TimingModle(model.time, model.repeat),
          );
        }));
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10),
                height: 150,
                child: Column(
                  children: <Widget>[
                    Text('确认删除?'),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              schedulesList.removeAt(index);
                            });
                          },
                          child: Text("确认"),
                        ),
                        OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("取消"),
                        )
                      ],
                    )
                  ],
                ),
              );
            });
      },
      title: Text(
        model.time + '重启',
      ),
      subtitle: Text(model.repeat.type),
//      trailing: Switch(
//        value: status,
//        onChanged: (value) {
//          logger.i(value);
//          var showCircularSnackBar = Util.showCircularSnackBar(context, '正在设置');
//          var setInternetConnect2Bloc = SetInternetConnect2Bloc();
//          setInternetConnect2Bloc.setInternetConnect2(index.toString(),
//              [prefix0.Timing(index.toString(), value ? 'on' : 'off')]);
//          setInternetConnect2Bloc.outSetInternetConnect2.listen((onData) {
//            if (onData.return_parameter.status == '0') {
//              timingList[index].status = value ? 'on' : 'off';
//              setState(() {
//                status = value;
//              });
//              Future.delayed(Duration(seconds: 1), () {
//                showCircularSnackBar.close();
//              });
//            }
//          });
//        },
//      ),
    );
  }

//  addItem() async {
//    var push =
//        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//      return SetTimingDisconnectionPage();
//    }));
//    List<String> result = push as List;
//    var timingModel = Schedule(
//      'on',
//      "3",
//      Repeat(result[2], ''),
//      result[0],
//      result[1],
//    );
//    setState(() {
//      logger.i(timingList.length);
//      timingList.add(timingModel);
//    });
//  }
}

class TimingModle {
  final String time;
  final Repeat repeatType;

  TimingModle(this.time, this.repeatType);
}
