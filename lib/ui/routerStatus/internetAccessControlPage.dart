import 'package:flutter/material.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/getInternetAccessBloc.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/setInternetAccessBloc.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/routerStatus/addBlackAndWhiteListPage.dart';
import 'package:hg_router/utils/utils.dart';

class InternetAccessControlPage extends StatefulWidget {
  final String mac;

  const InternetAccessControlPage({Key key, this.mac}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InternetAccessControlPageState();
}

class _InternetAccessControlPageState extends State<InternetAccessControlPage> {
  String _type;

  @override
  void initState() {
    var getInternetAccessBloc = GetInternetAccessBloc();
    getInternetAccessBloc.getInternetAccess(widget.mac);
    getInternetAccessBloc.outGetInternetAccess.listen((onData) {
      if (onData.return_parameter.status == '0') {
        setState(() {
          _type = onData.return_parameter.result.type;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '访问控制',
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
              MyListTile(
                onTap: () {
                  _updateInternetAccess(context, widget.mac, 'none');
                },
                title: Text('无设置', style: ITextStyles.pageTextStyle),
                leading: Icon(
                  Icons.chevron_right,
                  color: _type == 'none' ? Colors.blue : Colors.transparent,
                ),
              ),
              MyDivider(),

              ///网址黑名单
              MyListTile(
                onTap: () {
                  _updateInternetAccess(context, widget.mac, 'blacklist');
                },
                leading: Icon(
                  Icons.chevron_right,
                  color:
                      _type == 'blacklist' ? Colors.blue : Colors.transparent,
                ),
                title: Text(
                  '网址黑名单',
                  style: ITextStyles.pageTextStyle,
                ),
                trailing: Padding(
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBlackAndWhiteListPage(
                              actionBarTitle: '网址黑名单',
                              mac: widget.mac,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )),
                ),
              ),
              MyDivider(),

              ///网址白名单
              MyListTile(
                leading: Icon(
                  Icons.chevron_right,
                  color:
                      _type == 'whitelist' ? Colors.blue : Colors.transparent,
                ),
                title: Text(
                  '网址白名单',
                  style: ITextStyles.pageTextStyle,
                ),
                trailing: Padding(
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBlackAndWhiteListPage(
                              actionBarTitle: '网址白名单',
                              mac: widget.mac,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )),
                ),
                onTap: () {
                  _updateInternetAccess(context, widget.mac, 'whitelist');
                },
              )
            ],
          );
        },
      ),
    );
  }

  _updateInternetAccess(BuildContext context, String host, String type) {
    var showCircularSnackBar = Util.showCircularSnackBar(context, '正在设置');
    var setInternetAccessBloc = SetInternetAccessBloc();
    setInternetAccessBloc.setInternetAccess(host, type);
    setInternetAccessBloc.outSetInternetAccess.listen((onData) {
      if (onData.return_parameter.status == '0') {
        if (type == 'none') {
          Future.delayed(Duration(seconds: 1), () {
            showCircularSnackBar.close();
            Navigator.pop(context);
          });
        } else {
          setState(() {
            _type = type;
          });
          Future.delayed(Duration(seconds: 1), () {
            showCircularSnackBar.close();
          });
        }
      }
    });
  }
}
