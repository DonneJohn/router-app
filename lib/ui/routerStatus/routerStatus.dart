import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/queryBindListApi.dart';
import 'package:hg_router/bloc/getDevicesBasicBloc.dart';
import 'package:hg_router/bloc/routerStatus/deviceListBloc.dart';
import 'package:hg_router/bloc/routerStatus/deviceRunningStatusBloc.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/main.dart' as prefix0;
import 'package:hg_router/models/routerStatus/bindRouterResponseModel.dart';
import 'package:hg_router/models/loginAndLogout/getBindListResponseModel.dart';
import 'package:hg_router/models/routerStatus/deviceRunningStatusModel.dart';
import 'package:hg_router/models/routerStatus/getHostsListResponse.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/routerStatus/hostDetailPage2.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:hg_router/api/bindRouterApi.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class RouterStatusPage extends StatefulWidget {
  final BindDevice currentDevice;

  const RouterStatusPage({Key key, this.currentDevice}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RouterStatusPageState();
}

class _RouterStatusPageState extends State<RouterStatusPage>
    with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String macAddress;
  String bindStatus;
  DeviceRunningStatusBloc runningStatusBloc;
  DeviceListBloc deviceListBloc;
  String bandwidth;
  String dropdownValue;

  List<String> bindListModel;

  String gateWayIp;
  BindDevice currentDevice;

  ///设备绑定列表
  List<BindDevice> bindList;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("routerStatusPage didChangeAppLifecycleState $state");
    if (state == AppLifecycleState.resumed) {
      logger.d("router status  resumed");
    }
  }

  @override
  void didUpdateWidget(var oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d("router status didUpdateWidget>>>>>>>>>>>>>");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
    logger.d("routerStatusPage initState ");
    runningStatusBloc = DeviceRunningStatusBloc();
    deviceListBloc = DeviceListBloc();
    _init();
  }

  void _init() {
    if (SpUtil.getObjectList(Constant.bindDeviceList) == null) {
      return;
    }
    bindList = SpUtil.getObjectList(Constant.bindDeviceList).map((item) {
      return BindDevice.fromJson(item);
    }).toList();

    if (bindList == null || bindList.length == 0) {
      dropdownValue = "请绑定设备";
      bindListModel = ["请绑定设备"];
      return;
    }
    currentDevice =
        BindDevice.fromJson(SpUtil.getObject(Constant.currentDevice));
//    currentDevice = widget.currentDevice;
    ///todo nickname 必须不相同 需要路由器支持
    dropdownValue =
        (currentDevice?.nickname?.trim()) ?? currentDevice?.mac?.trim();
    logger.d("dropdownValue $dropdownValue");

    bindListModel = SpUtil.getObjectList(Constant.bindDeviceList).map((item) {
      if (BindDevice.fromJson(item).nickname == null) {
        return BindDevice.fromJson(item).mac.trim();
      } else {
        return BindDevice.fromJson(item).nickname.trim();
      }
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁
    runningStatusBloc.dispose();
    deviceListBloc.dispose();
  }

  Future<String> searchRouter() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return '';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      var wifiBSSID = await (Connectivity().getWifiBSSID());
      var wifiIP = await (Connectivity().getWifiIP());
      var wifiName = await (Connectivity().getWifiName());
      print('wifiBSSID: $wifiBSSID wifiIp: $wifiIP wifiName: $wifiName');
      return wifiBSSID;
    }
    return '';
  }

  Widget build(BuildContext context) {
    logger.d("router status build");
    return Scaffold(
        key: _globalKey,
        appBar: PreferredSize(
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 53, 37, 176),
                    Color.fromARGB(255, 184, 101, 211)
                  ],
                ),
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 50, 0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'TianYi',
                            style: ITextStyles.pageTitleStyle,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(canvasColor: Colors.black),
                            child: DropdownButton<String>(
                              value: dropdownValue ?? "222",
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.white,
                              ),
                              iconSize: 20,
                              elevation: 16,
                              style: TextStyle(color: Colors.white),
                              underline: Container(
                                height: 2,
                                color: Colors.deepOrangeAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: bindListModel.length == 0
                                  ? ["222"].map<DropdownMenuItem<String>>(
                                      (String value) {
                                      logger.d('dropdown vale1 $value');
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                  : bindListModel.map<DropdownMenuItem<String>>(
                                      (String value) {
                                      logger.d('dropdown vale2 $value');
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///上传下载速度
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
                        child: UpDownSpeedWidget(
                          bloc: runningStatusBloc,
                        ),
                      ),
                    ),

                    ///添加路由器
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 30, 5, 10),
                        child: IconButton(
                          onPressed: _appBarAction,
                          icon: Icon(Icons.add_circle),
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          preferredSize: Size(MediaQuery.of(context).size.width, 130),
        ),
        body: Builder(
          builder: (context) => Card(
            elevation: 10.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14.0))),
            //设置圆角
            margin: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: DeviceListWidget(
                    bloc: deviceListBloc,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void showChooseRouterDialogs() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("选择已绑定的WIFI"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('ddd'),
                onPressed: () {},
              ),
              SimpleDialogOption(
                child: Text('ddd'),
                onPressed: () {},
              ),
              SimpleDialogOption(
                child: Text('ddd'),
                onPressed: () {},
              )
            ],
          );
        });
  }

  Widget getItem() {
    return ListTile(
      title: Text('dddd'),
    );
  }

  void _appBarAction() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          children: <Widget>[
            ///扫描路由器二维码
            MyListTile(
              title: Text("扫描路由器添加路由器"),
              onTap: () {
                Navigator.pop(context);
                _scanRouterMac();
                print('ontap');
              },
            ),
            MyDivider(),

            ///自动搜索路由器
            MyListTile(
              onTap: () {
                _searchRouterMac();
              },
              title: Text("自动搜索路由器"),
            ),
            MyDivider(),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.blue,
              child:
                  Text(S.of(context).cancel, style: ITextStyles.pageTextStyle),
            ),
          ],
        ),
        height: 200,
        color: Colors.white,
      ),
    );
  }

  Future<String> scan() async {
    String barcode;
    try {
      barcode = await BarcodeScanner.scan();
      logger.i(barcode);
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        return barcode = 'The user did not grant the camera permission!';
      } else {
        return barcode = 'Unknown error: $e';
      }
    } on FormatException {
      return barcode =
          'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      return barcode = 'Unknown error: $e';
    }
  }

  void _searchRouterMac() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, state) {
          var getDevicesBasicBloc = GetDevicesBasicBloc();
          getDevicesBasicBloc.getDevicesBasic();
          getDevicesBasicBloc.outBloc.listen((onData) {
            if (onData.errorCode == null &&
                onData.return_parameter.status == "0") {
              logger.d("请求成功${onData.return_parameter.result.mac}");
              setState(() {
                macAddress = onData.return_parameter.result.mac;
              });
              logger.d("macAddress: $macAddress");
            }
          });
          return Container(
            child: Stack(
              children: <Widget>[
//                Image.asset(
//                  'assets/images/bind_cartoon_search.png',
//                  width: double.infinity,
//                  height: 300,
//                  fit: BoxFit.scaleDown,
//                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Offstage(
                          offstage: macAddress == null ? false : true,
                          child: CircularProgressIndicator()),
                      Offstage(
                        offstage: macAddress == null ? true : false,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: macAddress == null
                              ? Text('未搜索到天邑路由器')
                              : Text(S.of(context).scaned_barcode +
                                  '${macAddress ?? ''}'),
                        ),
                      ),

                      Gaps.vGap15,

                      ///
                      RaisedButton(
                        onPressed: () {
                          if (macAddress == null) {
                            Navigator.pop(context);
                          } else {
                            _bindRouter(macAddress);
                          }
                        },
                        color: Colors.blue,
                        child: macAddress == null
                            ? Text(S.of(context).cancel)
                            : Text(S.of(context).bind_now),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: double.infinity,
            height: 200,
            color: Colors.white,
          );
        },
      ),
    );
  }

  void _scanRouterMac() async {
    String barcode;
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, state) {
          return Container(
            child: Stack(
              children: <Widget>[
//                Image.asset(
//                  'assets/images/bind_cartoon_search.png',
//                  width: double.infinity,
//                  height: 300,
//                  fit: BoxFit.scaleDown,
//                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),

                      ///点击扫描路由器背后的条形码
                      Offstage(
                        offstage: barcode == null ? false : true,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            scan().then((onData) {
                              logger.i(onData);

                              state(() {
                                barcode = onData;
                              });
                            });
                          },
                          child: Text(S.of(context).scan_mac_behind_router),
                        ),
                      ),
                      Offstage(
                        offstage: barcode == null ? true : false,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(S.of(context).scaned_barcode +
                              '${barcode ?? ''}'),
                        ),
                      ),

                      ///
                      RaisedButton(
                        onPressed: () {
                          if (barcode == null) {
                            Navigator.pop(context);
                          } else {
                            _bindRouter(barcode);
                          }
                        },
                        color: Colors.blue,
                        child: barcode == null
                            ? Text(S.of(context).cancel)
                            : Text(S.of(context).bind_now),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: double.infinity,
            height: 200,
            color: Colors.white,
          );
        },
      ),
    );
  }

  void _bindRouter(String macAddress) async {
    var bindRouterApi = BindRouterApi();
    BindRouterResponseModel response =
        await bindRouterApi.bindRouter(macAddress);
    if (response.code == 200) {
      ///绑定成功将路由器mac 存到本地
      SpUtil.putString(Constant.routerMac, macAddress);

      ///绑定成功并且获取设备绑定列表成功后为绑定成功
      SpUtil.putString(Constant.routerUUID, response.data.uuid);
      GetBindListResponseModel bindList =
          await QueryBindListApi().getBindList();
      if (bindList.code == 200) {
        SpUtil.putObjectList(Constant.bindDeviceList, bindList.data);
        Navigator.pop(context);
        print('bind seccess');

        ///TODO 绑定成功后更新平台地址和mqtt地址
        setState(() {
          _init();
        });
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(S.of(context).bind_success),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    runningStatusBloc.getDeviceRunningStatus();
                    deviceListBloc.getDevice();
                  },
                  color: Colors.blue,
                  child: Text(S.of(context).close),
                ),
              ],
            ),
            height: 200,
            color: Colors.white,
          ),
        );
      }
    } else if (response.code == 406) {
      ///设备已经被绑定
      Navigator.of(context)..pop()..pop();
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("设备已经被其他用户绑定"),
      ));
    }
  }
}

