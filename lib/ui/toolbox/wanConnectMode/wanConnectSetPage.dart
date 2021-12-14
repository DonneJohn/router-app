import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wanSettings/getNetworkBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/toolbox/wanSettings/getNetworkResponseModel.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/toolbox/wanConnectMode/netConnectTypeRepeater.dart';

import 'netConnectTypeDHCP.dart';
import 'netConnectTypePPPOE.dart';
import 'netConnectTypeStatic.dart';

class WanConnectSettingPage extends StatefulWidget {
  static const name = 'ItemNetConnectType';

  @override
  State<StatefulWidget> createState() => _WanConnectSettingPageState();
}

class _WanConnectSettingPageState extends State<WanConnectSettingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> title = ['static', 'pppoe', 'dhcp'];
  GetNetworkBloc getNetworkBloc;
  String ip;
  String gateway;

  bool isShowIndicator = false;
  String dnsMode = '';
  String mode = "PPPOE";
  String networkStatus;
  String pppoeUsername;
  String pppoePasword;

  @override
  void initState() {
    getNetworkBloc = GetNetworkBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('ItemNetConnectType build');
    getNetworkBloc.getNetwork();
    return Scaffold(
      key: _scaffoldKey,
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
                '上网模式设置',
                style: ITextStyles.pageTitleStyle,
              ),
              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: getNetworkBloc.subject.stream,
          builder: (context, AsyncSnapshot<GetNetworkResponseModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.errorCode == 900) {
                return Center(child: Text('出错了'));
              }

              var result = snapshot.data.return_parameter.result;
              isShowIndicator = true;
              ip = result.ip;
              gateway = result.gateway;
              mode = result.mode;
              dnsMode = result.dnsMode;
              networkStatus = result.status;
              pppoeUsername = result.PPPoE?.username;
              pppoePasword = result.PPPoE?.password;
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    MyListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(
                                    name: NetConnectTypeDHCP.routeName),
                                builder: (context) =>
                                    NetConnectTypeDHCP(dnsMode: dnsMode)));
                      },

                      ///当前模式
                      title: Text(
                        S.of(context).CurrentMode,
                        style: ITextStyles.pageTextStyle,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(canvasColor: Colors.grey),
                              child: DropdownButton<String>(
                                value: mode,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                iconSize: 20,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 2,
                                  color: Colours.priRed,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    mode = newValue;
                                  });
                                  switch (newValue) {
                                    case "PPPoE":
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return NetConnectTypePPPOE(
                                          username: pppoeUsername ?? "",
                                          password: pppoePasword ?? "",
                                        );
                                      }));
                                      break;
                                    case "DHCP":
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return NetConnectTypeDHCP(
                                          dnsMode: dnsMode,
                                        );
                                      }));
                                      break;
                                    case "Static":
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return NetConnectTypeStatic();
                                      }));
                                      break;
                                    case "Repeater":
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              settings: RouteSettings(
                                                  name: NetConnectTypeRepeater
                                                      .name),
                                              builder: (context) =>
                                                  NetConnectTypeRepeater()));

                                      break;
                                  }
                                },
                                items: <String>[
                                  "PPPoE",
                                  "DHCP",
                                  "Static",
                                  "Repeater"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    MyListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(
                                    name: NetConnectTypeDHCP.routeName),
                                builder: (context) =>
                                    NetConnectTypeDHCP(dnsMode: dnsMode)));
                      },

                      ///网络状态
                      title: Text(
                        "网络状态",
                        style: ITextStyles.pageTextStyle,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              networkStatus ?? S.of(context).internet_status,
                              style: ITextStyles.pageTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(
                                    name: NetConnectTypeDHCP.routeName),
                                builder: (context) =>
                                    NetConnectTypeDHCP(dnsMode: dnsMode)));
                      },

                      ///IP
                      title: Text(
                        "IP",
                        style: ITextStyles.pageTextStyle,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              ip ?? '192.168.1.11',
                              style: ITextStyles.pageTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(
                                    name: NetConnectTypeDHCP.routeName),
                                builder: (context) =>
                                    NetConnectTypeDHCP(dnsMode: dnsMode)));
                      },

                      ///网关
                      title: Text(
                        "网关",
                        style: ITextStyles.pageTextStyle,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              gateway ?? '192.168.1.1',
                              style: ITextStyles.pageTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  _showChooseConnectTypeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: ListView.separated(
                itemBuilder: (context, index) => _getItem(title, index),
                separatorBuilder: (context, index) => MyDivider(),
                itemCount: 3),
          );
        });
  }

  _getItem(List<String> title, int index) {
    return MyListTile(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NetConnectTypeStatic()));
        } else if (index == 1) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NetConnectTypePPPOE()));
        } else if (index == 2) {
          Navigator.of(context).push(MaterialPageRoute(
              settings: RouteSettings(name: NetConnectTypeDHCP.routeName),
              builder: (context) => NetConnectTypeDHCP(dnsMode: dnsMode)));
        }
      },
      title: Text(title[index]),
    );
  }
}
