///
///Created by slkk on 2019/9/10/0010 15:42
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wanSettings/setNetworkBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myListTile.dart';

import '../../../main.dart';
import 'wanConnectSetPage.dart';
import 'netConnectTypeDHCPDNS.dart';
class NetConnectTypeDHCP extends StatefulWidget {
  final String dnsMode;
  static final routeName = 'route_NetConnectTypeDHCP';

  const NetConnectTypeDHCP({Key key, this.dnsMode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetConnectTypeDHCPState();
}

class _NetConnectTypeDHCPState extends State<NetConnectTypeDHCP> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  String dnsMode;

  @override
  void initState() {
    dnsMode = widget.dnsMode;
    super.initState();
  }

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
                '动态IP',
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
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ///自动(推荐)
                MyListTile(
                  title: Text(S.of(context).autoSupport),
                  trailing: Checkbox(
                    onChanged: (value) {
                      if (value) {
                        logger.i('true');
                        setDNS();
                        setState(() {
                          dnsMode = "auto";
                        });
                      } else {
                        logger.i('false');
                        setState(() {
                          dnsMode = "static";
                        });
                      }
                    },
                    value: dnsMode == "auto",
                  ),
                ),
                MyListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NetConnectTypeDHCPDNS()));
                  },
                  title: Text(S.of(context).manual),
                  trailing: Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Icon(Icons.chevron_right)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setDNS() {
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
    setNetworkBloc.setNetwork('DHCP');
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
}
