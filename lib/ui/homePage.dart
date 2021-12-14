import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/bindRouterApi.dart';
import 'package:hg_router/api/queryBindListApi.dart';
import 'package:hg_router/api/regionApi.dart';
import 'package:hg_router/bloc/getDevicesBasicBloc.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/loginAndLogout/getBindListResponseModel.dart';
import 'package:hg_router/models/routerStatus/bindRouterResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/profile/myProfile.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'routerStatus/routerStatus.dart';
import 'package:hg_router/ui/toolbox//toolBoxPage.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  int _page = 0;
  PageController _c;
  String searchMac;
  bool isError = false;

  ///设备绑定列表
  List<BindDevice> bindList;

  ///当前设备
  BindDevice currentDevice;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
    logger.d('home page init state');
    _init();
  }

  void _showErrorMessageDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext content) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Material(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "查找新的天邑路由器",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(message),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlineButton(
                              child: Text(
                                '确认',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
//                                    _cropImage(true);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ))),
              Expanded(
                child: Container(),
              )
            ],
          );
        });
  }

  Future showBusyingDialog() async {
    var primaryColor = Theme.of(context).primaryColor;
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "正在上传中请稍后...",
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
          ),
        ));
  }

  void _init() async {
    /// 1. 检测是否连接wifi 未连接wifi 报错提醒连接天邑wifi
    /// 2. 去平台拉取设备绑定列表，无绑定设备，返回
    /// 3，有绑定设备，也要搜索设备，比较现在所拿到的mac 是否在绑定列表里
    /// 4. 在列表里 展示此设备，不在绑定设备列表里 展示列表里的第一个设备，更新本地存储的 router mac uuid
    Connectivity().checkConnectivity().then((onData) {
      if (onData == ConnectivityResult.wifi) {
        QueryBindListApi().getBindList().then((onValue) {
          if (onValue.code == 200) {
            logger.d("查询设备绑定列表成功");
            setState(() {
              bindList = onValue.data;
            });

            ///查询不到绑定设备返回提醒用户绑定
            if (bindList == null || bindList.length == 0) {
              _initEmptyBindList();
            } else {
              ///设备列表不为空，获取路由器mac,获取不到，展示第一个设备，获取到展示此设备
              SpUtil.putObjectList(Constant.bindDeviceList, bindList);
              BindDevice deviceTmp = bindList?.first;
              try {
                var getDevicesBasicBloc = GetDevicesBasicBloc();
                getDevicesBasicBloc.outBloc.listen((onData) {
                  logger.d("get Device basic ${onData.toJson().toString()}");
                  if (onData.errorCode == null) {
                    if (onData.return_parameter?.status == "0") {
                      String currentLinkRouterMac =
                          onData.return_parameter.result.mac;
                      logger.d("搜索到天邑路由器： $currentLinkRouterMac");

                      if (currentLinkRouterMac.isNotEmpty) {
                        logger.d("获取到的网关的mac: " + currentLinkRouterMac ?? "");
                        for (int i = 0; i < onValue.data.length; i++) {
                          BindDevice device = bindList[i];
                          var deviceMac = device.mac;
                          if (deviceMac == currentLinkRouterMac) {
                            deviceTmp = bindList[i];
                          }
                        }
                      } else {
                        logger.d("获取网关的mac为空");
                      }
                    }
                  } else {
                    logger.d("获取不到路由器的mac");
                    setState(() {
                      isError = true;
                    });
                  }

                  ///无论是否获取到路由器mac都将router信息保存到本地
                  SpUtil.putString(Constant.routerMac, deviceTmp.mac);
                  SpUtil.putString(Constant.routerUUID, deviceTmp.uuid);

                  RegionApi regionApi = RegionApi();
                  regionApi.getRegion(deviceTmp.mac).then((onResponse) {
                    logger.d(onResponse.toString());
                    if (onResponse.result == "Success") {
                      String operatorl = onResponse.data.operatorl;
                      String agent_host = onResponse.data.agent_host;
                      int agent_port = onResponse.data.agent_port;

                      ///保存平台和mqtt 地址端口
                      SpUtil.putString(Constant.operatorl, operatorl);
                      SpUtil.putString(Constant.agent_host, agent_host);
                      SpUtil.putInt(Constant.agent_port, agent_port);
                    }

                    CapacitiesService.getInstance().init().then((onValue) {
                      if (onValue) {
                        logger.d("mqtt初始化成功");
                        if (!mounted) return;
                        SpUtil.putObject(Constant.currentDevice, deviceTmp);
                        setState(() {
                          logger.d("刷新页面+++++++++++++++++++++++++");
                          currentDevice = deviceTmp;

                        });
                      } else {
                        logger.d("mqtt初始化失败");
                        if (!mounted) return;
                        SpUtil.putObject(Constant.currentDevice, deviceTmp);
                        setState(() {
                          currentDevice = deviceTmp;
                          isError = true;
                        });
                      }
                    });
                  });
                });
                getDevicesBasicBloc.getDevicesBasic();
              } catch (e) {
                logger.d("Failed to get gateWay ip: '${e.message}'.");
              }
            }
          } else if (onValue.code == 900) {
            if (!mounted) return;
            setState(() {
              isError = true;
            });
          }
        });
      } else if (onData == ConnectivityResult.mobile) {
        logger.d("网络连接是wifi" + onData.toString());
        _showErrorMessageDialog(context, "wifi未打开，请先打开wifi,并连接天邑路由器");
      } else {
        logger.d("无网络连接" + onData.toString());
        _showErrorMessageDialog(context, "网络连接异常,请检查网络连接");
      }
    });
  }

  void _initEmptyBindList() {
    showDialog(
        context: context,
        builder: (BuildContext content) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Material(
                      child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '发现路由器',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Gaps.vGap50,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Gaps.hGap10,
                            Text("正在搜索请稍后"),
                          ],
                        ),
                        Gaps.vGap50,
                      ],
                    ),
                  ))),
              Expanded(
                child: Container(),
              )
            ],
          );
        });
    try {
      var getDevicesBasicBloc = GetDevicesBasicBloc();
      getDevicesBasicBloc.outBloc.listen((onData) {
        Navigator.pop(context);
        if (onData?.errorCode == 900) {
          return;
        }
        if (onData.return_parameter?.status == "0") {
          var mac = onData.return_parameter.result.mac;
          logger.d("请求成功$mac");
          logger.d("搜索到天邑路由器： $onData");
          if (mac.isNotEmpty) {
            searchMac = mac;
            _showSearchRouterDialog(context);
          } else {}
        } else {}
      });
      getDevicesBasicBloc.getDevicesBasic();
    } catch (e) {
      logger.d("Failed to get gateWay ip: '${e.message}'.");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      this._c.animateToPage(
            index,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
          );
    });
  }

  Widget getRouterStatusPage() {
    Widget child;
    if (bindList == null) {
      if (isError) {
        child = Center(
            child: Text(
          "出错了",
          style: ITextStyles.white_font16_Bold,
        ));
      } else {
        child = Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      if (bindList.length == 0) {
        child = Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "未检测到路由器",
                  style: ITextStyles.white_font16_Bold,
                ),
                Gaps.vGap100,
                RoundButton(
                  bgColor: Colors.blue,
                  text: "添加我的路由器",
                  width: 200,
                  onPressed: () {
                    _initEmptyBindList();
                  },
                ),
              ],
            ),
          ),
        );
      } else {
        if (currentDevice == null) {
          child = Center(
            child: CircularProgressIndicator(),
          );
        } else {
          child = RouterStatusPage(currentDevice: currentDevice);
        }
      }
    }

    return Container(
      child: child,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.d("home page build");
    return Scaffold(
      key: _globalKey,
      body: PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          getRouterStatusPage(),
          ToolBoxPage(),
          MyProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          ///路由设备
          BottomNavigationBarItem(
            icon: Icon(Icons.router),
            title: Text(S.of(context).home_tab_0),
          ),

          ///工具箱
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(S.of(context).home_tab_1),
          ),

          ///我的
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(S.of(context).home_tab_2),
          ),
        ],
        currentIndex: _page,
        selectedItemColor: Color.fromARGB(255, 184, 101, 211),
        onTap: _onItemTapped,
      ),
    );
  }

  void _showSearchRouterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext content) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Material(
                      child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '发现路由器',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Gaps.vGap50,
                        Text(
                            searchMac == null ? "未发现天邑路由器" : "MAC: $searchMac"),
                        Gaps.vGap50,
                        OutlineButton(
                          child: Container(
                            width: 200,
                            child: Text(
                              searchMac == null ? "手动添加" : "立即绑定",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            if (searchMac == null) {
                              Navigator.pop(context);
                              _scanRouterMac();
                            } else {
                              _bindRouter(searchMac);
                            }
                          },
                        ),
                      ],
                    ),
                  ))),
              Expanded(
                child: Container(),
              )
            ],
          );
        });
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
    Navigator.pop(context);
    _globalKey.currentState.showSnackBar(SnackBar(
      content: Container(
        child: Row(children: <Widget>[
          CircularProgressIndicator(),
          Gaps.hGap20,
          Text("正在绑定")
        ]),
      ),
    ));
    var bindRouterApi = BindRouterApi();
    BindRouterResponseModel response =
        await bindRouterApi.bindRouter(macAddress);
    if (response.code == 200) {
      ///绑定成功将路由器mac 存到本地
      SpUtil.putString(Constant.routerMac, macAddress);

      ///绑定成功并且获取设备绑定列表成功后为绑定成功
      SpUtil.putString(Constant.routerUUID, response.data.uuid);
      GetBindListResponseModel bindListResponse =
          await QueryBindListApi().getBindList();
      if (bindListResponse.code == 200) {
        _globalKey.currentState.removeCurrentSnackBar();
        bindList = bindListResponse.data;
        SpUtil.putObjectList(Constant.bindDeviceList, bindList);
        print('bind seccess');
        CapacitiesService.getInstance().init().then((onValue) {
          if (onValue) {
            logger.d("mqtt初始化结果 $onValue");
            SpUtil.putObject(Constant.currentDevice, bindList.first);
            setState(() {
              logger.d("刷新页面+++++++++++++++++++++++++");
              currentDevice = bindList.first;
            });
          }
        });
      }
    } else if (response.code == 406) {
      _globalKey.currentState.removeCurrentSnackBar();
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("设备已经被其他用户绑定"),
      ));
    } else if (response.code == 400) {
      _globalKey.currentState.removeCurrentSnackBar();
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("未找到此设备"),
      ));
    } else if (response.code == 500) {
      _globalKey.currentState.removeCurrentSnackBar();
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("设备不可用"),
      ));
    }
  }
}
