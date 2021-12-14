//import 'package:flutter/material.dart';
//import 'package:hg_router/bloc/routerStatus/hostDetailBloc/getHostDetailBloc.dart';
//import 'package:hg_router/bloc/routerStatus/hostDetailBloc/updateHostDetailBloc.dart';
//import 'package:hg_router/generated/i18n.dart';
//import 'package:hg_router/main.dart';
//import 'package:hg_router/models/routerStatus/hostDetail/hostDetailModel.dart';
//import 'package:hg_router/models/routerStatus/hostDetail/updateHostDetailRequestModel.dart';
//import 'package:hg_router/res/styles.dart';
//import 'package:hg_router/utils/utils.dart';
//import 'forbidNetworkingPage.dart';
//import 'internetAccessControlPage.dart';
//import 'hostInfoPage.dart';
//
//class HostDetailPage extends StatefulWidget {
//  final String itemMac;
//
//  const HostDetailPage({Key key, @required this.itemMac}) : super(key: key);
//
//  @override
//  State<StatefulWidget> createState() => _HostDetailPageState();
//}
//
//class _HostDetailPageState extends State<HostDetailPage> {
//  GetHostDetailBloc bloc;
//  String name;
//  String upstream;
//  String downStream;
//  bool onlineAlert;
//  bool ratelimitStatus = false;
//  bool storageAccess;
//  String internetConnect;
//  String internetAccess;
//  String uploadTraffic;
//  String downloadTraffic;
//  String traffic;
//  bool inBlacklist;
//
//  double _slideUploadValue = 10.00;
//  double _slideDownloadValue = 60.00;
//
//  @override
//  void initState() {
//    bloc = GetHostDetailBloc();
//    bloc.getDeviceDetail(widget.itemMac);
//    super.initState();
//  }
//
//  _handleResult(AsyncSnapshot<HostDetailModel> snapshot) {
//    var result = snapshot.data.return_parameter.result;
//    name = result.name;
//    upstream = result.runningRate.upstream;
//    downStream = result.runningRate.downstream;
//    uploadTraffic = result.traffic.upload;
//    downloadTraffic = result.traffic.download;
//    inBlacklist = result.inBlacklist == 'true';
//    traffic = uploadTraffic + "/" + downloadTraffic;
//    onlineAlert = result.onlineAlert == 'on' ? true : false;
//    ratelimitStatus =
//        snapshot.data.return_parameter.result.ratelimit.status == 'on'
//            ? true
//            : false;
//    storageAccess = snapshot.data.return_parameter.result.storageAccess == 'on'
//        ? true
//        : false;
//    String internetConnectRel =
//        snapshot.data.return_parameter.result.internetConnect;
//    if (internetConnectRel == 'true') {
//      internetConnect = S.of(context).forbitInternet;
//    } else if (internetConnectRel == 'false') {
//      internetConnect = S.of(context).notSet;
//    } else if (internetConnectRel == 'timing') {
//      internetConnect = S.of(context).limitedPeriod;
//    }
//
//    var internetAccessRel =
//        snapshot.data.return_parameter.result.internetAccess;
//    if (internetAccessRel == 'whitelist') {
//      internetAccess = S.of(context).whitelist;
//    } else if (internetAccessRel == 'blacklist') {
//      internetAccess = S.of(context).blacklist;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leading: IconButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          icon: Icon(Icons.arrow_back),
//        ),
//        actions: <Widget>[
//          IconButton(
//            onPressed: () {
//              //todo 老版本ui先不管
//            },
//            icon: Icon(Icons.mode_edit),
//          )
//        ],
//      ),
//      body: StreamBuilder(
//          stream: bloc.subject.stream,
//          builder: (context, AsyncSnapshot<HostDetailModel> snapshot) {
//            if (snapshot.hasData &&
//                snapshot.data.return_parameter.status == '0') {
//              _handleResult(snapshot);
//              return Column(
//                children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.all(20),
//                    width: double.infinity,
//                    height: 180,
//                    decoration: BoxDecoration(color: Colors.blue),
//                    child: Column(
//                      children: <Widget>[
//                        ///设备名称
//                        Text(
//                          name ?? S.of(context).Device1,
//                          style: ITextStyles.pageTitleStyle,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Icon(
//                              Icons.phone_iphone,
//                              color: Colors.white,
//                              size: 60,
//                            ),
//
//                            ///上传速度
//                            Column(
//                              children: <Widget>[
//                                Text(S.of(context).uploadSpeed,
//                                    style: ITextStyles.white_font13),
//                                SizedBox(
//                                  height: 15,
//                                ),
//                                Text(upstream ?? S.of(context).zerokbs,
//                                    style: ITextStyles.pageTitleStyle),
//                                SizedBox(
//                                  height: 15,
//                                ),
//                              ],
//                            ),
//                            Container(
//                              height: 60,
//                              child: VerticalDivider(
//                                width: 20,
//                                color: Colors.white,
//                              ),
//                            ),
//
//                            ///下载速度
//                            Column(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                Text(S.of(context).downloadSpeed,
//                                    style: ITextStyles.white_font13),
//                                SizedBox(
//                                  height: 15,
//                                ),
//                                Text(downStream ?? S.of(context).zerokbs,
//                                    style: ITextStyles.pageTitleStyle),
//                              ],
//                            )
//                          ],
//                        ),
//
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            ///消耗流量
//                            Text(
//                              S.of(context).traffic,
//                              style: ITextStyles.white_font10,
//                            ),
//                            Text(
//                              traffic ?? 'xxxxxxGb',
//                              style: ITextStyles.white_font10,
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      GestureDetector(
//                        ///拉黑
//                        onTap: () {
//                          inBlacklist = !inBlacklist;
//                          print('ontap 拉黑');
//                          _updateDeviceDetail(context, widget.itemMac,
//                              inBlacklist: inBlacklist.toString());
//                        },
//                        child: _getAvantarIcon(
//                            S.of(context).inBlacklist,
//                            Icons.alarm,
//                            inBlacklist ?? false
//                                ? Colors.blue.withAlpha(200)
//                                : Colors.white),
//                      ),
//                      GestureDetector(
//                        ///上线提醒
//                        onTap: () {
//                          onlineAlert = !onlineAlert;
//                          print('ontap 上线提醒');
//                          _updateDeviceDetail(context, widget.itemMac,
//                              onlineAlert: onlineAlert ? 'on' : 'off');
//                        },
//                        child: _getAvantarIcon(
//                            S.of(context).onlineAlert,
//                            Icons.alarm,
//                            onlineAlert ?? false
//                                ? Colors.blue.withAlpha(200)
//                                : Colors.white),
//                      ),
//                      GestureDetector(
//                        ///全盘访问
//                        onTap: () {
//                          storageAccess = !storageAccess;
//                          _updateDeviceDetail(context, widget.itemMac,
//                              storageAccess: storageAccess ? 'on' : 'off');
//                        },
//                        child: _getAvantarIcon(
//                            S.of(context).storageAccess,
//                            Icons.insert_drive_file,
//                            storageAccess ?? false
//                                ? Colors.blue.withAlpha(200)
//                                : Colors.white),
//                      ),
//                      GestureDetector(
//                        ///限速
//                        onTap: () {
//                          ratelimitStatus = !ratelimitStatus;
//                          _updateDeviceDetail(context, widget.itemMac,
//                              limit: Ratelimit(
//                                  ratelimitStatus ?? false ? 'on' : 'off'));
//                        },
//                        child: _getAvantarIcon(
//                            S.of(context).rateLimit,
//                            Icons.link_off,
//                            ratelimitStatus ?? false
//                                ? Colors.blue
//                                : Colors.white),
//                      ),
//                    ],
//                  ),
////                SliderTheme(
////                  data: SliderTheme.of(context).copyWith(
//////                activeTickMarkColor:Colors.yellowAccent,
////                    activeTrackColor: Colors.yellowAccent,
////                    //实际进度的颜色
//////                inactiveTickMarkColor:Colors.black
////                    thumbColor: Colors.black,
////                    //滑块中心的颜色
////                    inactiveTrackColor: Colors.red,
////                    //默认进度条的颜色
////                    valueIndicatorColor: Colors.blue,
////                    //提示进度的气派的背景色
////                    valueIndicatorTextStyle: new TextStyle(
////                      //提示气泡里面文字的样式
////                      color: Colors.white,
////                    ),
////                    inactiveTickMarkColor: Colors.blue,
////                    //divisions对进度线分割后 断续线中间间隔的颜色
////                    overlayColor: Colors.pink, //滑块边缘颜色
////                  ),
////                  child: new Container(
////                    width: 340.0,
////                    margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
////                    child: new Row(
////                      children: <Widget>[
////                        new Text('0.0'),
////                        new Expanded(
////                          flex: 1,
////                          child: new Slider(
////                            value: progressValue,
////                            label: '$progressValue',
////                            divisions: 10,
////                            onChanged: (double) {
////                              setState(() {
////                                progressValue =
////                                    double.floorToDouble(); //转化成double
////                              });
////                            },
////                            min: 0.0,
////                            max: 100.0,
////                          ),
////                        ),
////                        new Text('100.0'),
////                      ],
////                    ),
////                  ),
////                ),
//                  ///长传slider
//                  Offstage(
//                    offstage: !ratelimitStatus ?? false,
//                    child: Container(
//                      padding: EdgeInsets.fromLTRB(16, 5, 5, 0),
//                      child: Row(
//                        children: <Widget>[
//                          Text(
//                            S.of(context).upload,
//                            style: ITextStyles.pageTextStyle,
//                          ),
//                          Expanded(
//                            child: Container(
//                              height: 50,
//                              child: Slider(
//                                value: _slideUploadValue,
//                                min: 0,
//                                max: 100,
//                                onChanged: (newValue) {
//                                  setState(() {
//                                    _slideUploadValue = newValue;
//                                  });
//                                },
//                                divisions: 100,
//                                onChangeEnd: (endValue) {
//                                  _updateDeviceDetail(context, widget.itemMac,
//                                      limit: Ratelimit('on',
//                                          upstream:
//                                              endValue.round().toString()));
//                                  logger.i(endValue);
//                                },
//                                label: "${_slideUploadValue.round()} MB/S",
//                                semanticFormatterCallback: (newValue) {
//                                  return '$newValue MB/S';
//                                },
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//
//                  ///下载slider
//                  Offstage(
//                    offstage: !ratelimitStatus ?? false,
//                    child: Container(
//                      padding: EdgeInsets.fromLTRB(16, 5, 5, 0),
//                      child: Row(
//                        children: <Widget>[
//                          Text(
//                            S.of(context).download,
//                            style: ITextStyles.pageTextStyle,
//                          ),
//                          Expanded(
//                            child: Container(
//                              height: 50,
//                              child: Slider(
//                                value: _slideDownloadValue,
//                                min: 0,
//                                max: 100,
//                                onChanged: (newValue) {
//                                  setState(() {
//                                    _slideDownloadValue = newValue;
//                                  });
//                                },
//                                divisions: 100,
//                                onChangeEnd: (endValue) {
//                                  logger.i(endValue);
//                                  _updateDeviceDetail(context, widget.itemMac,
//                                      limit: Ratelimit('on',
//                                          downstream:
//                                              endValue.round().toString()));
//                                  logger.i(endValue);
//                                },
//                                label: "${_slideDownloadValue.round()} MB/S",
//                                semanticFormatterCallback: (newValue) {
//                                  return '$newValue MB/S';
//                                },
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//
//                  Expanded(
//                    child: ListView(
//                      children: <Widget>[
//                        Divider(
//                          height: 3,
//                        ),
//                        ListTile(
//                          dense: true,
//
//                          ///禁止联网
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => ForbidNetworkingPage(
//                                          internetConnect: internetConnect,
//                                          mac: widget.itemMac,
//                                        ))).then((onValue) {
//                              bloc.getDeviceDetail(widget.itemMac);
//                            });
//                          },
//                          title: Text(S.of(context).forbitInternet),
//                          subtitle: Text('控制设备联网时间'),
//                          trailing: Container(
//                            width: 100,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text(
//                                  internetConnect ?? S.of(context).notSet,
//                                  style: ITextStyles.pageTextStyle,
//                                ),
//                                Icon(Icons.chevron_right)
//                              ],
//                            ),
//                          ),
//                        ),
//                        Divider(
//                          height: 3,
//                        ),
//                        ListTile(
//                          dense: true,
//
//                          ///访问控制
//                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => InternetAccessControlPage(
//                                    mac: widget.itemMac),
//                              ),
//                            );
//                          },
//                          title: Text(S.of(context).internetAccess),
//                          subtitle: Text('控制设备上网行为'),
//                          trailing: Container(
//                            width: 100,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text(
//                                  internetAccess ?? S.of(context).notSet,
//                                  style: ITextStyles.pageTextStyle,
//                                ),
//                                Icon(Icons.chevron_right)
//                              ],
//                            ),
//                          ),
//                        ),
//                        Divider(
//                          height: 3,
//                        ),
//                        ListTile(
//                          dense: true,
//
//                          ///设备信息
//                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) =>
//                                    HostInfoPage(mac: widget.itemMac),
//                              ),
//                            );
//                          },
//                          title: Text(S.of(context).deviceInfo),
//                          subtitle: Text('建议与Wi-Fi不一样的密码'),
//                          trailing: Icon(Icons.chevron_right),
//                        ),
//                        Divider(
//                          height: 3,
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              );
//            } else {
//              return Center(child: CircularProgressIndicator());
//              //return Center(child: Text("加载失败，请稍后重试"));
//            }
//          }),
//    );
//  }
//
//  _updateDeviceDetail(
//    BuildContext context,
//    String host, {
//    String nickname,
//    Ratelimit limit,
//    String onlineAlert,
//    String storageAccess,
//    String inBlacklist,
//  }) {
//    var showCircularSnackBar =
//        Util.showCircularSnackBar(context, S.of(context).operating);
//    var updateDeviceDetailBloc = UpdateHostDetailBloc();
//    updateDeviceDetailBloc.updateRateLimit(host,
//        nickname: nickname,
//        limit: limit,
//        onlineAlert: onlineAlert,
//        storageAccess: storageAccess,
//        inBlacklist: inBlacklist);
//    updateDeviceDetailBloc.outUpdateDeviceDetail.listen((onData) {
//      if (onData.return_parameter.status == '0') {
//        Future.delayed(Duration(seconds: 1), () {
//          showCircularSnackBar.close();
//        });
//        bloc.getDeviceDetail(widget.itemMac);
//      }
//    });
//  }
//
//  Widget _getAvantarIcon(String subTitle, IconData icon, Color colors) {
//    return Column(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.all(10),
//          decoration: ShapeDecoration(
//            shape: CircleBorder(
//              side: BorderSide(
//                  style: BorderStyle.solid, color: Colors.blue, width: 1),
//            ),
//            color: colors,
//          ),
//          child: Icon(
//            icon,
//            color: Colors.black,
//            size: 30,
//          ),
//        ),
//        SizedBox(height: 10),
//        Text(
//          subTitle,
//          style: ITextStyles.pageTextStyle,
//        ),
//      ],
//    );
//  }
//}
