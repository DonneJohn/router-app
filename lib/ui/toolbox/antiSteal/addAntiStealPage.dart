import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/routerStatus/deviceListBloc.dart';
import 'package:hg_router/bloc/toolbox/antiSteal/addAntiStealBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/routerStatus/getHostsListResponse.dart';
import 'package:hg_router/models/toolbox/antiSteal/addAntiStealRequest.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/11/12/0012 14:02
///
class AddAntiStealPage extends StatefulWidget {
  final String type;

  const AddAntiStealPage({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddAntiStealPageState();
}

class _AddAntiStealPageState extends State<AddAntiStealPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String appbarTitle;
  List<Host> hostList;

  DeviceListBloc bloc;
  List<String> antiListMac = List<String>();
  List<AntiStealItem> antiList = List<AntiStealItem>();

  @override
  void initState() {
    appbarTitle = widget.type == "whitelist" ? "白名单" : "黑名单";
    bloc = DeviceListBloc();
    bloc.getDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "添加$appbarTitle",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              addAntiSteal();
            },
            child: Text(
              '保存',
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.subject.stream,
        builder: (context, AsyncSnapshot<HostsListResponse> snapshot) {
          if (snapshot.hasData) {
            hostList = snapshot.data.return_parameter.result.hosts;
            return Container(
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                    itemBuilder: (context, index) => getItem(context, index),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: hostList.length));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget getItem(BuildContext context, int index) {
    var host = hostList[index];
    var mac = host.mac;
    var nickname = host.nickname;
    bool isCheck = antiListMac.contains(mac);
    return CheckboxListTile(
      title: Text(host.nickname ?? ""),
      subtitle: Text(host.mac ?? ""),
      value: isCheck,
      onChanged: (value) {
        if (value) {
          setState(() {
            antiListMac.add(mac);
            antiList.add(AntiStealItem(nickname:nickname, mac:mac));
          });
        } else {
          setState(() {
            antiListMac.remove(mac);
            antiList.remove(AntiStealItem(nickname:nickname, mac:mac));
          });
        }
      },
    );
  }

  void addAntiSteal() {
    var addAntiStealBloc = AddAntiStealBloc();
    addAntiStealBloc.addAntiSteal(widget.type, antiList);
    addAntiStealBloc.subject.listen((onData) {
      if (onData.return_parameter.status == "0") {
        _globalKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text('设置成功'),
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        logger.d("add antisteal success");
      }
    });
  }
}
