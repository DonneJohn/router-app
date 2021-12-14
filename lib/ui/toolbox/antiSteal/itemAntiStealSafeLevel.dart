import 'package:flutter/material.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';

class ItemAntiStealLevel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemWifiGuard();
}

class _ItemWifiGuard extends State<ItemAntiStealLevel> {
  int safetyLevel = 0;
  List<String> title = [
    Str.wifiGuardLevelHigh,
    Str.wifiGuardLevelMedium,
    Str.wifiGuardLevelLow
  ];
  List<String> subtitle = [
    Str.wifiGuardLevelHighSubtitle,
    Str.wifiGuardLevelMediumSubtitle,
    Str.wifiGuardLevelLowSubtitle
  ];

  @override
  void initState() {
    // TODO: init safetyLevel from internet
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '防蹭网安全等级',
          style: ITextStyles.appBarTitleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '完成',
              style: ITextStyles.appBarActionTextStyle,
            ),
          )
        ],
      ),
      body: Container(
          child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _getCheckboxListTile(title[index], subtitle[index], index);
        },
        separatorBuilder: (context, index) => MyDivider(),
      )),
    );
  }

  Widget _getCheckboxListTile(String title, String subtitle, int index) {
    return Container(
      height: 60,
      child: CheckboxListTile(
        dense: true,
        value: safetyLevel == index,
        title: Text(
          title,
          style: ITextStyles.pageTextStyle,
        ),
        subtitle: Text(
          subtitle,
          style: ITextStyles.pageSubTextStyle,
        ),
        onChanged: (check) {
          setState(() {
            safetyLevel = index;
          });
        },
      ),
    );
  }
}
