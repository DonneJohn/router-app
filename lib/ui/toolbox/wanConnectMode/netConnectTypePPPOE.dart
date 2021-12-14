import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/bloc/toolbox/wanSettings/setNetworkBloc.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:hg_router/models/toolbox/wanSettings/setNetworkModel.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';

import '../../../main.dart';
import 'wanConnectSetPage.dart';

///
///Created by slkk on 2019/9/10/0010 15:01
///
class NetConnectTypePPPOE extends StatefulWidget {
  final String username;
  final String password;

  const NetConnectTypePPPOE({Key key, this.username, this.password})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetConnectTypePPPOEState();
}

class _NetConnectTypePPPOEState extends State<NetConnectTypePPPOE> {
  bool _isObscure = true;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.username.isNotEmpty) {
      nameController.text = widget.username;
    }
    if (widget.password.isNotEmpty) {
      pwdController.text = widget.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.height, 120),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colours.priBlue, Colours.priRed],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            flexibleSpace: Container(
              alignment: Alignment.center,
              child: Text(
                'PPPOE',
                style: ITextStyles.pageTitleStyle,
              ),
              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ///宽带账号
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: S.of(context).broadbandAccount,
                  labelStyle: ITextStyles.pageTextStyleGrey),
            ),
          ),

          ///宽带密码
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              obscureText: _isObscure,
              controller: pwdController,
              decoration: InputDecoration(
                  labelStyle: ITextStyles.pageTextStyleGrey,
                  labelText: S.of(context).broadbandPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
            ),
          ),
          OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(
                    color: Color(0xFFFFFF00),
                    style: BorderStyle.solid,
                    width: 2)),
            onPressed: () {
              setPPPOE();
            },

            ///确定
            child: Container(
              alignment: Alignment.center,
              width: 300,
              child: Text(S.of(context).ok),
            ),
          ),
        ],
      ),
    );
  }

  void setPPPOE() {
    var name = nameController.text.toString();
    var pwd = pwdController.text.toString();
    if (name.isEmpty || pwd.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.of(context).emptyToastMessage),
      ));
    }
    var showSnackBar = _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
          child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text(S.of(context).saveSetting)
        ],
      )),
    ));
    var setNetworkBloc = SetNetworkBloc();
    setNetworkBloc.setNetwork('PPPoE', pppoe: Pppoe(name, pwd));
    var stream = setNetworkBloc.subject.stream;
    stream.listen((onData) {
      logger.i(onData.return_parameter);
      if (onData.return_parameter.status == '0') {
        showSnackBar.close();
        Navigator.popUntil(
            context, ModalRoute.withName(WanConnectSettingPage.name));
      }
    });
  }
}
