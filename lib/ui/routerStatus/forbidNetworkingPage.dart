import 'package:flutter/material.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/setInternetConnectBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/toolbox/routerSetting/rebootSchedulePage.dart';
import 'package:hg_router/utils/utils.dart';

class ForbidNetworkingPage extends StatefulWidget {
  String internetConnect;
  final String mac;

  ForbidNetworkingPage({Key key, this.internetConnect, this.mac})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForbidNetworkingPageState();
}

class _ForbidNetworkingPageState extends State<ForbidNetworkingPage> {
  @override
  void initState() {
    logger.i(widget.internetConnect);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).forbid_network,
            style: ITextStyles.appBarTitleStyle,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                height: 50,
                child: MyListTile(
                  onTap: () {
                    setInternetConnect(context, "false");
                  },
                  title: Text(S.of(context).no_setting,
                      style: ITextStyles.pageTextStyle),
                  leading: Icon(
                    Icons.chevron_right,
                    color: widget.internetConnect == S.of(context).notSet
                        ? Colors.blue
                        : Colors.transparent,
                  ),
                ),
              ),
              MyDivider(myHeight: 1),
              MyListTile(
                onTap: () {
                  setInternetConnect(context, "true");
                },
                title: Text(
                  '禁止联网',
                  style: ITextStyles.pageTextStyle,
                ),
                subtitle: Text('设备无法连接外网', style: ITextStyles.pageSubTextStyle),
                leading: Icon(
                  Icons.chevron_right,
                  color: widget.internetConnect == S.of(context).forbitInternet
                      ? Colors.blue
                      : Colors.transparent,
                ),
              ),
              MyDivider(myHeight: 1),
              MyListTile(
                onTap: () {
                  setInternetConnect(context, "timing");
                },
                leading: Icon(
                  Icons.chevron_right,
                  color: widget.internetConnect == S.of(context).limitedPeriod
                      ? Colors.blue
                      : Colors.transparent,
                ),
                title: Text('定时断网', style: ITextStyles.pageTextStyle),
                subtitle:
                    Text('设置设备禁止联网时间', style: ITextStyles.pageSubTextStyle),
                trailing: Padding(
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                    padding: EdgeInsets.all(4),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return RebootSchedulePage();
                      }));
                    },
                    icon: Icon(
                      Icons.chevron_right,
                    ),
                    color: Colors.grey,
                  ),
                ),
              ),
              MyDivider(myHeight: 1),
            ],
          );
        },
      ),
    );
  }

  setInternetConnect(BuildContext context, String status) {
    var showCircularSnackBar = Util.showCircularSnackBar(context, '正在设置');
    var setInternetConnectBloc = SetInternetConnectBloc();
    setInternetConnectBloc.setInternetConnect(widget.mac, status);
    setInternetConnectBloc.outSetInternetConnect.listen((onData) {
      if (onData.return_parameter.status == '0') {
        if (status == "timing") {
          setState(() {
            widget.internetConnect = S.of(context).limitedPeriod;
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return RebootSchedulePage();
          }));
        } else if (status == 'false') {
          showCircularSnackBar.close();
          Navigator.pop(context, status);
          return;
        } else if (status == 'true') {
          setState(() {
            widget.internetConnect = S.of(context).forbitInternet;
          });
        }
      }
    });
  }
}
