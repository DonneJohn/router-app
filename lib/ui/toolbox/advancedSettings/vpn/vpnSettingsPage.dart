import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/getVpnsBloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/updateVpnBloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/updateVpnPolicyBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/vpn/getVpnsResponse.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/vpn/addVpnPage.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/vpn/vpnDistinationsListPage.dart';
import 'package:hg_router/ui/custom/myListTile.dart';

class VpnSettingsPage extends StatefulWidget {
  static const name = 'ItemNetConnectType';

  @override
  State<StatefulWidget> createState() => _VpnSettingsPageState();
}

class _VpnSettingsPageState extends State<VpnSettingsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> titleList = ['vpn1', 'vpn2', 'vpn3'];
  GetVpnsBloc getVpnsBloc;
  List<Vpn> vpnList = List<Vpn>();
  String vpnPolicy = '';

  @override
  void initState() {
    getVpnsBloc = GetVpnsBloc();
    getVpnsBloc.getVpns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('_ItemVpnSettingsState build');

    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        title: S.of(context).vpnSetting,
        preferredSize: Size(double.infinity, 100),
      ),
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: getVpnsBloc.subject.stream,
          builder: (context, AsyncSnapshot<GetVpnsResponse> snapshot) {
            if (snapshot.hasData) {
              logger.i(snapshot.data.toJson());
              vpnPolicy = snapshot.data.return_parameter.result.policy;
              vpnList = snapshot.data.return_parameter.result.vpn;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.symmetric(vertical: 10),
//                    color: Colors.blue,
//                    width: double.infinity,
//                    height: 170,
//                    child: Column(
//                      children: <Widget>[
//                        Icon(
//                          FontAwesomeIcons.battleNet,
//                          size: 100,
//                          color: Colors.white,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.all(8),
//                        ),
//                        Text(
//                          S.of(context).internet_status,
//                          style: ITextStyles.pageTextStyleWhite,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.all(4),
//                        ),
//                      ],
//                    ),
//                  ),

                    ///服务器列表
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).serverList,
                        style: ITextStyles.pageSubTextStyle,
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    VpnItemWidget(vpnList: vpnList),

                    ///添加VPN配置
                    MyListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddVpnPage()));
                        },
                        title: Text(S.of(context).addVpn),
                        subtitle: Text('pptp'),
                        trailing: Icon(Icons.chevron_right)),
                    Divider(
                      height: 1,
                    ),

                    ///智能vpn限流
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).intelligenceVpn,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),

                    ///按服务地址限流 TODO
                    MyListTile(
                      onTap: () {},
                      title: Text(
                        S.of(context).limitByAddress,
                        style: ITextStyles.pageTextStyle,
                      ),
                      trailing: Switch(
                        value: vpnPolicy == 'destination ' ? true : false,
                        onChanged: (onValue) {
                          logger.i(onValue);
                          if (onValue) {
                            _updateVpnPolicy('destination');
                          } else {
                            _updateVpnPolicy('none');
                          }
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),

                    ///地址列表
                    Offstage(
                      offstage: vpnPolicy == 'destination' ? false : true,
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VpnDestinationsListPage()));
                          },
                          title: Text(
                            S.of(context).addressList,
                            style: ITextStyles.pageTextStyle,
                          ),
                          trailing: Icon(Icons.chevron_right)),
                    ),
                    Divider(
                      height: 1,
                    ),

                    ///按照选择设备限流
                    MyListTile(
                      onTap: () {},
                      title: Text(
                        S.of(context).limitByDevice,
                        style: ITextStyles.pageTextStyle,
                      ),
                      trailing: Switch(
                        value: vpnPolicy == 'source' ? false : true,
                        onChanged: (onValue) {
                          if (onValue) {
                            _updateVpnPolicy('source');
                          } else {
                            _updateVpnPolicy('none');
                          }
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Offstage(
                      offstage: vpnPolicy == 'source' ? true : false,
                      child: ListTile(
                          onTap: () {},
                          title: Text(
                            '设备列表',
                            style: ITextStyles.pageTextStyle,
                          ),
                          trailing: Icon(Icons.chevron_right)),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _updateVpnPolicy(String policy) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    var updateVpnPolicyBloc = UpdateVpnPolicyBloc();
    updateVpnPolicyBloc.setVpnPolicy(policy);
    updateVpnPolicyBloc.outUpdateVpnPolicy.listen((onDate) {
      if (onDate.return_parameter.status == '0') {
        logger.d("vpn update success");
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('设置成功'),
        ));
        getVpnsBloc.getVpns();
        setState(() {
          vpnPolicy = policy;
        });
      } else {
        ///TODO
      }
    });
  }
}

class VpnItemWidget extends StatefulWidget {
  List<Vpn> vpnList;

  VpnItemWidget({Key key, this.vpnList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VpnItemWidgetState();
}

class _VpnItemWidgetState extends State<VpnItemWidget> {
  ScaffoldFeatureController showSnackBar;

  @override
  void initState() {
    super.initState();
    logger.d("vpn length: " + widget.vpnList.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => _getItem(context, index),
            separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
            itemCount: widget.vpnList.length);
      },
    );
  }

  Widget _getItem(BuildContext context, int index) {
    bool _isStatusOpen = widget.vpnList[index].status == 'on' ? true : false;
    return MyListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddVpnPage(
                      id: index.toString(),
                    )));
      },
      title: Text(widget.vpnList[index].name ?? ""),
      subtitle: Text(widget.vpnList[index].protocol ?? ""),
      trailing: Switch(
        value: _isStatusOpen,
        onChanged: (value) {
          _showSnackBar(context, '正在设置');
          _updateVpn(index.toString(), status: value ? 'on' : 'off');
          setState(() {
            if (value) {
              widget.vpnList[index].status = "on";
            } else {
              widget.vpnList[index].status = "off";
            }
          });
        },
      ),
    );
  }

  _showSnackBar(BuildContext context, String text) {
    showSnackBar = Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Container(
          child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }

  _updateVpn(String id,
      {String protocol,
      String server,
      String username,
      String password,
      String status}) {
    UpdateVpnsBloc bloc = UpdateVpnsBloc();
    bloc.setVpns(id,
        protocol: protocol,
        username: username,
        password: password,
        status: status);
    var outSetVpnInfo = bloc.outSetVpnInfo;
    outSetVpnInfo.listen((onData) {
      if (onData.return_parameter.status == '0') {
        Future.delayed(Duration(seconds: 2), () {
          showSnackBar.close();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('设置成功'),
          ));
        });
      }
    });
  }
}
