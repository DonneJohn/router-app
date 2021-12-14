import 'package:flutter/material.dart';
import 'package:hg_router/res/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///
///Created by slkk on 2019/8/30/0030 15:14
///

class ItemIntelligentSpeedLimit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemIntelligentSpeedLimitState();
}

class _ItemIntelligentSpeedLimitState extends State<ItemIntelligentSpeedLimit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Str.intelligentSpeedLimit),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 200,
            child: Column(
              children: <Widget>[
                Icon(
                  MdiIcons.speedometerMedium,
                  size: 60,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => _getItem(index),
                separatorBuilder: (context, index) => Divider(),
                itemCount: 3),
          )
        ],
      ),
    );
  }

  _getItem(int index) {}
}
