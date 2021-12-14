import 'package:flutter/material.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/toolbox/antiSteal/antiStealPage.dart';
import 'package:hg_router/ui/toolbox/testSpeed/testSpeedPage2.dart';
import 'package:hg_router/ui/toolbox/wanConnectMode/wanConnectSetPage.dart';
import 'package:hg_router/ui/toolbox/wifiSettings/wifiSettingPage.dart';
import 'package:hg_router/ui/toolbox/mesh/meshPage.dart';
import 'package:hg_router/ui/toolbox/reboot/rebootRouterPage.dart';
import 'package:hg_router/ui/toolbox/wifiDetect/deviceDetectPage.dart';
import 'package:hg_router/ui/toolbox/deviceInfo/deviceInfoPage.dart';
import 'package:hg_router/ui/toolbox/testSpeed/testSpeedPage3.dart';
import 'package:hg_router/ui/toolbox/upgradeSystem/upgradeSystemPage.dart';
import 'package:hg_router/ui/routerStatus/testSpeed.dart';
import 'advancedSettings/advancedSettingsPage.dart';
import 'guestWifi/GuestWifiPage.dart';
import 'smartRateLimit/smartRateLimitPage.dart';

class ToolBoxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToolBoxPageState();
}

class _ToolBoxPageState extends State<ToolBoxPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    logger.d('ControlPage build');
    return Scaffold(
        key: _scaffoldState,
        appBar: PreferredSize(
          preferredSize: Size(100, 60),
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
              actions: <Widget>[
//                FlatButton(
//                  child: Text('old'),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => RouterSettingsPage(),
//                      ),
//                    );
//                  },
//                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                S.of(context).toolbox,
                style: ITextStyles.pageTitleStyle,
              ),
            ),
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.1),
                  children: <Widget>[
                    ///wifi设置
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.wifi,
                              color: Colors.red,
                            ),
                            Gaps.hGap5,
                            Text(
                              S.of(context).wifiSetings,
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WifiSettingPage(),
                          ),
                        );
                      },
                    ),

                    ///上网设置
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/shangwangshezhi.png"),
                              color: Colors.blue,
                            ),
                            Gaps.hGap5,
                            Text(
                              S.of(context).networkSettings,
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            settings:
                                RouteSettings(name: WanConnectSettingPage.name),
                            builder: (context) => WanConnectSettingPage()));
                      },
                    ),

                    ///防蹭网
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.security,
                              color: Colors.green,
                            ),
                            Gaps.hGap5,
                            Text(
                              S.of(context).wifiGuard,
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AntiStealPage(),
                          ),
                        );
                      },
                    ),

                    ///访客网络
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/fangke.png"),
                              color: Colors.yellow,
                            ),
                            Gaps.hGap5,
                            Text(
                              S.of(context).guestWifi,
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuestWifiPage(),
                          ),
                        );
                      },
                    ),

                    ///智能限速
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/zhinengkongzhi.png"),
                            ),
                            Gaps.hGap5,
                            Text(
                              S.of(context).intelligentSpeedLimit,
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SmartRateLimitPage(),
                          ),
                        );
                      },
                    ),

                    ///一键体检
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/inspect.png"),
                              color: Colors.blue,
                            ),
                            Gaps.hGap5,
                            Text(
                              "一键体检",
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceDetectPage(),
                          ),
                        );
                      },
                    ),

                    ///一键测速
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/yijianceshu.png"),
                              color: Colors.blue,
                            ),
                            Gaps.hGap5,
                            Text(
                              S.of(context).testSpeed,
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestSpeedPage3(),
                          ),
                        );
                      },
                    ),

                    ///MESH
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/mesh.png"),
                              color: Colors.orange,
                            ),
                            Gaps.hGap5,
                            Text(
                              "MESH",
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeshPage(),
                          ),
                        );
                      },
                    ),

                    ///重启设置
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/images/reboot.png"),
                            ),
                            Gaps.hGap5,
                            Text(
                              "重启设置",
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RebootRouterPage(),
                          ),
                        );
                      },
                    ),

                    ///高级设置
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.settings,
                            ),
                            Gaps.hGap5,
                            Text(
                              "高级设置",
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdvancedSettingsPage(),
                          ),
                        );
                      },
                    ),

                    ///升级助手
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.file_upload,
                              color: Colors.yellow,
                            ),
                            Gaps.hGap5,
                            Text(
                              "升级助手",
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpgradeSystemPage(),
                          ),
                        );
                      },
                    ),

                    ///路由信息
                    IconButton(
                      iconSize: 50,
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: Colors.green,
                            ),
                            Gaps.hGap5,
                            Text(
                              "路由信息",
                              style: ITextStyles.pageTextStyle,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceInfoPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
//                MyDivider(),
//
//                ///系统升级
//                MyListTile(
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => UpgradeSystemPage()));
//                  },
//                  leading: Icon(
//                    Icons.file_upload,
//                    color: Colors.blue,
//                  ),
//                  trailing: Icon(Icons.chevron_right),
//                  title: Text(
//                    S.of(context).systemUpgrade,
//                    style: ITextStyles.pageTextStyle,
//                  ),
//                ),
//                MyDivider(),
//
//                ///更多工具
//                MyListTile(
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => MoreToolsPage(),
//                      ),
//                    );
//                  },
//                  leading: Icon(
//                    Icons.view_module,
//                    color: Colors.green,
//                  ),
//                  trailing: Icon(Icons.chevron_right),
//                  title: Text(
//                    S.of(context).moreTools,
//                    style: ITextStyles.pageTextStyle,
//                  ),
//                ),
//                MyDivider()
              ],
            ),
          );
        }));
  }

  void _chooseSpeedTestMethod() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              '选择测速方式',
              style: ITextStyles.pageTextStyle,
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TestSpeedPage();
                  }));
                },
                child: Text(
                  'xxxx测速',
                  style: ITextStyles.pageTextStyle,
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TestSpeedPage2();
                  }));
                },
                child: Text(
                  '深度测速',
                  style: ITextStyles.black_font12,
                ),
              )
            ],
          );
        });
  }
}

enum Department { treasury, state }
