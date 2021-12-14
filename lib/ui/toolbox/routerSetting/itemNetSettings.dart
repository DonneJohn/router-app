import 'package:flutter/material.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/toolbox/advancedSettings/vpn/vpnSettingsPage.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/toolbox/wanConnectMode/wanConnectSetPage.dart';

class ItemNetSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemNetSettings();
}

class _ItemNetSettings extends State<ItemNetSettings> {
  @override
  Widget build(BuildContext context) {
    List<String> _itemTitle = [
      S.of(context).connectMode,
      S.of(context).vpn,
      S.of(context).internetOptimize
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        ///网络设置
        title: Text(
          S.of(context).InternetSetting,
          style: ITextStyles.appBarTitleStyle,
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return _getItem(_itemTitle[index], index);
          },
          separatorBuilder: (context, index) {
            return MyDivider();
          },
          itemCount: 3),
    );
  }

  Widget _getItem(String title, int index) {
    return MyListTile(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: RouteSettings(name: WanConnectSettingPage.name),
                builder: (context) {
                  return WanConnectSettingPage();
                },
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VpnSettingsPage();
                },
              ),
            );
        }
      },
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
