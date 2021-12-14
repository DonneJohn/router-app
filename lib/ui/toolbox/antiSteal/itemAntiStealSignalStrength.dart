import 'package:flutter/material.dart';

class ItemAntiStealSignalStrength extends StatefulWidget {
  final String wifiSignalStrength;

  ItemAntiStealSignalStrength({Key key, @required this.wifiSignalStrength})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemAntiStealSignalStrengthState();
}

class _ItemAntiStealSignalStrengthState
    extends State<ItemAntiStealSignalStrength> {
  String _wifiSignalStrength;

  @override
  void initState() {
    // TODO: implement initState wifi signal strength
    _wifiSignalStrength = widget.wifiSignalStrength;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('信号强度'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, _wifiSignalStrength);
            },
            child: Text(
              '完成',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              value: _wifiSignalStrength == '标准',
              title: Text('标准'),
              onChanged: (value) {
                setState(() {
                  _wifiSignalStrength = '标准';
                });
              },
            ),
            Divider(),
            CheckboxListTile(
              onChanged: (value) {
                setState(() {
                  _wifiSignalStrength = '穿墙';
                });
              },
              value: _wifiSignalStrength == '穿墙',
              title: Text('穿墙'),
            ),
            Divider(),
            CheckboxListTile(
              onChanged: (value) {
                setState(() {
                  _wifiSignalStrength = '节能';
                });
              },
              value: _wifiSignalStrength == '节能',
              title: Text('节能'),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
