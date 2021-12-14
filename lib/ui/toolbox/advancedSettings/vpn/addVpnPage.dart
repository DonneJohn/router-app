import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/addVpnsBloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/getVpnInfoBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/utils.dart';

///
///Created by slkk on 2019/9/12/0012 13:08
///

class AddVpnPage extends StatefulWidget {
  String id;
  String protocol;

  AddVpnPage({this.id});

  @override
  State<StatefulWidget> createState() => _AddVpnPageState();
}

class _AddVpnPageState extends State<AddVpnPage> {
  var modalBottomSheet;
  TextEditingController nameController = TextEditingController();
  TextEditingController serverController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    if (widget.id != null) {
      _initVpnInfo(widget.id);
    }

    super.initState();
  }

  _initVpnInfo(String id) {
    var getVpnInfoBloc = GetVpnInfoBloc();
    getVpnInfoBloc.getVpnInfo(id);
    getVpnInfoBloc.outGetVpnInfo.listen((onData) {
      if (onData.return_parameter.status == '0') {
        var result = onData.return_parameter.result;
        nameController.text = result.name;
        serverController.text = result.server;
        usernameController.text = result.username;
        passwordController.text = result.password;
        widget.protocol = result.password;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: "添加vpn配置",
        preferredSize: Size(double.infinity, 100),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              ///名称
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: S.of(context).name,
                      labelStyle: ITextStyles.pageTextStyleGrey),
                ),
              ),

              ///协议类型
              MyListTile(
                onTap: () {
                  _showChooseProtocolType();
                },
                title: Text(S.of(context).protocolType),
                subtitle: Text(widget.protocol ?? 'PPTP'),
                trailing: Icon(Icons.chevron_right),
              ),

              ///服务器
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: serverController,
                  decoration: InputDecoration(
                      labelText: S.of(context).server,
                      labelStyle: ITextStyles.pageTextStyleGrey),
                ),
              ),

              ///用户名
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: S.of(context).userName,
                      labelStyle: ITextStyles.pageTextStyleGrey),
                ),
              ),

              ///密码
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: S.of(context).password,
                      suffixIcon: Icon(Icons.visibility),
                      labelStyle: ITextStyles.pageTextStyleGrey),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),

              ///确定
              RoundButton(
                onPressed: () {
                  _addVpn(context);
                },
                width: 300,
                text: S.of(context).ok,
              ),
            ],
          );
        },
      ),
    );
  }

  _addVpn(BuildContext context) {
    if (nameController.text.isNotEmpty ||
        serverController.text.isNotEmpty ||
        usernameController.text.isNotEmpty ||
        passwordController.text.isNotEmpty) {
      AddVpnBloc addVpnsBloc = AddVpnBloc();
      addVpnsBloc.addVpn(
          name: nameController.text.toString(),
          server: serverController.text.toString(),
          protocol: widget.protocol,
          username: usernameController.text.toString(),
          password: passwordController.text.toString());
      var outAddVpnInfo = addVpnsBloc.outAddVpnInfo;
      outAddVpnInfo.listen((onData) {
        Navigator.pop(context);
      });
    } else {
      ///'名称,服务器，用户名，密码不能为空'
      Util.showSnackBar(context, '名称,服务器，用户名，密码不能为空');
    }
  }

  _showChooseProtocolType() {
    modalBottomSheet = showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Container(
                child: Column(
                  children: <Widget>[
                    MyListTile(
                      onTap: () {
                        setState(() {
                          widget.protocol = 'PPTP';
                        });
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.chevron_right,
                        color: widget.protocol == 'PPTP'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      title: Text('PPTP'),
                    ),
                    MyDivider(),
                    MyListTile(
                      onTap: () {
                        setState(() {
                          widget.protocol = 'L2TP';
                        });
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.chevron_right,
                        color: widget.protocol == 'L2TP'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      title: Text('L2TP'),
                    )
                  ],
                ),
                height: 130,
              );
            },
          );
        });
  }
}
