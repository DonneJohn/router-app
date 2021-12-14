import 'package:flutter/material.dart';
import 'package:hg_router/ui/toolbox/routerSetting/itemTimePicker.dart';

class ItemNotifySettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemNotifySettings();
}

class _ItemNotifySettings extends State<ItemNotifySettings> {
  bool _isNotify = true;
  bool _isDisturbing = true;
  List<String> itemTitle = [
    '新通知提醒',
    '免打扰模式',
    '免打扰时间设置',
  ];

  @override
  void initState() {
    //TODO init _isNotify _isDisturbing
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('通知设置'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => _getListItem(index),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3),
    );
  }

  Widget _getListItem(int index) {
    return ListTile(
      onTap: () {
        if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ItemTimePicker()));
        }
      },
      title: Text(itemTitle[index]),
      trailing: index == 2
          ? Icon(Icons.chevron_right)
          : Switch(
              value: index == 0 ? _isNotify : _isDisturbing,
              onChanged: (value) {
                if (index == 0) {
                  setState(() {
                    _isNotify = value;
                  });
                } else {
                  setState(() {
                    _isDisturbing = value;
                  });
                }
              },
            ),
    );
  }
}
