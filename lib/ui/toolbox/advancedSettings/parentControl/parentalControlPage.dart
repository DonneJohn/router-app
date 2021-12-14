import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/parentControl/ListInternetConnectBloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/parentControl/deleteInternetConnectBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/commonRequestModel.dart' as prefix0;
import 'package:hg_router/models/toolbox/advancedSettings/listInternetConnectResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/parentControl/addParentalConrolPage.dart';

///
///Created by slkk on 2019/10/29/0029 13:53
///
class ParentalControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParentalControlPageState();
}

class _ParentalControlPageState extends State<ParentalControlPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<ParentalControlModel> parentalControlList;
  List<int> deleteIndexList = [];
  List<String> deleteMacList = [];
  bool offstage = true;
  bool isLoading = true;

  ListInternetConnectBloc bloc;

  @override
  void initState() {
    bloc = ListInternetConnectBloc();
    bloc.getInternetConnectList();
    bloc.subject.stream.listen((onData) {
      parentalControlList = List<ParentalControlModel>();
      var result = onData.return_parameter.result;
      logger.d(result.toString());
      List<Host> hosts = result.hosts;
      for (int i = 0; i < hosts.length; i++) {
        Host host = hosts[i];
        var mac = host.mac;
        for (int j = 0; j < host.timing.length; j++) {
          var timing = host.timing[j];
          parentalControlList.add(ParentalControlModel(
              isOpen: timing.status == "on",
              mac: mac,
              repeat: timing.repeat.type,
              startTime: timing.start,
              endTime: timing.end));
        }
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: MyAppBar(
          preferredSize: Size(double.infinity, 100),
          title: "家长控制",
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: parentalControlList.length,
                        itemBuilder: (context, index) => getItem(index),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AddParentalControlPage();
                                }));
                              },
                              child:
                                  Text("添加", style: ITextStyles.pageTextStyle),
                            ),
                            Container(
                                height: 20,
                                child: VerticalDivider(color: Colors.grey)),
                            FlatButton(
                                onPressed: () {
                                  if (deleteIndexList.length == 0) {
                                    key.currentState.showSnackBar(
                                        SnackBar(content: Text("请长按选择要删除的项")));
                                  } else {
                                    for (int i = 0;
                                        i < deleteMacList.length;
                                        i++) {
                                      var mac = deleteMacList[i];
                                      List<prefix0.Timing> list =
                                          List<prefix0.Timing>();
                                      for (int j = 0; j < list.length; j++) {
                                        list.add(prefix0.Timing(
                                            id: deleteIndexList[j].toString()));
                                      }
                                      var deleteInternetConnectBloc =
                                          DeleteInternetConnectBloc();
                                      deleteInternetConnectBloc
                                          .deleteInternetConnect(
                                              host: mac, list: list);
                                      deleteInternetConnectBloc.subject.stream
                                          .listen((onData) {
                                        if (onData.return_parameter.status ==
                                            "0") {
                                          setState(() {
                                            offstage = true;
                                            parentalControlList.removeWhere(
                                                (item) =>
                                                    deleteIndexList.contains(
                                                        parentalControlList
                                                            .indexOf(item)));
                                          });
                                        }
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  "删除",
                                  style: ITextStyles.pageTextStyle,
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  Widget getItem(int index) {
    return GestureDetector(
      onLongPress: () {
        logger.i('long press');
        setState(() {
          logger.i("sss");
          offstage = false;
        });
      },
      onTap: () {
        logger.i('edit card');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddParentalControlPage();
        }));
      },
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Offstage(
              offstage: offstage,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.centerRight,
                child: Checkbox(
                  onChanged: (value) {
                    if (value) {
                      setState(() {
                        deleteIndexList.add(index);
                        deleteMacList.add(parentalControlList[index].mac);
                      });
                    } else {
                      setState(() {
                        deleteIndexList.remove(index);
                        deleteMacList.remove(parentalControlList[index].mac);
                      });
                    }
                  },
                  value: deleteIndexList.contains(index),
                ),
              ),
            ),
            SwitchListTile(
              onChanged: (value) {},
              value: parentalControlList[index].isOpen,
              title: Text("家长控制"),
            ),
            ListTile(
              title: Text('MAC地址'),
              trailing: Text(parentalControlList[index].mac),
            ),
            ListTile(
              title: Text('重复'),
              trailing: Text(parentalControlList[index].repeat),
            ),
            ListTile(
              title: Text('起止时间'),
              trailing: Text(parentalControlList[index].startTime),
            )
          ],
        ),
      ),
    );
  }
}

class ParentalControlModel {
  bool isOpen;

  String mac;
  String repeat;
  String startTime;
  String endTime;

  ParentalControlModel(
      {this.isOpen, this.mac, this.repeat, this.startTime, this.endTime}) {}
}
