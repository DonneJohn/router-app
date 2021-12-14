import 'package:flutter/material.dart';
import 'package:hg_router/res/styles.dart';

class ItemAntiStealRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemAntiStealRecordState();
}

class _ItemAntiStealRecordState extends State<ItemAntiStealRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          '拦截记录',
          style: ITextStyles.appBarTitleStyle,
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.insert_drive_file,
            color: Colors.grey,
            size: 100,
          ),
          Text('暂无拦截记录')
        ],
      )),
    );
  }
}
