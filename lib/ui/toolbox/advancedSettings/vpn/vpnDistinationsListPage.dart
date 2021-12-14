import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/addVpnPolicyDestinationsBloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/deleteVpnPolicyDestinationsBloc.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/vpn/getVpnPolicyDestinationsBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/models/vpn/getVpnPoliciesResponseModel.dart';
import 'package:hg_router/models/vpn/addVpnPolicyRequestModel.dart' as resModel;
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';

///
///Created by slkk on 2019/9/12/0012 13:22
///
class VpnDestinationsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VpnDestinationsListPageState();
}

class _VpnDestinationsListPageState extends State<VpnDestinationsListPage> {
  GetVpnPolicyDestinationsBloc bloc;

  @override
  void initState() {
    bloc = GetVpnPolicyDestinationsBloc();
    bloc.getVpnPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).addressList,
          style: ITextStyles.appBarTitleStyle,
        ),
      ),
      body: StreamBuilder(
        stream: bloc.subject.stream,
        builder:
            (context, AsyncSnapshot<GetVpnPoliciesResponseModel> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          _getItem(snapshot, index),
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount: 3),
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
                            _addVpnDestination();
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
                        S.of(context).add,
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

  _addVpnDestination() {
    var textEditingController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(5),
            height: 130,
            child: Column(
              children: <Widget>[
                ///添加地址
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      labelText: S.of(context).addAddress,
                      labelStyle: ITextStyles.pageTextStyleGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ///取消
                    OutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).cancel,
                          style: ITextStyles.pageTextStyle),
                    ),

                    ///确定
                    OutlineButton(
                      onPressed: () {
                        var addVpnPolicyDestinationsBloc =
                            AddVpnPolicyDestinationsBloc();
                        addVpnPolicyDestinationsBloc.addVpnPolicy([
                          resModel.Destinations(
                              name: textEditingController.text.toString())
                        ]);
                        var outAddVpnPolicy =
                            addVpnPolicyDestinationsBloc.outAddVpnPolicy;
                        outAddVpnPolicy.listen((onData) {
                          if (onData.return_parameter.status == "0") {
                            bloc.getVpnPolicy();
                          }
                        });
                        Navigator.pop(
                            context, textEditingController.text.toString());
                      },
                      child: Text(S.of(context).ok,
                          style: ITextStyles.pageTextStyle),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget _getItem(
      AsyncSnapshot<GetVpnPoliciesResponseModel> snapshot, int index) {
    return MyListTile(
      onLongPress: () {
        _deleteVpnDestination(index);
      },
      title:
          Text(snapshot.data.return_parameter.result.destinations[index].name),
    );
  }

  _deleteVpnDestination(int index) {
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
                        var deleteVpnPolicyDestinationsBloc =
                            DeleteVpnPolicyDestinationsBloc();
                        deleteVpnPolicyDestinationsBloc
                            .deleteVpnPolicy(index.toString());
                        var outDeleteVpnPolicy =
                            deleteVpnPolicyDestinationsBloc.outDeleteVpnPolicy;
                        outDeleteVpnPolicy.listen((onData) {
                          if (onData.return_parameter.status == '0') {
                            bloc.getVpnPolicy();
                          }
                          Navigator.pop(context);
                        });
                      },
                      child: Text('确定'),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
