import 'package:flutter/material.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/getHostInfoBloc.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/setHostInfoBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/models/routerStatus/hostDetail/getHostInfoModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/utils/utils.dart';

class HostInfoPage extends StatefulWidget {
  final String mac;

  const HostInfoPage({Key key, @required this.mac}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostInfoPageState();
}

class _HostInfoPageState extends State<HostInfoPage> {
  GetHostInfoBloc bloc;
  String type;
  String vendor;
  String model;
  String linkType;
  String deviceMac;
  String deviceIp;

  @override
  void initState() {
    bloc = GetHostInfoBloc();
    bloc.getDeviceInfo(widget.mac);
    super.initState();
  }

  _handleDeviceInfo(AsyncSnapshot<HostInfoModel> snapshot) {
    var result = snapshot.data.return_parameter.result;
    type = result.type;
    vendor = result.vendor;
    model = result.model;
    linkType = result.linkType;
    deviceIp = result.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '设备信息',
          style: ITextStyles.appBarTitleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder(
        stream: bloc.subject.stream,
        builder: (context, AsyncSnapshot<HostInfoModel> snapshot) {
          if (snapshot.hasData) {
            _handleDeviceInfo(snapshot);
          }
          return Container(
            child: ListView(
              children: <Widget>[
                ///类型
                MyListTile(
                  height: 50,
                  title: Text(S.of(context).type,
                      style: ITextStyles.pageTextStyle),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          type ?? S.of(context).phone,
                          style: ITextStyles.pageTextStyleGrey,
                        ),
                        IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(3),
                          icon: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                          onPressed: () {
                            _updateHostInfo(context, widget.mac, type,
                                type: "修改类型");
                          },
                        )
                      ],
                    ),
                  ),
                ),
                MyDivider(indent: 16, endIndent: 16),

                ///品牌
                MyListTile(
                  height: 50,
                  title: Text(S.of(context).vendor,
                      style: ITextStyles.pageTextStyle),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(vendor ?? 'iphone',
                            style: ITextStyles.pageTextStyleGrey),
                        IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(3),
                          icon: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                          onPressed: () {
                            _updateHostInfo(context, widget.mac, vendor,
                                vendor: "修改品牌");
                          },
                        )
                      ],
                    ),
                  ),
                ),
                MyDivider(indent: 16, endIndent: 16),

                ///型号
                MyListTile(
                  height: 50,
                  title: Text(
                    S.of(context).model,
                    style: ITextStyles.pageTextStyle,
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(model ?? '其他',
                            style: ITextStyles.pageTextStyleGrey),
                        IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(3),
                          icon: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                          onPressed: () {
                            _updateHostInfo(context, widget.mac, model,
                                model: "修改型号");
                          },
                        )
                      ],
                    ),
                  ),
                ),
                MyDivider(indent: 16, endIndent: 16),

                ///连接类型
                MyListTile(
                  height: 50,
                  title: Text(S.of(context).linkType,
                      style: ITextStyles.pageTextStyle),
                  trailing: Text(linkType ?? 'Wi-Fi 2.4G',
                      style: ITextStyles.pageTextStyleGrey),
                ),
                MyDivider(indent: 16, endIndent: 16),

                ///mac地址
                MyListTile(
                  height: 50,
                  title:
                      Text(S.of(context).mac, style: ITextStyles.pageTextStyle),
                  trailing: Text(deviceMac ?? '00:11:22:33:44:55',
                      style: ITextStyles.pageTextStyleGrey),
                ),
                MyDivider(indent: 16, endIndent: 16),

                ///ip地址
                MyListTile(
                  height: 50,
                  title:
                      Text(S.of(context).ip, style: ITextStyles.pageTextStyle),
                  trailing: Text(deviceIp ?? '192.168.1.6',
                      style: ITextStyles.pageTextStyleGrey),
                ),
                MyDivider(indent: 16, endIndent: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  _updateHostInfo(BuildContext contexts, String host, String text,
      {String nickname, String type, String vendor, String model}) {
    List<String> titleLabel = ["修改类型", "修改品牌", "修改型号"];
    var labelText;
    if (type != null) {
      labelText = titleLabel[0];
    }
    if (vendor != null) {
      labelText = titleLabel[1];
    }
    if (model != null) {
      labelText = titleLabel[2];
    }

    var errorText;
    var textEditingController = TextEditingController();
    textEditingController.text = text;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            ///外层嵌套一层解决bottomSheet被键盘遮挡的问题
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    10, 16, 16, MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: <Widget>[
                    Text(
                      labelText,
                      style: ITextStyles.blackBoldFont17,
                    ),
                    Container(
                      height: 80,
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.grey[30]),
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    textEditingController.clear();
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              labelStyle: ITextStyles.pageTextStyleGrey,
                              errorText: errorText),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '取消',
                            style: ITextStyles.pageTextStyle,
                          ),
                        ),
                        OutlineButton(
                          onPressed: () {
                            if (textEditingController.text.isEmpty) {
                              state(() {
                                errorText = '不能为空';
                              });
                              return;
                            }
                            var setHostInfoBloc = SetHostInfoBloc();
                            setHostInfoBloc.setHostInfo(widget.mac,
                                nickname: nickname,
                                type: type,
                                vendor: vendor,
                                model: model);
                            var showCircularSnackBar =
                                Util.showCircularSnackBar(contexts, '正在设置');
                            var outSetHostInfo = setHostInfoBloc.outSetHostInfo;
                            outSetHostInfo.listen((onData) {
                              if (onData.return_parameter.status == "0") {
                                Future.delayed(Duration(seconds: 1), () {
                                  showCircularSnackBar.close();
                                });
//                              bloc.getInternetAccess(widget.mac);
                              }
                            });
                            Navigator.pop(
                                context, textEditingController.text.toString());
                          },
                          child: Text(
                            '确定',
                            style: ITextStyles.pageTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
