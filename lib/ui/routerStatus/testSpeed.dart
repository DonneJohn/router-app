import 'package:flutter/material.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/myDivider.dart';
import 'package:hg_router/ui/custom/myListTile.dart';
import 'package:hg_router/ui/custom/widget.dart';

class TestSpeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestSpeedState();
}

class _TestSpeedState extends State<TestSpeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '测速不准',
              style: ITextStyles.appBarActionTextStyle,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '一键测速',
                    style: ITextStyles.pageTitleStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '已连接WI-FI HENGGU-2F 5G',
                    style: ITextStyles.white_font15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '手机到互联网速度：1.3MB/S,适合观看高清视屏',
                    softWrap: true,
                    style: ITextStyles.white_font10,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '上传速度',
                          style: ITextStyles.pageTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '000.0 kb/s',
                          style: ITextStyles.pageTextStyle,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '上传速度',
                          style: ITextStyles.pageTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '000.0 kb/s',
                          style: ITextStyles.pageTextStyle,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '上传速度',
                          style: ITextStyles.pageTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '000.0 kb/s',
                          style: ITextStyles.pageTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              MyDivider(),
              MyListTile(
                title: Text(
                  '检测是否自动跳转到钓鱼网站',
                  style: ITextStyles.pageTextStyle,
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '安全',
                        style: ITextStyles.pageTextStyle,
                      ),
                      Icon(
                        Icons.security,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              MyDivider(),
              MyListTile(
                title: Text(
                  '检测是否为钓鱼WI-FI',
                  style: ITextStyles.pageTextStyle,
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '安全',
                        style: ITextStyles.pageTextStyle,
                      ),
                      Icon(
                        Icons.security,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              MyDivider(),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                onPressed: () {},
                width: 300,
                text: '完成',
              ),
            ],
          )
        ],
      ),
    );
  }
}