class UpDownSpeedWidget extends StatefulWidget {
  final DeviceRunningStatusBloc bloc;

  const UpDownSpeedWidget({Key key, this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpDownSpeedWidgetState();
}

class _UpDownSpeedWidgetState extends State<UpDownSpeedWidget> {
  DeviceRunningStatusBloc bloc;

  @override
  void initState() {
    super.initState();
    logger.d("UpDownSpeedWidget initState");
    bloc = widget.bloc;
    if (mounted) {
      bloc.getDeviceRunningStatus();
    }
  }

  Widget _netStatus(String title, String status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.fiber_manual_record,
          size: 13,
          color: Colors.white,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
        ),
        Text(
          '$status',
          style: ITextStyles.white_font16_Bold,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
        ),
        Text(
          '$title',
          style: ITextStyles.pageTextStyleGrey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.d("_UpDownSpeedWidgetState build");
    return StreamBuilder<DeviceRunningStatusModel>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<DeviceRunningStatusModel> snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///上传速度
            _netStatus(
                S.of(context).uploadSpeed,
                snapshot.hasData
                    ? snapshot.data.return_parameter?.result?.upstreamRate ?? ""
                    : '000.0Kbs'),
            Gaps.hGap10,

            ///下载速度
            _netStatus(
                S.of(context).downloadSpeed,
                snapshot.hasData
                    ? snapshot.data.return_parameter?.result?.downstreamRate ??
                        ""
                    : '000.0Kbs'),

//            //网络状态
//            _netStatus(S.of(context).home_netStatus,
//                S.of(context).home_netStatus_safety),
          ],
        );
      },
    );
    ;
  }
}

