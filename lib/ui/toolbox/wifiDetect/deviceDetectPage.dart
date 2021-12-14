import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/deviceDetectBloc.dart';
import 'package:hg_router/models/toolbox/deviceDetect/deviceDetectResponseModel.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/28/0028 14:38
///
class DeviceDetectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeviceDetectPageState();
}

class _DeviceDetectPageState extends State<DeviceDetectPage> {
  DeviceDetectBloc bloc;
  String phase;
  String wanState;
  String internetState;
  String wifiState;
  String wifi5GState;

  String wifiPassword;
  String wifi5GPassword;
  String adminPassword;

  @override
  void initState() {
    super.initState();
    bloc = DeviceDetectBloc();
    bloc.deviceDetect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "一键体检",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              if (bloc != null) {
                bloc.deviceDetect();
              }
            },
            child: Text(
              "重新体检",
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: bloc.subject.stream,
          builder:
              (context, AsyncSnapshot<DeviceDetectResponseModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.errorCode == 900) {
                return Center(child: Text("出错了"));
              }
              var result = snapshot.data.return_parameter.result;
              phase = result.phase;
              if (result.wanState != null) {
                wanState = result?.wanState;
              }
              if (result.internetState != null) {
                internetState = result?.internetState?.status;
              }
              if (result.wifiState != null) {
                wifiState = result?.wifiState?.status;
              }

              if (result.wifiState != null) {
                wifi5GState = result?.wifi5GState?.status;
              }
              if (result.password != null) {
                wifiPassword = result.password.wifiPassword;
                wifi5GPassword = result.password.wifi5GPassword;
                adminPassword = result.password.adminPassword;
              }

              return Stack(
                children: <Widget>[
                  LinearProgressIndicator(
                    backgroundColor: Colours.priBlue,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: ListView(
                        children: <Widget>[
                          Offstage(
                            offstage: phase == "wanDetect",
                            child: ListTile(
                              title: Text('WAN故障检测'),
                              trailing: wanState == null
                                  ? CircularProgressIndicator()
                                  : Text(wanState),
                            ),
                          ),
                          Offstage(
                            offstage: phase == "internetDetect",
                            child: ListTile(
                              title: Text('上网状态检测'),
                              trailing: internetState == null
                                  ? CircularProgressIndicator()
                                  : Text(internetState),
                            ),
                          ),
                          Offstage(
                            offstage: phase == "wifiDetect",
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text('无线状态检测'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ListTile(
                                    title: Text(
                                      '2.4G是否开启',
                                      style: ITextStyles.grey_font13,
                                    ),
                                    trailing: wifiState == null
                                        ? CircularProgressIndicator()
                                        : Text(wifiState),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ListTile(
                                    title: Text(
                                      '5G是否开启',
                                      style: ITextStyles.grey_font13,
                                    ),
                                    trailing: wifi5GState == null
                                        ? CircularProgressIndicator()
                                        : Text(wifi5GState),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Offstage(
                            offstage: phase == "complete",
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text('无线密码检测'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ListTile(
                                    title: Text(
                                      '2.4G密码',
                                      style: ITextStyles.grey_font13,
                                    ),
                                    trailing: wifiPassword == null
                                        ? CircularProgressIndicator()
                                        : Text(wifiPassword),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ListTile(
                                    title: Text(
                                      '5G密码',
                                      style: ITextStyles.grey_font13,
                                    ),
                                    trailing: wifi5GPassword == null
                                        ? CircularProgressIndicator()
                                        : Text(wifi5GPassword),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Offstage(
                            offstage: phase == "wanDetect",
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text('路由器密码检测'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ListTile(
                                    title: Text(
                                      '路由器密码',
                                      style: ITextStyles.grey_font13,
                                    ),
                                    trailing: adminPassword == null
                                        ? CircularProgressIndicator()
                                        : Text(adminPassword),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
