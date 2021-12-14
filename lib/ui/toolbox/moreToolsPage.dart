import 'package:flutter/material.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/res/styles.dart';

import 'package:hg_router/ui/toolbox/systemTool/itemIntelligentSpeedLimit.dart';
import 'package:hg_router/ui/toolbox/systemTool/itemSecurityCenter.dart';
import 'package:hg_router/ui/toolbox/systemTool/itemTroublesShooting.dart';
import 'package:hg_router/ui/toolbox/systemTool/testSpeedDepthPage.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/routerStatus/testSpeed.dart';

///更多工具页面
class MoreToolsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoreToolsPageState();
}

class _MoreToolsPageState extends State<MoreToolsPage> {
  List<String> listTitle = [
    Str.troubleshooting,
    Str.friendWifi,
    Str.depthSpeed,
    Str.securityCenter,
    Str.intelligentSpeedLimit,
    Str.healthMode,
    Str.rebootPlan,
    Str.customizeHosts,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Str.systemTools)),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 8,
              itemBuilder: (contex, index) {
                return _getItem(listTitle[index], 'Volunterr', index);
              }),
        ));
  }

  Widget _getItem(String title, String subtitle, int index) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped');
          _NavigateToPage(index);
        },
        child: Container(
          width: double.infinity,
          height: 100,
          child: MyListTile(
//            contentPadding: EdgeInsets.all(7),
            leading: Icon(
              Icons.language,
              size: 50,
              color: Colors.blue,
            ),
            title: Text(
              title,
              style: ITextStyles.pageTitleStyleBlack,
            ),
            subtitle: Text(subtitle),
          ),
        ),
      ),
    );
  }

  _NavigateToPage(int index) {
    Widget target;
    switch (index) {
      case 0:
        target = ItemTroubleShooting();
        break;
      case 1:
        break;
      case 2:
        showSpeedTestBottomSheet();
        return;
      case 3:
        target = ItemSecurityCenter();
        break;
      case 4:
        target = ItemIntelligentSpeedLimit();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => target));
  }

  showSpeedTestBottomSheet() {
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestSpeedPage()));
                  },
                  child: Text(
                    '一键测速',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestSpeedDepthPage()));
                  },
                  child: Text(
                    '深度测速',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          );
        });
  }
}
