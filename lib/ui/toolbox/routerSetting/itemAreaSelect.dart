
import 'package:flutter/material.dart';
import 'package:hg_router/api/regionApi.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/utils.dart';

class ItemAreaSelect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemAreaSelectState();
}

class _ItemAreaSelectState extends State<ItemAreaSelect> {
  String _area;

  List<String> itemTitle = [
    '中国大陆',
    '中国香港',
    '中国台湾',
    '印度',
    '欧洲',
    '美国',
    '其他',
  ];

  @override
  void initState() {
    _area = '中国香港';
    // TODO: implement initState
    var locationApi = RegionApi();
    locationApi
        .getRegion(SpUtil.getString(Constant.routerMac))
        .then((onValue) {
      if (onValue.code == 200) {
        setState(() {
          _area = '其他';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('地区选择'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => _getItem(index,context),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 7),
    );
  }

  Widget _getItem(int index,BuildContext context) {
    return CheckboxListTile(
      title: Text(itemTitle[index]),
      value: _area == itemTitle[index],
      onChanged: (value) {
        var showCircularSnackBar = Util.showCircularSnackBar(context, '正在设置');
        var locationApi = RegionApi();
        locationApi
            .setRegion(
                SpUtil.getString(Constant.routerMac), itemTitle[index])
            .then((onData){
              if(onData.code == 200){
                showCircularSnackBar.close();
                Navigator.pop(context);
              }
        });

        setState(() {
          _area = value ? itemTitle[index] : _area;
        });

        //TODO 存储
      },
    );
  }
}
