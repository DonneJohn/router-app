import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/advancedSettings/setTimeBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/hardwareAndSystem/TimeZoneMap.dart';

///
///Created by slkk on 2019/9/18/0018 11:14
///
class SelectTimezonePage extends StatefulWidget {
  final String timezone;

  const SelectTimezonePage({Key key, this.timezone}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectTimezonePage();
}

class _SelectTimezonePage extends State<SelectTimezonePage> {
  ScrollController controller;

  @override
  void initState() {
    int indexOf = TimezoneMap.p.keys.toList().indexOf(widget.timezone);
    controller = ScrollController(initialScrollOffset: 52.00 * indexOf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('选择时区'),
      ),
      body: ListView.separated(
          controller: controller,
          itemBuilder: (context, index) {
            return _getItem(context, index);
          },
          separatorBuilder: (context, index) => Divider(
                height: 2,
              ),
          itemCount: 82),
    );
  }

  Widget _getItem(BuildContext context, int index) {
    String key = TimezoneMap.p.keys.toList()[index];
    String value = TimezoneMap.p[key];

    return Container(
      height: 50,
      child: ListTile(
        onTap: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text('正在设置')
              ],
            ),
          ));
          var setTimeBloc = SetTimeBloc();
          setTimeBloc.setTime(key);
          logger.i('keky'+key);
          setTimeBloc.outSetTime.listen((onData) {
            if (onData.return_parameter.status == '0') {
              Navigator.pop(context, key);
            }
          });
        },
        leading: Icon(
          Icons.chevron_right,
          color: key == widget.timezone ? Colors.blue : Colors.transparent,
        ),
        title: Text(
          value,
          style: TextStyle(
              color: key == widget.timezone ? Colors.blue : Colors.black),
        ),
      ),
    );
  }
}
