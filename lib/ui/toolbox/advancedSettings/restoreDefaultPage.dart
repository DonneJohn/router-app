import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/restoreDefaultBloc.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/utils.dart';

///
///Created by slkk on 2019/9/18/0018 09:31
///

class RestoreDefaultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestoreDefaultPageState();
}

class _RestoreDefaultPageState extends State<RestoreDefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
       preferredSize: Size(double.infinity,100),
        title: "恢复出厂设置",
      ),
      body: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 0, 0),
                child: Text(
                  '一定清除',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('个人数据'),
                subtitle: Text('包括账户，设备联网日志，路由器设置等'),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                onPressed: () {
                  _doRestoreDefault(context);
                },
                margin: EdgeInsets.all(20),
                text: '立即恢复出厂设置',
                style: TextStyle(color: Colors.red),
              )
            ],
          );
        },
      ),
    );
  }

  _doRestoreDefault(BuildContext context) {
    var showSnackBar = Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Text('正在恢复出厂')
        ],
      ),
    ));
    var restoreDefaultBloc = RestoreDefaultBloc();
    restoreDefaultBloc.restore();
    restoreDefaultBloc.outRestoreDefault.listen((onResponse) {
      if (onResponse.return_parameter.status == '0') {
        showSnackBar.close();
        Util.showSnackBar(context, '恢复出厂成功');
      }
    });
  }
}
