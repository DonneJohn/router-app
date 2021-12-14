import 'package:flutter/material.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OptimizeWifiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptimizeWifiPageState();
}

class _OptimizeWifiPageState extends State<OptimizeWifiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Builder(builder: (context) {
        return Container(
          child: Column(
            children: <Widget>[
              Gaps.hGap30,
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      child: Text('WI-FI优化', style: ITextStyles.pageTitleStyle),
                      padding: EdgeInsets.all(10),
                    ),
                    CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: 0.7,
                      center: new Text(
                        "70.0%",
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      footer: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: new Text("正在扫描wifi信道",
                            style: ITextStyles.white_font13),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    MyListTile(
                      onTap: () {},
                      title: Text(
                        'WI-FI质量',
                        style: ITextStyles.pageTextStyle,
                      ),
                      subtitle:
                          Text('减少干扰，提升网速', style: ITextStyles.pageSubTextStyle),
                      trailing: Icon(Icons.cached),
                    ),
                    MyDivider(),
                    MyListTile(
                      onTap: () {},
                      title: Text('信号强度'),
                      subtitle: Text('提升信号强度，改善远距离联网速度'),
                      trailing: Text('等待检测',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
