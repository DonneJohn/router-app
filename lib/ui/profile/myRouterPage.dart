import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/api.dart';
import 'package:hg_router/api/queryBindListApi.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/models/loginAndLogout/getBindListResponseModel.dart';
import 'package:hg_router/models/profile/requestUnbindDeviceModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import '../../main.dart';

///
///Created by slkk on 2019/10/30/0030 13:58
///
class MyRouterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyRouterPageState();
}

class _MyRouterPageState extends State<MyRouterPage> {
  List<BindDevice> routerList;

  List<BindDevice> unbindRouterList = [];
  bool isCheck = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getBindDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        appBar: MyAppBar(
          preferredSize: Size(double.infinity, 100),
          title: "解绑路由器",
          action: <Widget>[
            FlatButton(
              onPressed: () {
                _unbind(context);
              },
              child: Text(
                '解绑',
                style: ITextStyles.pageTextStyleWhite,
              ),
            )
          ],
        ),
        body: routerList == null
            ? Center(child: CircularProgressIndicator())
            : (routerList.length == 0
                ? Center(
                    child: Text("请先绑定路由器"),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            getItem(context, index),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: routerList.length),
                  )));
  }

  Widget getItem(BuildContext context, int index) {
    return CheckboxListTile(
      onChanged: (value) {
        if (value) {
          setState(() {
            unbindRouterList.add(routerList[index]);
          });
        } else {
          setState(() {
            unbindRouterList.remove(routerList[index]);
          });
        }
      },
      title: Text(routerList.length == 0
          ? "ddd"
          : routerList[index].nickname ?? routerList[index].model),
      value: unbindRouterList.contains(routerList[index]),
    );
  }

  void getBindDeviceList() async {
    GetBindListResponseModel bindList = await QueryBindListApi().getBindList();
    if (bindList.code == 200) {
      if (bindList.data.length == 0) {
        setState(() {
          routerList = List<BindDevice>();
        });
        return;
      }

      setState(() {
        routerList = bindList.data;
        logger.i(routerList[0]);
      });
    }
  }

  void updateLocalBindDeviceList() async {
    GetBindListResponseModel bindList = await QueryBindListApi().getBindList();
    if (bindList.code == 200) {
      SpUtil.putObjectList(Constant.bindDeviceList, bindList.data);
    }
  }

  void _unbind(BuildContext context) {
    RequestUnbindDeviceModel modle;
    List<Device> unbindList = new List<Device>();
    for (int i = 0; i < unbindRouterList.length; i++) {
      Device device = Device(unbindRouterList[i].mac);
      unbindList.add(device);
    }
    modle = RequestUnbindDeviceModel(unbindList);

    Future<MyDioResponse> response = RestfulUtils.getInstance()
        .put(true,Api.baseUrl + Api.unBindRouterUrl, data: modle);
    response.then((onValue) {
      var data = onValue.response.data['code'];
      logger.i('unbind result code $data');
      String result;
      if (data == 200) {
        result = S.of(context).unbindSuccess;
        SpUtil.putString(Constant.routerUUID, "");

        ///解绑成功更新本地绑定设备列表
        updateLocalBindDeviceList();
      } else {
        result = S.of(context).unbindFail;
      }
      _globalKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(result),
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    });
  }
}
