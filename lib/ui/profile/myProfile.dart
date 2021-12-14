import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/api.dart';
import 'package:hg_router/api/avatorApi.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/profile/imageEditorPage.dart';
import 'package:hg_router/ui/profile/myRouterPage.dart';
import 'package:hg_router/ui/profile/nickNameSetPage.dart';
import 'package:hg_router/ui/profile/itemUserFeedback.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'package:path_provider/path_provider.dart';
import '../../main.dart';
import '../custom/widget.dart';
import 'aboutUsPage.dart';

///
///Created by slkk on 2019/10/21/0021 15:36
///
class MyProfilePage extends StatefulWidget {
  static final name = 'MyProfilePage';

  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  File avatar;
  String avatarLocalUri;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logger.d("myprofile init state");
    _initAvatar();
  }

  _initAvatar() {
    AvatorApi().getAvator().then((onValueUrl) {
      if (onValueUrl.code == 200) {
        String avatarUrlTrailing = onValueUrl.data.avator;
        if (avatarUrlTrailing == null) {
          return;
        }
        String avatarFileName =
            avatarUrlTrailing.substring(avatarUrlTrailing.lastIndexOf("/") + 1);
        logger.d(avatarUrlTrailing);
        getTemporaryDirectory().then((onValue) {
          avatarLocalUri = onValue.path + "/" + avatarFileName;
          logger.d("local vator file: " + avatarLocalUri);
          File file = File(avatarLocalUri);
          file.exists().then((onValue) {
            logger.d("local avator file " + onValue.toString());
            if (!onValue) {
              String avatarUrl = Api.baseUrl + avatarUrlTrailing;
              RestfulUtils.getInstance()
                  .download(false, avatarUrl, saveUrl: avatarLocalUri)
                  .then((onValue) {
                if (onValue.statusCode == 200) {
                  File file = new File(avatarLocalUri);
                  if (!mounted) return;
                  setState(() {
                    avatar = file;
                  });
                }
              });
            } else {
              if (!mounted) return;
              setState(() {
                avatar = file;
              });
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d("myprofile build");
    if (avatarLocalUri != null) {
      avatar = File(avatarLocalUri);
    }
    return Scaffold(
        key: _globalKey,
        appBar: PreferredSize(
          child: Container(
            child: Column(
              children: <Widget>[
                Gaps.vGap20,
                AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: ClipOval(
                            child: avatar == null
                                ? Image.asset(
                                    "assets/images/icon_photo_default.png",
                                    fit: BoxFit.scaleDown,
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.file(
                                    avatar,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.scaleDown,
                                  ),
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        ),
                        Container(
                          child: Text(
                            "个人设置",
                            style: ITextStyles.pageTitleStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                )
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colours.priBlue, Colours.priRed],
              ),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.height, 140),
        ),
        body: Card(
          elevation: 8,
          margin: EdgeInsets.all(10),
          child: ListView.separated(
              itemBuilder: (context, index) => getItem(context, index),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: 6),
        ));
  }

  final List<String> tittle = [
    "昵称设置",
    "头像设置",
    "用户反馈",
    "我的路由器",
    "退出登录",
    "关于我们",
  ];
  final List<IconData> iconsList = [
    Icons.person,
    Icons.lock,
    Icons.message,
    Icons.alarm_on,
    Icons.person,
    Icons.perm_device_information
  ];
  final List<Color> colorList = [
    Colors.teal,
    Colors.orange,
    Colors.blue,
    Colors.purpleAccent,
    Colors.red,
    Colors.purple,
  ];

  Widget getItem(BuildContext context, int index) {
    return ListTile(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NickNameSetPage();
            }));
            break;
          case 1:
            showDialog(
                context: context,
                builder: (context) {
                  ///设置头像照片
                  return SimpleDialog(
                    title: Text(
                      '设置头像图片',
                      style: ITextStyles.pageTextStyle,
                    ),
                    children: <Widget>[
                      ///相册
                      SimpleDialogOption(
                        onPressed: () {
                          popToCropPage(0);
                        },
                        child: Text(
                          '相册',
                          style: ITextStyles.pageTextStyle,
                        ),
                      ),

                      ///拍照
                      SimpleDialogOption(
                        onPressed: () {
                          popToCropPage(1);
                        },
                        child: Text(
                          '拍照',
                          style: ITextStyles.pageTextStyle,
                        ),
                      )
                    ],
                  );
                });
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ItemUserFeedback()));
            break;
          case 3:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyRouterPage()));

            break;
          case 4:
            showRebootBottomSheet(
                S.of(context).logoutTIitle, S.of(context).logout, () {
              _logout(context);
            });
            break;
          case 5:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AboutUsPage()));
            break;
        }
      },
      leading: Icon(
        iconsList[index],
        color: colorList[index],
        size: 30,
      ),
      title: Text(
        tittle[index],
        style: ITextStyles.black_font16,
      ),
      trailing: getTrailing(index),
    );
  }

  Widget getTrailing(int index) {
    if (index == 2 || index == 3 || index == 4) {
      return Icon(Icons.chevron_right);
    } else {
      return Icon(
        Icons.chevron_right,
        color: Colors.transparent,
      );
    }
  }

  void _logout(BuildContext context) {
    Future<MyDioResponse> response = RestfulUtils.getInstance().post(
        true, Api.baseUrl + Api.logoutUrl,
        data: {"email": SpUtil.getString(Constant.keyUserName)});
    response.then((onValue) {
      logger.i("onValue: " + onValue.toString());
      var data = onValue.statusCode;
      logger.i('logout result code $data');
      String result;
      if (data == 200) {
        result = S.of(context).logoutSuccess;
        SpUtil.putString(Constant.keyUserName, "");
        SpUtil.putString(Constant.keyAppToken, "");
        Navigator.of(context).pushNamedAndRemoveUntil(
            Constant.routeLogin, (route) => route == null);
      } else if (data == 401) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Constant.routeLogin, (route) => route == null);
      } else {
        result = S.of(context).logoutFail;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    });
  }

  void showRebootBottomSheet(
      String title, String actionTitle, VoidCallback onPressed) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    title,
                    style: ITextStyles.pageTextStyle,
                  ),
                ),
                FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    actionTitle,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  bgColor: Colors.blue,
                  text: S.of(context).cancel,
                  width: 200,
                ),
              ],
            ),
          );
        });
  }

  popToCropPage(int type) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditorPage(
          type: type,
        ),
      ),
    ).then((onValue) {
      logger.d("crop image after $onValue");
      Navigator.pop(context);
      setState(() {
        if (onValue != null) {
          avatarLocalUri = onValue;
        }
      });
    });
  }
}
