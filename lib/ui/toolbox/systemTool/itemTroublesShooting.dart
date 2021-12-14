import 'package:flutter/material.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/res/strings.dart';

///
/// Created by slkk on 2019/8/30/0030 11:28
///

class ItemTroubleShooting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemTroubleShootingState();
}

class _ItemTroubleShootingState extends State<ItemTroubleShooting> {
  List<String> itemTitle = [
    Str.downloadSpeedSlow,
    Str.disconnectInternet,
    Str.catnotlogin,
    Str.netSpeedSlow,
    Str.wifiStrength,
    Str.routerSetFailure,
    Str.lightProblem,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Str.troubleshooting),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisCount: 3,
        children: _getItem(7),
      ),
    );
  }

  List<Widget> _getItem(int index) {
    List<Widget> items = new List();
    for (int i = 0; i < index; i++) {
      items.add(InkWell(
        splashColor: Colors.blue,
        onTap: () {
          _itemTap(i);
        },
        child: Container(
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(color: Colors.grey.withAlpha(50)),
          alignment: Alignment.center,
          width: 50,
          height: 50,
          child: Text(itemTitle[i]),
        ),
      ));
    }
    return items;
  }

  _itemTap(int index) {
    print('tap: $index');
  }
}