class DeviceListWidget extends StatefulWidget {
  final DeviceListBloc bloc;

  const DeviceListWidget({Key key, this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  DeviceListBloc bloc;

  @override
  void initState() {
    super.initState();
    logger.d("_DeviceListWidgetState init statte");
    bloc = widget.bloc;
    if (mounted) {
      bloc.getDevice();
    }
  }

  Future _handleRefresh() async {
    logger.d('_handleRefresh');
    bloc.getDevice();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("_DeviceListWidgetState build");
    return StreamBuilder<HostsListResponse>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<HostsListResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.errorCode == 900) {
            return Center(
              child: Text("出错了"),
            );
          }
          return _buildDeviceWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          if (Util.isBind() && Util.isLogin()) {
            return _buildLoadingWidget();
          } else {
            return Center(
              child: Text(S.of(context).please_bind_first),
            );
          }
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading ...',
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error occured: $error",
          )
        ],
      ),
    );
  }

  Widget _buildDeviceWidget(HostsListResponse data) {
    logger.v('_buildDeviceWidget');
    final List<Host> results = data.return_parameter.result.hosts;
    print('device length: ' + results.length.toString());
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.separated(
        itemCount: int.parse(results.length.toString()),
        itemBuilder: (context, index) {
          final item = results[index];
//          logger.i('mac:' + item.name);

          return ListTile(
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) =>
                      HostDetailPage2(itemMac: item.mac),
                ),
              );
            },
            contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            leading:
//  TODO              Icon(item.type == 'phone' ? Icons.phone_android : Icons.laptop),
                Icon(Icons.phone_android),
            title: Text(
              item.name,
              style: ITextStyles.pageTextStyle,
            ),
            subtitle: Row(
              children: <Widget>[Text(item.status), Text(item.mac)],
            ),
            trailing: Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item.runningRate.upstream,
                      style: ITextStyles.pageTextStyleGrey,
                    ),
                    Text(
                      item.runningRate.downstream,
                      style: ITextStyles.pageTextStyleGrey,
                    )
                  ],
                )),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 3,
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          );
        },
      ),
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class DeviceItem implements ListItem {
  final String name;
  final String status;
  final bool isPhone;

  DeviceItem(this.name, this.status, this.isPhone);
}
