import 'package:flutter/material.dart';

class ItemAddVpn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemAddVpnState();
}

class _ItemAddVpnState extends State<ItemAddVpn> {
  bool _isObcureText = true;
  String vpnType = "PPTP";
  TextEditingController vpnNameController = TextEditingController();
  TextEditingController vpnServerController = TextEditingController();
  TextEditingController vpnUserNameController = TextEditingController();
  TextEditingController vpnPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _addVpn() {
    //TODO add vpn logic
    print('add vpn');
    var vpnName = vpnNameController.text.toString();
    if (vpnName.isNotEmpty) {
      print(vpnName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('添加VPN设置'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 15, 16),
                child: Text(
                  '名称',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: vpnNameController,
                  decoration: InputDecoration(),
                ),
              ),
            ],
          ),
          ListTile(
            onTap: () {
              _popBottomSheet();
            },
            title: Text('协议类型'),
            subtitle: Text(vpnType),
            trailing: Icon(Icons.chevron_right),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 0, 16),
                child: Text(
                  '服务器',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: vpnServerController,
                  decoration: InputDecoration(),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 0, 16),
                child: Text(
                  '用户名',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: vpnUserNameController,
                  decoration: InputDecoration(),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 15, 0),
                child: Text(
                  '密码',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: vpnPwdController,
                  obscureText: _isObcureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObcureText = !_isObcureText;
                        });
                      },
                      icon: _isObcureText
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              _addVpn();
            },
            child: Container(
              alignment: Alignment.center,
              width: 150,
              height: 40,
              child: Text('确定'),
            ),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _popBottomSheet() async {
    final reslut = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 130,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.pop(context, 'PPTP');
                  },
                  title: Text('PPTP'),
                  leading: vpnType == 'PPTP'
                      ? Icon(
                          Icons.chevron_right,
                          color: Colors.blue,
                        )
                      : Icon(
                          Icons.chevron_right,
                          color: Colors.transparent,
                        ),
                ),
                ListTile(
                  leading: vpnType == 'L2TP'
                      ? Icon(
                          Icons.chevron_right,
                          color: Colors.blue,
                        )
                      : Icon(
                          Icons.chevron_right,
                          color: Colors.transparent,
                        ),
                  onTap: () {
                    Navigator.pop(context, 'L2TP');
                  },
                  title: Text('L2TP'),
                )
              ],
            ),
          );
        });
    print(reslut);
    setState(() {
      if (reslut != null) vpnType = reslut;
    });
  }
}
