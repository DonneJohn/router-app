import 'dart:ui';

///
///Created by slkk on 2019/10/26/0026 15:12
///
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/getHostDetailBloc.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/updateHostDetailBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/routerStatus/hostDetail/hostDetailModel.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';

class HostDetailPage2 extends StatefulWidget {
  final String itemMac;

  const HostDetailPage2({Key key, @required this.itemMac}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostDetailPageState2();
}

class _HostDetailPageState2 extends State<HostDetailPage2> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  GetHostDetailBloc bloc;
  String address;
  String mac;
  String name;

  bool rateLimitStatus = false;
  String linkTime;
  var upstreamControl = TextEditingController();
  var downSteamControl = TextEditingController();

  @override
  void initState() {
    bloc = GetHostDetailBloc();
    bloc.getDeviceDetail(widget.itemMac);
    super.initState();
  }

  _handleResult(AsyncSnapshot<HostDetailModel> snapshot) {
    var result = snapshot.data.return_parameter.result;
    name = result.name;
    String upstream = result?.runningRate?.upstream;
    String downStream = result?.runningRate?.downstream;
    upstreamControl.text = upstream;
    downSteamControl.text = downStream;
    address = result?.address;
    mac = result?.mac;
    linkTime = result?.linkTime;
    rateLimitStatus =
        snapshot.data.return_parameter.result?.ratelimit?.status == 'on'
            ? true
            : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.height, 120),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colours.priBlue, Colours.priRed],
            ),
          ),
          child: AppBar(
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    ///TODO 校验输入合法性
                    if (upstreamControl.text.isEmpty &&
                        downSteamControl.text.isEmpty) {
                      _globalKey.currentState.showSnackBar(SnackBar(
                        content: Text("上传或者下载速度不能为空"),
                      ));
                      return;
                    }
                    _updateRateLimit(context, mac,
                        status: "on",
                        upstream: upstreamControl.text.toString(),
                        downstream: downSteamControl.text.toString());
                  },
                  child: Text(
                    "保存",
                    style: ITextStyles.pageTextStyleWhite,
                  ))
            ],
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            flexibleSpace: Container(
              alignment: Alignment.center,
              child: Text(
                '设备信息',
                style: ITextStyles.pageTitleStyle,
              ),
              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: bloc.subject.stream,
          builder: (context, AsyncSnapshot<HostDetailModel> snapshot) {
            if (snapshot.data?.errorCode == 900) {
              return Center(
                child: Text('出错了'),
              );
            }
            if (snapshot.hasData &&
                snapshot.data.return_parameter.status == '0') {
              _handleResult(snapshot);
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            ///设备名称
                            title: Text("设备名称"),
                            trailing: Container(
                              alignment: Alignment.centerRight,
                              width: 100,
                              child: Text(
                                name,
                                style: ITextStyles.grey_font13,
                              ),
                            ),
                          ),

                          ///网络限速
                          ListTile(
                            title: Text("网络限速"),
                            trailing: Container(
                              alignment: Alignment.centerRight,
                              width: 100,
                              child: Transform.scale(
                                  scale: 1.3,
                                  child: Switch(
                                    onChanged: (value) {
                                      logger.i(value);
                                      setState(() {
                                        _updateRateLimit(context, mac,
                                            status: value ? "on" : "off");
                                        rateLimitStatus = !value;
                                      });
                                    },
                                    value: rateLimitStatus,
                                    activeColor: Colors.white,
                                    activeTrackColor: Colors.green,
                                  )),
                            ),
                          ),
                          Offstage(
                              offstage: false,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 10, 10, 10),
                                        child: Column(
                                          children: <Widget>[
                                            ///上传限速
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '上传限速',
                                                  style:
                                                      ITextStyles.pageTextStyle,
                                                ),
                                                Gaps.hGap10,
                                                Expanded(
                                                  child: TextField(
                                                    decoration:
                                                        InputDecoration(),
                                                    controller: upstreamControl,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Gaps.vGap20,

                                            ///下载限速
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '下载限速',
                                                  style:
                                                      ITextStyles.pageTextStyle,
                                                ),
                                                Gaps.hGap10,
                                                Expanded(
                                                  child: TextField(
                                                    decoration:
                                                        InputDecoration(),
                                                    controller:
                                                        downSteamControl,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              )),

                          ListTile(
                            ///IP地址
                            title: Text("IP地址"),
                            trailing: Text(address),
                          ),
                          ListTile(
                            ///MAC地址
                            title: Text("MAC地址"),
                            trailing: Text(mac ?? "获取失败"),
                          ),
                          ListTile(
                            ///连接时长
                            title: Text("连接时长"),
                            trailing: Text(linkTime ?? "获取失败"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _updateRateLimit(
    BuildContext context,
    String host, {
    String status,
    String upstream,
    String downstream,
  }) {
    _globalKey.currentState.removeCurrentSnackBar();
    _globalKey.currentState.showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[CircularProgressIndicator(), Text('正在设置')],
      ),
    ));
    var updateDeviceDetailBloc = UpdateHostDetailBloc();
    updateDeviceDetailBloc.updateRateLimit(host,
        status: status, upstream: upstream, downstream: downstream);
    updateDeviceDetailBloc.outUpdateDeviceDetail.listen((onData) {
      if (onData.errorCode == null && onData.return_parameter.status == '0') {
        _globalKey.currentState.removeCurrentSnackBar();
        _globalKey.currentState.showSnackBar(SnackBar(
          content: Text('设置成功'),
        ));
        bloc.getDeviceDetail(widget.itemMac);
      }
    });
  }

  Widget _getAvantarIcon(String subTitle, IconData icon, Color colors) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                  style: BorderStyle.solid, color: Colors.blue, width: 1),
            ),
            color: colors,
          ),
          child: Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
        ),
        SizedBox(height: 10),
        Text(
          subTitle,
          style: ITextStyles.pageTextStyle,
        ),
      ],
    );
  }
}
