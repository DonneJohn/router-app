import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wifiSettings/getWifiInfoBloc.dart';
import 'package:hg_router/bloc/toolbox/wifiSettings/setWifiInfoBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myListTile.dart';

class WifiSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WifiSettingPageState();
}

class _WifiSettingPageState extends State<WifiSettingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _24GIsOpen = false;
  String _24GSSID;
  String _24GSecurity;
  String _24GSignal;
  String _24GSecret;
  bool _24GHidden;

  bool _5GIsOpen = false;
  String _5GSSID;
  String _5GSecurity;
  String _5GSignal;
  String _5GSecret;
  bool _5GHidden;
  bool isLoading = true;
  bool isError = false;

  List<String> securityList = ['WPA', 'WPA/WPA2', 'open'];
  List<String> signalList = ['super', 'standard', 'green'];
  TextEditingController _24GwifiSSIDController = TextEditingController();
  TextEditingController _24GwifiPwdController = TextEditingController();
  TextEditingController _5GwifiSSIDController = TextEditingController();
  TextEditingController _5GwifiPwdController = TextEditingController();
  bool _obscureText = true;

  GetWifiInfoBloc bloc;
  ScaffoldFeatureController showSnackBar;

  @override
  void initState() {
    super.initState();
    _getWifiInfo();
  }

  _getWifiInfo() {
    bloc = GetWifiInfoBloc();
    bloc.getWifiInfo('wifi');
    bloc.getWifiInfo('wifi5G');
    bloc.subject.stream.listen((onData) {
      logger.d('get wifi response ${onData.toString()}');
      if (onData.errorCode == 900) {
        if (!mounted) return;
        setState(() {
          logger.d("set error widget");
          isLoading = false;
          isError = true;
        });
        return;
      }
      if (onData.return_parameter.status == '0') {
        if (!mounted) return;
        setState(() {
          isLoading = false;
          logger.i('_handleWifiInfo');
          var parameter = onData.return_parameter;
          if (parameter.result.type == 'wifi') {
            var result = parameter.result;
            _24GIsOpen = result.status == "on";
            _24GSSID = result.ssid;
            _24GwifiSSIDController.text = _24GSSID;

            _24GSecret = result.secret;
            _24GwifiPwdController.text = _24GSecret;

            _24GSecurity = result.security;
            _24GSignal = result.signal;
            _24GSecret = result.secret;
            _24GHidden = result.hidden == 'true';
          } else if (parameter.result.type == 'wifi5G') {
            var result = parameter.result;
            _5GIsOpen = result.status == "on";
            _5GSSID = result.ssid;
            _5GwifiSSIDController.text = _5GSSID;

            _5GSecret = result.secret;
            _5GwifiPwdController.text = _5GSecret;

            _5GSecurity = result.security;
            _5GSignal = result.signal;
            _5GSecret = result.secret;
            _5GHidden = result.hidden == 'true';
          }
        });
      } else {
        if (!mounted) return;
        setState(() {
          logger.d("set error widget");
          isLoading = false;
          isError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  'WI-FI设置',
                  style: ITextStyles.pageTitleStyle,
                ),
                margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
              ),
//            actions: <Widget>[
//              FlatButton(
//                onPressed: () {
//                  _setWifiInfo();
//                },
//                child: Text(
//                  '保存',
//                  style: ITextStyles.pageTextStyleWhite,
//                ),
//              )
//            ],
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : isError
                ? Center(
                    child: Text('出错了'),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
                              MyListTile(
                                title: Text(
                                  S.of(context).plug24g_wifi,

                                  ///2.4G Wi-Fi开关
                                  style: ITextStyles.pageTextStyle,
                                ),
                                trailing: Switch(
                                  activeTrackColor: Colors.green,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    if (value) {
                                      setState(() {
                                        _24GIsOpen = true;
                                        _setWifiInfo(
                                            type: "wifi", status: "on");
                                      });
                                    } else {
                                      setState(() {
                                        _24GIsOpen = false;
                                        _setWifiInfo(
                                            type: "wifi", status: "off");
                                      });
                                    }
                                  },
                                  value: _24GIsOpen ?? true,
                                ),
                              ),
                              Offstage(
                                offstage: !_24GIsOpen,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        controller: _24GwifiSSIDController,
                                        decoration: InputDecoration(
                                          ///名称
                                          labelText: S.of(context).SSID,

                                          labelStyle: ITextStyles.pageTextStyle,
                                        ),
                                      ),
                                    ),
                                    MyListTile(
                                      onTap: () {
                                        _showChooseSecurityBottomSheet(
                                            securityList, true);
                                      },
                                      title: Text(
                                        ///加密方式
                                        S.of(context).encryptType,
                                        style: ITextStyles.pageTextStyle,
                                      ),
                                      subtitle: Text(
                                          _24GSecurity ?? '混合加密(WPA/WPA2)',
                                          style: ITextStyles.pageSubTextStyle),
                                      trailing: Icon(Icons.chevron_right),
                                    ),

                                    ///信号强度
//                          MyListTile(
//                            onTap: () {
//                              _showChooseSignalBottomSheet(signalList, true);
//                            },
//
//                            title: Text(S.of(context).SignalStrength,
//                                style: ITextStyles.pageTextStyle),
//
//                            subtitle: Text(_24GSignal ?? '穿墙',
//                                style: ITextStyles.pageSubTextStyle),
//                            trailing: Icon(Icons.chevron_right),
//                          ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        obscureText: _obscureText,
                                        controller: _24GwifiPwdController,
                                        decoration: InputDecoration(
                                          labelText: S.of(context).password,

                                          ///密码
                                          labelStyle: ITextStyles.pageTextStyle,
                                          suffixIcon: IconButton(
                                            icon: new Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    MyListTile(
                                      title: Text(
                                        S.of(context).hideWifi,

                                        ///隐藏网络不被人发现
                                        style: ITextStyles.grey_font13,
                                      ),
                                      trailing: Switch(
                                        activeTrackColor: Colors.green,
                                        activeColor: Colors.white,
                                        value: _24GHidden ?? true,
                                        onChanged: (value) {
                                          setState(() {
                                            _24GHidden = value;
                                          });
                                        },
                                      ),
                                    ),
                                    OutlineButton(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        child: Text(
                                          "保存",
                                          style: ITextStyles.pageTextStyle,
                                        ),
                                      ),
                                      onPressed: () {
                                        _setWifiInfo(
                                            type: 'wifi',
                                            status: 'on',
                                            ssid: _24GSSID,
                                            hidden: _24GHidden.toString(),
                                            security: _24GSecurity,
                                            secret: _24GSecret);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.vGap15,
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          child: Column(
                            children: <Widget>[
                              ///5G 开关
                              MyListTile(
                                title: Text(
                                  ///5G
                                  S.of(context).Plug_5g_wifi,
                                  style: ITextStyles.pageTextStyle,
                                ),
                                trailing: Switch(
                                  activeTrackColor: Colors.green,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    if (value) {
                                      setState(() {
                                        _5GIsOpen = true;
                                      });

                                      _setWifiInfo(
                                          type: "wifi5G", status: "on");
                                    } else {
                                      setState(() {
                                        _5GIsOpen = false;
                                      });

                                      _setWifiInfo(
                                          type: "wifi5G", status: "off");
                                    }
                                  },
                                  value: _5GIsOpen ?? true,
                                ),
                              ),
                              Offstage(
                                offstage: !_5GIsOpen,
                                child: Column(
                                  children: <Widget>[
                                    ///5G SSID
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        controller: _5GwifiSSIDController,
                                        decoration: InputDecoration(
                                            labelText: S.of(context).SSID,
                                            labelStyle:
                                                ITextStyles.pageSubTextStyle),
                                      ),
                                    ),

                                    ///5G加密方式
                                    MyListTile(
                                      onTap: () {
                                        _showChooseSecurityBottomSheet(
                                            securityList, false);
                                      },
                                      title: Text(S.of(context).encryptType,
                                          style: ITextStyles.pageTextStyle),
                                      subtitle: Text(
                                          _5GSecurity ?? '混合加密(WPA/WPA2)',
                                          style: ITextStyles.pageSubTextStyle),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
//                          MyListTile(
//                            onTap: () {
//                              _showChooseSignalBottomSheet(signalList, false);
//                            },
//                            title: Text(S.of(context).SignalStrength,
//                                style: ITextStyles.pageTextStyle),
//                            subtitle: Text(_5GSignal ?? '穿墙',
//                                style: ITextStyles.pageSubTextStyle),
//                            trailing: Icon(Icons.chevron_right),
//                          ),
                                    ///5G 密码
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        obscureText: _obscureText,
                                        controller: _5GwifiPwdController,
                                        decoration: InputDecoration(
                                          labelText: S.of(context).password,
                                          labelStyle: ITextStyles.pageTextStyle,
                                          suffixIcon: IconButton(
                                            icon: new Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///5G隐藏网络
                                    MyListTile(
                                      title: Text(
                                        S.of(context).hideWifi,
                                        style: ITextStyles.grey_font13,
                                      ),
                                      trailing: Switch(
                                        activeTrackColor: Colors.green,
                                        activeColor: Colors.white,
                                        value: _5GHidden ?? true,
                                        onChanged: (value) {
                                          setState(() {
                                            _5GHidden = value;
                                          });
                                        },
                                      ),
                                    ),

                                    ///确定
                                    OutlineButton(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        child: Text(
                                          "保存",
                                          style: ITextStyles.pageTextStyle,
                                        ),
                                      ),
                                      onPressed: () {
                                        _setWifiInfo(
                                            type: 'wifi5G',
                                            status: 'on',
                                            ssid: _5GSSID,
                                            hidden: _5GHidden.toString(),
                                            security: _5GSecurity,
                                            secret: _5GSecret);
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Gaps.vGap15,
                            ],
                          ),
                        ),
//                    OutlineButton(
//                      child: Container(
//                        alignment: Alignment.center,
//                        width: 200,
//                        child: Text(
//                          S.of(context).ok,
//                          style: ITextStyles.pageTextStyle,
//                        ),
//                      ),
//                      onPressed: () {
//                        _setWifiInfo();
//                      },
//                    )
                      ],
                    )));
  }

  _setWifiInfo(
      {String type,
      String status,
      String ssid,
      String hidden,
      String channel,
      String bandwidth,
      String power,
      String signal,
      String security,
      String secret}) {
    _showCircularSnakeBar(true, '正在设置');
    SetWifiInfoBloc setWifiInfoBloc = SetWifiInfoBloc();
    setWifiInfoBloc.setWifiInfo(
        type: type,
        status: status,
        ssid: ssid,
        hidden: hidden,
        channel: channel,
        bandwidth: bandwidth,
        power: power,
        signal: signal,
        security: security,
        secret: secret);
    var outSetWifiInfo = setWifiInfoBloc.outSetWifiInfo;
    outSetWifiInfo.listen((onData) {
      logger.i(onData.toJson().toString());
      if (onData.return_parameter.status == '0') {
        showSnackBar.close();
//        _showCircularSnakeBar(false, '设置成功');
      }
    });
  }

  _showCircularSnakeBar(bool showCircularProgressIndicator, String title) {
    showSnackBar = _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          showCircularProgressIndicator
              ? CircularProgressIndicator()
              : Icon(Icons.info_outline),
          SizedBox(
            width: 10,
          ),
          Text(title)
        ],
      ),
    ));
  }

  _showChooseSecurityBottomSheet(List<String> title, bool is24G) async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, title[index]);
                    },
                    title: Text(title[index]),
                    leading: Icon(
                      Icons.chevron_right,
                      color: is24G
                          ? (_24GSecurity == title[index]
                              ? Colors.blue
                              : Colors.transparent)
                          : (_5GSecurity == title[index]
                              ? Colors.blue
                              : Colors.transparent),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 3),
          );
        });
    logger.i(result);
    if (is24G) {
      setState(() {
        _24GSecurity = result;
      });
    } else {
      setState(() {
        _5GSecurity = result;
      });
    }
  }

  _showChooseSignalBottomSheet(List<String> title, bool is24G) async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, title[index]);
                    },
                    title: Text(title[index]),
                    leading: Icon(
                      Icons.chevron_right,
                      color: is24G
                          ? (_24GSignal == title[index]
                              ? Colors.blue
                              : Colors.transparent)
                          : (_5GSignal == title[index]
                              ? Colors.blue
                              : Colors.transparent),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 3),
          );
        });
    logger.i(result);
    if (is24G) {
      setState(() {
        _24GSignal = result;
      });
    } else {
      setState(() {
        _5GSignal = result;
      });
    }
  }
}
