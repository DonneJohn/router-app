import 'package:flutter/material.dart';
import 'package:hg_router/res/strings.dart';

///
///Created by slkk on 2019/8/30/0030 14:56
///
class ItemSecurityCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemSecurityCenterState();
}

class _ItemSecurityCenterState extends State<ItemSecurityCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Str.securityCenter),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.security,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '安全保护未开启，存在安全隐患',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
              child: Text(''),
            ),
            RaisedButton(
              onPressed: () {

              },
              color: Colors.blue,
              child: Text('一键开启'),
            )
          ],
        ));
  }
}
