import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/mesh/getMeshBloc.dart';
import 'package:hg_router/bloc/toolbox/mesh/setMeshBloc.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';

///
///Created by slkk on 2019/10/28/0028 15:15
///
class MeshPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeshPageState();
}

class _MeshPageState extends State<MeshPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var nameControl = TextEditingController();
  var pwdControl = TextEditingController();
  GetMeshBloc getMeshBloc;
  bool meshStatus = false;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getMeshStatus();
  }

  _getMeshStatus() {
    getMeshBloc = GetMeshBloc();
    getMeshBloc.getMesh();
    getMeshBloc.subject.stream.listen((onData) {
      if (onData.errorCode == 900) {
        setState(() {
          isLoading = false;
          isError = true;
        });
        return;
      }
      if (onData.return_parameter.status == "0") {
        setState(() {
          isLoading = false;
          meshStatus = onData.return_parameter.result.status == "on";
        });
      }
    });
  }

  _setMeshStatus(String status) {
    _globalKey.currentState.removeCurrentSnackBar();
    _globalKey.currentState.showSnackBar(SnackBar(
      content: Container(
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Gaps.hGap10,
            Text('请稍后')
          ],
        ),
      ),
    ));
    SetMeshBloc setMeshBloc = SetMeshBloc();
    setMeshBloc.setMesh(status);
    setMeshBloc.subject.stream.listen((onData) {
      _globalKey.currentState.removeCurrentSnackBar();
      if (onData.return_parameter.status == "0") {
        _globalKey.currentState.showSnackBar(SnackBar(
          content: Container(child: Text('设置成功')),
        ));
        setState(() {
          meshStatus = !meshStatus;
        });
      } else {
        _globalKey.currentState.showSnackBar(SnackBar(
          content: Container(child: Text('设置失败')),
        ));
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
          child: SwitchListTile(
            onChanged: (value) {
              if (value) {
                _setMeshStatus("on");
              } else {
                _setMeshStatus("off");
              }
            },
            title: Text('Mesh'),
            value: meshStatus,
            activeTrackColor: Colors.green,
            activeColor: Colors.white,
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
          preferredSize: Size(double.infinity, 100),
          title: "Mesh",
//        action: <Widget>[
//          FlatButton(
//            onPressed: () {},
//            child: Text(
//              "保存",
//              style: ITextStyles.pageTextStyleWhite,
//            ),
//          )
//        ],
        ),
        body: getBody());
  }
}
