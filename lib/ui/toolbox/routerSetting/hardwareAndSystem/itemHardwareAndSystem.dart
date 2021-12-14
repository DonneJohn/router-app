import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hg_router/bloc/hardwareAndSystem/getLedBloc.dart';
import 'package:hg_router/bloc/hardwareAndSystem/setLedBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'itemResetAdminPwd.dart';
import '../../advancedSettings/restoreDefaultPage.dart';
import 'itemTimeZoneSettings.dart';

class ItemHardwareAndSystem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemHardwareAndSystemState();
}

class _ItemHardwareAndSystemState extends State<ItemHardwareAndSystem> {
  bool lightIsOpen;

  GetLedBloc getLedBloc;
  List<String> itemListTileTitle = [
    '面板指示灯',
//    '升级设置',
    '时区设置',
    '重置管理密码',
    '恢复出厂设置',
  ];

  @override
  void initState() {
    // TODO: implement initState
    getLedBloc = GetLedBloc();
    getLedBloc.getLed();
    getLedBloc.outGetLed.listen((onData) {
      if (onData.return_parameter.result.ledStatus == 'on') {
        setState(() {
          lightIsOpen = true;
        });
      } else {
        setState(() {
          lightIsOpen = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        ///硬件与系统
        title: Text(
          S.of(context).HardwareSystem,
          style: ITextStyles.appBarTitleStyle,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => _getListTile(index),
                separatorBuilder: (context, index) => MyDivider(),
                itemCount: itemListTileTitle.length),
          ),
        ],
      ),
    );
  }

  Widget _getListTile(int index) {
    if (index == 0) {
      ///面板指示灯
      return MyListTile(
        title: Text(
          itemListTileTitle[index],
          style: ITextStyles.pageTextStyle,
        ),
        trailing: Switch(
          value: lightIsOpen ?? false,
          onChanged: (value) {
            var setLedBloc = SetLedBloc();
            setLedBloc.setLed(value ? 'on' : 'off');
            setLedBloc.outSetLed.listen((onData) {
              if (onData.return_parameter.status == '0') {
                setState(() {
                  lightIsOpen = value;
                });
              }
            });
          },
        ),
      );
    }
    return MyListTile(
      onTap: () {
        _itemNavigator(index);
      },
      title: Text(
        itemListTileTitle[index],
        style: ITextStyles.pageTextStyle,
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }

  void _itemNavigator(int index) {
    if (index == 4) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    child: Text(
                      '恢复出厂设置',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {
                      //TODO 恢复出厂
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 250,
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消'),
                    ),
                  ),
                ],
              ),
            );
          });
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      switch (index) {
//        case 1:
//          return ItemUpgradeSettings();
        case 1:
          return ItemTimeZoneSettings();
        case 2:
          return ItemResetAdminPwd();
        case 3:
          return RestoreDefaultPage();
        default:
          return null;
      }
    }));
  }
}
