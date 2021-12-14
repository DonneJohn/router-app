import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/speedTestBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/28/0028 15:05
///
class TestSpeedPage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestSpeedPage3State();
}

class _TestSpeedPage3State extends State<TestSpeedPage3> {
  String upstream;
  String downstream;
  SpeedTestBloc speedTestBloc;

  @override
  void initState() {
    super.initState();
    speedTestBloc = SpeedTestBloc();
    speedTestBloc.startSpeedTest();
  }

  @override
  Widget build(BuildContext context) {
//    return StreamBuilder(
//        stream: speedTestBloc.outBloc,
//        builder: (context, AsyncSnapshot<CommonResponseModel> snapshot) {
//          if (snapshot.hasData) {
//            if (snapshot.data.errorCode == 900) {
//              return Center(child: Text("出错了"));
//            }
//            logger.d("get speed test data");
//            var result = snapshot.data.return_parameter.result;
//            upstream = result.upstream.bandwidth;
//            downstream = result.downstream.bandwidth;
//
//          } else {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }
//        });
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "一键测速",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              if (speedTestBloc != null) {
                speedTestBloc.startSpeedTest();
              }
            },
            child: Text(
              "重新测速",
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: speedTestBloc.outBloc,
          builder: (context, AsyncSnapshot<CommonResponseModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.errorCode == 900) {
                return Center(child: Text("出错了"));
              }
              logger.d("get speed test data");
              var result = snapshot.data.return_parameter.result;
              upstream = result.upstream.bandwidth;
              downstream = result.downstream.bandwidth;
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("上传速度"),
                          trailing: Text(upstream ?? ""),
                        ),
                        ListTile(
                          title: Text("下载速度"),
                          trailing: Text(downstream ?? ""),
                        )
                      ],
                    )),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
