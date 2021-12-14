import 'package:flutter/material.dart';

class ItemTimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemTimePickerState();
}

class _ItemTimePickerState extends State<ItemTimePicker> {
  TimeOfDay beginTime;

  TimeOfDay endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('免打扰时间设置'),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => _getItem(index),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 2),
    );
  }

  Widget _getItem(int index) {
    return ListTile(
      onTap: () {
        if (index == 0) {
          beginTime = getTime(index);
        } else {
          endTime = getTime(index);
        }
      },
      title: Text(['开始时间', '结束时间'][index]),
      trailing: Text(index == 0
          ? (beginTime == null ? '12:00' : beginTime.format(context))
          : (endTime == null ? '12:00' : endTime.format(context))),
    );
  }

  getTime(int index) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (index == 0) {
        setState(() {
          beginTime = value;
        });
      } else {
        setState(() {
          endTime = value;
        });
      }
    });
  }
}
