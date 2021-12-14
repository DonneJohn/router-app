import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/deviceNicknameApi.dart';
import 'package:hg_router/api/userNicknameApi.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/SpUtil.dart';

///
///Created by slkk on 2019/10/30/0030 09:33
///
class NickNameSetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NickNameSetPage();
}

class _NickNameSetPage extends State<NickNameSetPage> {
  TextEditingController userNicknamecontroller = TextEditingController();
  TextEditingController deviceNickNameController = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    UserNicknameApi().getUserNickname().then((userNickname) {
      if (userNickname.code == 200) {
        userNicknamecontroller.text = userNickname.data.nickname;
      }
    });

    DeviceNicknameApi()
        .getDeviceNickname(SpUtil.getString(Constant.routerMac))
        .then((deviceNickName) {
      if (deviceNickName.code == 200) {
        deviceNickNameController.text = deviceNickName.data.nickname;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: MyAppBar(
          preferredSize: Size(double.infinity, 100),
          title: "昵称设置",
          action: <Widget>[
            FlatButton(
              onPressed: () {
                if (userNicknamecontroller.text.isNotEmpty) {
                  updateUserNickname(userNicknamecontroller.text.toString());
                }
                if (deviceNickNameController.text.isNotEmpty) {
                  updateDeviceNickname(
                      deviceNickNameController.text.toString());
                }
              },
              child: Text(
                '保存',
                style: ITextStyles.white_font16,
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "用户昵称: ",
                    style: ITextStyles.pageTextStyle,
                  ),
                  Gaps.hGap25,
                  Expanded(
                    child: TextField(
                      controller: userNicknamecontroller,
                      decoration: InputDecoration(),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "路由器名称: ",
                    style: ITextStyles.pageTextStyle,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: TextField(
                      controller: deviceNickNameController,
                      decoration: InputDecoration(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void updateUserNickname(String nickname) {
    UserNicknameApi().updateUserNickname(nickname).then((onValue) {
      if (onValue.code == 200) {
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text('设置成功'),
        ));
      } else {
        ///TODO 具体错误提示
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text("设置失败"),
        ));
      }
    });
  }

  void updateDeviceNickname(String nickname) {
    DeviceNicknameApi().updateDeviceNickname(nickname).then((onValue) {
      if (onValue.code == 200) {
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text('设置成功'),
        ));
      } else {
        ///TODO 具体错误提示
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text("设置失败"),
        ));
      }
    });
  }
}
