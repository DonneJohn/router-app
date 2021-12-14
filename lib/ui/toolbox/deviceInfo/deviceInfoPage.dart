import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/getDeviceInfoBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/toolbox/getDeviceInfoResponseModel.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/ui/custom/widget.dart';

/*
*路由器信息界面
*/
class DeviceInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DeviceInfoPageState();
}

class DeviceInfoPageState extends State<DeviceInfoPage> {
  GetDeviceInfoBloc getDeviceInfoBloc;
  static String model;
  static String hardwareVersion;
  static String softwareVersion;
  static String macAddress;
  static String processors;
  static String frequency;
  static String routerVersion;
  static String ddrSize;
  static String ddrType;
  static String ddrFrequency;
  static String flashSize;
  static String flashType;
  static String scenario;
  List<String> itemTitle = [
    "CPU使用率",
    "内存使用率",
    "路由型号",
    "联网状态",
    "路由地点",
    "硬件版本",
    "固件版本",
    "WAN IP",
    "LAN IP",
    "MAC地址",
  ];
  List<String> itemTrailing = [
    frequency ?? "50%",
    "80%",
    model ?? "TY-300",
    "连接",
    "家",
    hardwareVersion ?? "1.1",
    softwareVersion ?? "1.1",
    "192.156.23.3",
    "192.168.1.1",
    macAddress ?? "00:11:22:33:44:55",
  ];

  @override
  void initState() {
    getDeviceInfoBloc = GetDeviceInfoBloc();
    getDeviceInfoBloc.getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size(double.infinity, 100),
          title: "路由信息",
        ),
        body: StreamBuilder(
            stream: getDeviceInfoBloc.subject.stream,
            builder:
                (context, AsyncSnapshot<GetDeviceInfoResponseModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.errorCode == 900) {
                  return Center(
                    child: Text('出错了'),
                  );
                }
                logger.d("++++++++++++++++++");
                handleResult(snapshot);
                return Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) => _getItem(index),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: 10),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  void handleResult(AsyncSnapshot<GetDeviceInfoResponseModel> snapshot) {
    var result = snapshot.data.return_parameter.result;
    model = result?.model;
    hardwareVersion = result?.hardwareVersion;
    softwareVersion = result?.softwareVersion;
    macAddress = result?.macAddress;
    processors = result?.processors;
    frequency = result?.frequency;
    ddrSize = result?.ddrSize;
    ddrType = result?.ddrType;
    ddrFrequency = result?.ddrFrequency;
    flashSize = result?.flashSize;
    flashType = result?.flashType;
    scenario = result?.scenario;
  }

  Widget _getItem(int index) {
    return ListTile(
      title: Text(itemTitle[index]),
      trailing: Text(itemTrailing[index]),
    );
  }

//  _showBottomSheet(int index) async {
//    if (index == 0) {
//      String rel = await _showEditRouterNameBottomSheet();
//      if (rel.isNotEmpty) {
//        setState(() {
//          routerName = rel;
//        });
//      }
//    } else if (index == 1) {
//      String rel = await _showEditRouterLocationBottomSheet();
//      setState(() {
//        routerLocation = rel ?? '';
//      });
//    }
//  }

  Future<String> _showEditRouterNameBottomSheet() {
    var textEditingController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(labelText: Str.pleaseInputNewName),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(
                      context, textEditingController.text.toString() ?? '');
                },
                color: Colors.blue,
                child: Text(Str.confirm),
              )
            ],
          ),
        );
      },
    );
  }

  Future<String> _showEditRouterLocationBottomSheet() {
    var textEditingController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          height: 300,
          child: Column(
            children: <Widget>[
              Text(Str.selectRouterLocation),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                child: Text(Str.home),
                onPressed: () {
                  Navigator.pop(context, Str.home);
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, Str.company);
                },
                child: Text(Str.company),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, Str.customize);
                },
                child: Text(Str.customize),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.blue,
                child: Text(Str.confirm),
              )
            ],
          ),
        );
      },
    );
  }
}
