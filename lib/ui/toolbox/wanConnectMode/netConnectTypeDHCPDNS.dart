import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wanSettings/setNetworkBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/toolbox/wanSettings/setNetworkModel.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';

import 'wanConnectSetPage.dart';
import 'netConnectTypeDHCP.dart';

///
///Created by slkk on 2019/9/10/0010 16:16
///
class NetConnectTypeDHCPDNS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetConnectTypeDHCPDNSState();
}

class _NetConnectTypeDHCPDNSState extends State<NetConnectTypeDHCPDNS> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dnsController = TextEditingController();
  TextEditingController dns2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
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
                '手动设置动态IP',
                style: ITextStyles.pageTitleStyle,
              ),
              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: TextField(
              controller: dnsController,
              decoration: InputDecoration(
                  labelText: 'DNS1',
                  hintText: S.of(context).required,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 3, 16, 0),
            child: TextField(
              controller: dns2Controller,
              decoration: InputDecoration(
                  labelText: 'DNS2',
                  hintText: S.of(context).optional,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Color(0xFFFFFF00),
                      style: BorderStyle.solid,
                      width: 2)),
              onPressed: () {
                setDNS();
              },
              child: Container(
                alignment: Alignment.center,
                width: 300,
                child: Text(
                  S.of(context).ok,
                  style: ITextStyles.pageTextStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void setDNS() {
    var dns1 = dnsController.text.toString();
    var dns2 = dns2Controller.text.toString();
    if (dns1.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('dns 不能为空'),
      ));
    }
    var showSnackBar = _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
          child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('正在保存配置')
        ],
      )),
    ));
    var setNetworkBloc = SetNetworkBloc();
    setNetworkBloc.setNetwork('dhcp', dhcp: Dhcp(dns1, dns2));
    var stream = setNetworkBloc.subject.stream;
    stream.listen((onData) {
      logger.i(onData.return_parameter);
      if (onData.return_parameter.status == '0') {
        showSnackBar.close();
        Navigator.popUntil(
            context, ModalRoute.withName(WanConnectSettingPage.name));
      }
    });
  }

  _showChooseDHCPDnsType() {
    showModalBottomSheet(
        context: context,
        builder: (contexts) {
          return Container(
            child: Column(
              children: <Widget>[
                MyListTile(
                  onTap: () {
                    Navigator.of(context).popUntil(
                        ModalRoute.withName(NetConnectTypeDHCP.routeName));
                  },
                  leading: Icon(
                    Icons.chevron_right,
                    color: Colors.transparent,
                  ),
                  title: Text(S.of(context).autoSupport),
                ),
                MyDivider(),
                MyListTile(
                  leading: Icon(
                    Icons.chevron_right,
                    color: Colors.blue,
                  ),
                  title: Text('手动'),
                )
              ],
            ),
            height: 130,
          );
        });
  }
}
