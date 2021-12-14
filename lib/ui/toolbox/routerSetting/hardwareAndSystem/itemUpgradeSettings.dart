import 'package:flutter/material.dart';

class ItemUpgradeSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemUPgradeSettingsState();
}

class _ItemUPgradeSettingsState extends State<ItemUpgradeSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('升级设置'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('固件自动升级'),
                ),
                ListTile(
                  title: Text('时间设置'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
