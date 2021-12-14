import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hg_router/api/getUpgradeApi.dart';
import 'package:hg_router/bloc/toolbox/getDeviceVersionBloc.dart';
import 'package:hg_router/bloc/toolbox/setUpgradeBloc.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/SpUtil.dart';

class UpgradeSystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpgradeSystemState();
}

class _UpgradeSystemState extends State<UpgradeSystemPage> {
  GlobalKey<ScaffoldState> _scaffodKey = GlobalKey<ScaffoldState>();
  GetDeviceVersionBloc bloc;
  String currentVersion;
  String platformVersion;
  bool checkUpgrade = false;
  bool isError = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUpgrade();
  }

  getUpgrade() {
    bloc = GetDeviceVersionBloc();
    bloc.getCurrentVersion();
    bloc.subject.listen((onData) {
      if (onData.errorCode == 900) {
        setState(() {
          isLoading = false;
          isError = true;
        });
        return;
      }
      if (onData.return_parameter.status == "0") {
        var result = onData.return_parameter.result;
        setState(() {
          currentVersion = result.currentVersion;
          isLoading = false;
        });
        logger.d("upgrade version: " + result.currentVersion);
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    });
  }

  Widget getBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (isError) {
        return Center(child: Text('出错了'));
      } else {
        return Column(
          children: <Widget>[
            MyListTile(
              title: Text(
                "路由器固件版本",
                style: ITextStyles.pageTextStyle,
              ),
              trailing: Text(
                currentVersion ?? '',
                style: ITextStyles.pageSubTextStyle,
              ),
            ),
            MyDivider(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      checkUpgrade = true;
                    });
                    _checkUpgrade(SpUtil.getString(Constant.routerMac));
                  },
                  child: Column(
                    children: <Widget>[
                      checkUpgrade
                          ? CircularProgressIndicator()
                          : Icon(
                              FontAwesomeIcons.sync,
                              color: Colours.priBlue,
                            ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        '检查更新',
                        style: ITextStyles.pageTextStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ))
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffodKey,
        appBar: MyAppBar(
          title: "升级助手",
          preferredSize: Size(double.infinity, 100),
        ),
        body: getBody());
  }

  void _checkUpgrade(String mac) {
    var getUpgradeApi = GetUpgradeApi();
    getUpgradeApi.getUpgrade(mac).then((onData) {
      Future.delayed(Duration(seconds: 3), () {
        _showGetUpgradeDialog(context);
        setState(() {
//        platformVersion = onData?.data?.version;
          checkUpgrade = false;
          platformVersion = "ddd";
        });
        logger.d("平台版本 $platformVersion");
      });
    });
  }

  void _showGetUpgradeDialog(BuildContext context) {
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
                        Text(
                          "检查更新",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: "发现新版本是否马上更新？")
                            ],
                          ),
                          TextSpan(text: "\n\n"),
                        ])),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlineButton(
                              child: Text(
                                '取消',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
//
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
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
                                _setUpgrade();
//                                    _cropImage(true);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
//          color: Colors.transparent,
        child: Container(
          height: 100,
          width: 100,
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
      ),
    );
  }

  _setUpgrade() {
    var setUpgradeBloc = SetUpgradeBloc();
    setUpgradeBloc.setUpgrade();
    setUpgradeBloc.subject.listen((onData) {
      if (onData.return_parameter.status == "0") {
        logger.d('升级成功');
        _scaffodKey.currentState.showSnackBar(SnackBar(
          content: Text("路由器正在升级，请耐心等待"),
        ));
      }
    });
  }
}
