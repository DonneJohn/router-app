import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/smartRateLimit/getSmartRateLimitBloc.dart';
import 'package:hg_router/bloc/toolbox/smartRateLimit/setSmartRateLimitBloc.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/ui/toolbox/smartRateLimit/speedLimitSetPage.dart';

///
///Created by slkk on 2019/10/28/0028 14:19
///
class SmartRateLimitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SmartRateLimitPageState();
}

class _SmartRateLimitPageState extends State<SmartRateLimitPage> {
  GetSmartRateLimitBloc bloc;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String policy = "auto";
  String upstream = "";
  String downstream = "";
  bool isLoading = true;
  bool isError = false;
  var policyTextMap = {
    'auto': '自动模式',
    'game': '游戏优先',
    'browser': '网页优先',
    'video': "视频优先"
  };

  @override
  void initState() {
    super.initState();
    _getSmartRateLimit();
  }

  _getSmartRateLimit() {
    bloc = new GetSmartRateLimitBloc();
    bloc.getSmartRateLimit();
    bloc.subject.listen((onData) {
      if (onData.errorCode == 900) {
        logger.d("loading error");
        setState(() {
          isLoading = false;
          isError = true;
        });
        return;
      }
      if (onData.return_parameter.status == "0") {
        setState(() {
          isLoading = false;
          var result = onData.return_parameter.result;
          policy = result.policy;
          downstream = result.bandwidth.downstream;
          upstream = result.bandwidth.upstream;
        });
      }
    });
  }

  Widget getBody() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (isError) {
        return Center(
          child: Text('出错了'),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ListTile(
                ///分配网速
                title: Text(
                  "分配网速",
                  style: ITextStyles.pageTextStyle,
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.grey),
                        child: DropdownButton<String>(
                          value: policy,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colours.priRed,
                          ),
                          onChanged: (String newValue) {
                            _setSmartRateLimit(context, policy);
                          },
                          items: <String>["auto", "browser", "game", "video"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(policyTextMap[value]),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SpeedLimitSetPage(
                      upstream: upstream,
                      downstream: downstream,
                    );
                  }));
                },
                title: Text("路由器限速"),
                trailing: Icon(Icons.chevron_right),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        appBar: MyAppBar(
          title: "智能限速",
          preferredSize: Size(double.infinity, 100),
        ),
        body: getBody());
  }

  _setSmartRateLimit(BuildContext context, String policy) {
    var setSmartRateLimitBloc = SetSmartRateLimitBloc();
    setSmartRateLimitBloc.setSmartRateLimit(policy: policy);
    setSmartRateLimitBloc.subject.listen((onData) {
      if (onData.return_parameter.status == "0") {
        _globalKey.currentState.showSnackBar(SnackBar(content: Text("设置成功")));
        _getSmartRateLimit();
      }
    });
  }
}
