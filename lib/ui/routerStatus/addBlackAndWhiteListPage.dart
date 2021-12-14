import 'dart:math';

///
///Created by slkk on 2019/9/23/0023 11:42
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/addInternetAccessBloc.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/deleteInternetAccessBloc.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/getInternetAccessBloc.dart';
import 'package:hg_router/bloc/routerStatus/hostDetailBloc/updateInternetAccessBloc.dart';

import 'package:hg_router/main.dart';
import 'package:hg_router/models/routerStatus/hostDetail/modifyInternetAccessRequestModel.dart'
    as prefix0;
import 'package:hg_router/models/routerStatus/hostDetail/getInternetAccessResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/utils/utils.dart';

class AddBlackAndWhiteListPage extends StatefulWidget {
  final String actionBarTitle;
  final String mac;

  const AddBlackAndWhiteListPage({Key key, this.actionBarTitle, this.mac})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddBlackAndWhiteListPageState();
}

class _AddBlackAndWhiteListPageState extends State<AddBlackAndWhiteListPage> {
  GetInternetAccessBloc bloc;

  @override
  void initState() {
    bloc = GetInternetAccessBloc();
    bloc.getInternetAccess(widget.mac);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.actionBarTitle,
          style: ITextStyles.appBarTitleStyle,
        ),
      ),
      body: StreamBuilder(
        stream: bloc.subject.stream,
        builder:
            (context, AsyncSnapshot<GetInternetAccessResponseModel> snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data.return_parameter.result;
            logger.i("snapshot: length" + result.whitelist.length.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          _getItem(context, snapshot, index),
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount: _getItemCount(result)),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _addInternetAccess(context);
                          },
                        ),
                        decoration: ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.grey,
                                width: 1),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      Text(
                        '添加',
                        style: ITextStyles.pageTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Text('你可以通过服务地址来限制哪些服务的流量会经过VPN');
          }
        },
      ),
    );
  }

  _addInternetAccess(BuildContext contexts) {
    var errorText;
    var textEditingController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(5),
              height: 160,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        labelText: '添加地址',
                        labelStyle: ITextStyles.grey_font13,
                        errorText: errorText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('取消'),
                      ),
                      OutlineButton(
                        onPressed: () {
                          if (textEditingController.text.isEmpty) {
                            state(() {
                              errorText = '网址不能为空';
                            });
                          }
                          var addInternetAccessBloc = AddInternetAccessBloc();
                          if (widget.actionBarTitle == '网址白名单') {
                            addInternetAccessBloc
                                .addInternetAccess(widget.mac, whitelist: [
                              prefix0.BlockList(
                                  host: textEditingController.text.toString())
                            ]);
                          }
                          var showCircularSnackBar =
                              Util.showCircularSnackBar(contexts, '正在设置');
                          var outAddInternetAccess =
                              addInternetAccessBloc.outAddInternetAccess;
                          outAddInternetAccess.listen((onData) {
                            if (onData.return_parameter.status == "0") {
                              Future.delayed(Duration(seconds: 1), () {
                                showCircularSnackBar.close();
                              });
                              bloc.getInternetAccess(widget.mac);
                            }
                          });
                          Navigator.pop(
                              context, textEditingController.text.toString());
                        },
                        child: Text('确定'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  int _getItemCount(Result result) {
    logger.i('_getItemCount' + result.toJson().toString());
    if (widget.actionBarTitle == "网址白名单") {
      logger.i('whitelist');
      if (result.whitelist != null) {
        return result.whitelist.length;
      }
    } else {
      if (result.blacklist != null) {
        return result.blacklist.length;
      }
    }
    return 0;
  }

  Widget _getItem(BuildContext context,
      AsyncSnapshot<GetInternetAccessResponseModel> snapshot, int index) {
    String host;
    return MyListTile(
      onTap: () {
        if (widget.actionBarTitle == "网址白名单") {
          host = snapshot.data.return_parameter.result.whitelist[index].host;
        } else {
          host = snapshot.data.return_parameter.result.blacklist[index].host;
        }

        _updateInternetAccess(context, host);
      },
      onLongPress: () {
        _deleteInternetAccess(index);
      },
      title: Text(widget.actionBarTitle == "网址白名单"
          ? snapshot.data.return_parameter.result.whitelist[index].host
          : snapshot.data.return_parameter.result.blacklist[index].host),
    );
  }

  _deleteInternetAccess(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          height: 130,
          child: Column(
            children: <Widget>[
              Text(
                '删除地址？',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('取消'),
                  ),
                  OutlineButton(
                    onPressed: () {
                      var deleteInternetAccessBloc = DeleteInternetAccessBloc();
                      deleteInternetAccessBloc
                          .deleteInternetAccess(index.toString());
                      var outDeleteInternetAccess =
                          deleteInternetAccessBloc.outDeleteInternetAccess;
                      outDeleteInternetAccess.listen((onData) {
                        if (onData.return_parameter.status == '0') {
                          bloc.getInternetAccess(widget.mac);
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Text('确定'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _updateInternetAccess(BuildContext contexts, String host) {
    var errorText;
    var textEditingController = TextEditingController();
    textEditingController.text = host;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(5),
              height: 160,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        labelText: '修改地址', errorText: errorText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('取消'),
                      ),
                      OutlineButton(
                        onPressed: () {
                          if (textEditingController.text.isEmpty) {
                            state(() {
                              errorText = '网址不能为空';
                            });
                          }
                          var updateInternetAccessBloc =
                              UpdateInternetAccessBloc();
                          if (widget.actionBarTitle == '网址白名单') {
                            updateInternetAccessBloc
                                .updateInternetAccess(widget.mac, whitelist: [
                              prefix0.BlockList(
                                  host: textEditingController.text.toString())
                            ]);
                          }
                          var showCircularSnackBar =
                              Util.showCircularSnackBar(contexts, '正在设置');
                          var outUpdateInternetAccess =
                              updateInternetAccessBloc.outUpdateInternetAccess;
                          outUpdateInternetAccess.listen((onData) {
                            if (onData.return_parameter.status == "0") {
                              Future.delayed(Duration(seconds: 1), () {
                                showCircularSnackBar.close();
                              });
                              bloc.getInternetAccess(widget.mac);
                            }
                          });
                          Navigator.pop(
                              context, textEditingController.text.toString());
                        },
                        child: Text('确定'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
