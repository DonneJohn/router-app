import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/antiSteal/deleteAntiStealBloc.dart';

import 'package:hg_router/bloc/toolbox/antiSteal/listAntiStealBloc.dart';
import 'package:hg_router/models/toolbox/antiSteal/addAntiStealRequest.dart';
import 'package:hg_router/models/toolbox/antiSteal/listAntiStealResponse.dart'
    as responseModel;
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/antiSteal/addAntiStealPage.dart';

import '../../../main.dart';

class AntiStealListPage extends StatefulWidget {
  final String type;

  const AntiStealListPage({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemWifiGuardBlackList();
}

class _ItemWifiGuardBlackList extends State<AntiStealListPage> {
  ListAntiStealBloc listAntiStealBloc;
  List<responseModel.AntiStealItem> itemList;
  bool isEditing = false;
  List<int> deleteIndex;
  List<AntiStealItem> deleteList;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    deleteIndex = List<int>();
    deleteList = List<AntiStealItem>();
    listAntiStealBloc = ListAntiStealBloc();
    listAntiStealBloc.getAntiStealList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: MyAppBar(
        title: widget.type == "blacklist" ? "黑名单" : "白名单",
        preferredSize: Size(double.infinity, 100),
        action: <Widget>[
          Offstage(
            offstage: !isEditing,
            child: FlatButton(
              onPressed: () {
                deleteItem();
              },
              child: Text(
                '删除',
                style: ITextStyles.pageTextStyleWhite,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: listAntiStealBloc.subject.stream,
        builder: (context,
            AsyncSnapshot<responseModel.ListAntiStealResponse> snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data.return_parameter.result;
            if (widget.type == "blacklist") {
              itemList = result.blacklists;
            } else {
              itemList = result.whitelists;
            }
            return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: itemList.length,
                          itemBuilder: (context, index) =>
                              getItem(context, index, itemList)),
                    ),
                    MyDivider(
                      color: Colors.grey,
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.add_circle,
                                      color: Colors.grey),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddAntiStealPage(
                                          type: widget.type,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  "添加",
                                  style: ITextStyles.grey_font13,
                                )
                              ],
                            ),
                            Gaps.hGap50,
                            Column(
                              children: <Widget>[
                                IconButton(
                                  color: isEditing ? Colors.green : Colors.grey,
                                  icon: Icon(
                                    Icons.edit,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                  },
                                ),
                                Text(
                                  "编辑",
                                  style: !isEditing
                                      ? ITextStyles.grey_font13
                                      : TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget getItem(BuildContext context, int index,
      List<responseModel.AntiStealItem> itemList) {
    var item = itemList[index];
    return ListTile(
        leading: Text(item.id ?? ""),
        title: Text(item.nickname ?? ""),
        subtitle: Text(item.mac ?? ""),
        trailing: Offstage(
            offstage: !isEditing,
            child: Checkbox(
              value: deleteIndex.contains(index),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    deleteIndex.add(index);
                    deleteList.add(AntiStealItem(id: item.id));
                  } else {
                    deleteIndex.remove(index);
                    deleteList.remove(AntiStealItem(id: item.id));
                  }
                });
                logger.d("delete list length:" + deleteList.length.toString());
                logger
                    .d("delete index length:" + deleteIndex.length.toString());
              },
            )));
  }

  void deleteItem() {
    if (deleteList.length != 0) {
      var deleteAntiStealBloc = DeleteAntiStealBloc();
      deleteAntiStealBloc.deleteAntiSteal(widget.type, deleteList);
      deleteAntiStealBloc.subject.listen((onData) {
        if (onData.return_parameter.status == "0") {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text('保存成功'),
          ));
        }
      });
    } else {
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text("请先选择要编辑的设备"),
      ));
    }
  }
}
