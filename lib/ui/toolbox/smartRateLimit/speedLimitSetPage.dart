import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/smartRateLimit/setSmartRateLimitBloc.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/28/0028 14:31
///
class SpeedLimitSetPage extends StatefulWidget {
  final String upstream;
  final String downstream;

  const SpeedLimitSetPage({Key key, this.upstream, this.downstream})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SpeedLimitSetPageState();
}

class _SpeedLimitSetPageState extends State<SpeedLimitSetPage> {
  var upstreamControl = TextEditingController();
  var downstreamControl = TextEditingController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    upstreamControl.text = widget.upstream;
    downstreamControl.text = widget.downstream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "限速设置",
        action: <Widget>[
          FlatButton(
            onPressed: () {
              var setSmartRateLimitBloc = SetSmartRateLimitBloc();
              if (upstreamControl.text.isEmpty ||
                  downstreamControl.text.isEmpty) {
                return;
              }
              setSmartRateLimitBloc.setSmartRateLimit(
                  upstream: upstreamControl.text.toString(),
                  downstream: downstreamControl.text.toString());
              setSmartRateLimitBloc.subject.stream.listen((onData) {
                if (onData.return_parameter.status == "0") {
                  _globalKey.currentState.showSnackBar(SnackBar(
                    content: Text("设置成功"),
                  ));
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                }
              });
            },
            child: Text(
              "保存",
              style: ITextStyles.pageTextStyleWhite,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(16, 10, 10, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('上传限速'),
                        Gaps.hGap10,
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(),
                            controller: upstreamControl,
                          ),
                        )
                      ],
                    ),
                    Gaps.vGap20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('下载限速'),
                        Gaps.hGap10,
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(),
                            controller: downstreamControl,
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
