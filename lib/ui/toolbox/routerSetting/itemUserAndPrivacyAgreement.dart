import 'package:flutter/material.dart';

class ItemUserAndPrivacyAgreement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemUserAndPrivacyAgreementState();
}

class _ItemUserAndPrivacyAgreementState
    extends State<ItemUserAndPrivacyAgreement> {
  List<String> itemTitle = ['用户协议', '隐私协议'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('用户协议&隐私计划'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => _getItem(index),
                separatorBuilder: (context, index) => Divider(),
                itemCount: 2),
          ),
          RaisedButton(
            onPressed: () {
              //TODO add privacy agreementl
            },
            color: Colors.blue,
            child: Text('不同意'),
          ),
        ],
      ),
    );
  }

  Widget _getItem(int index) {
    return ListTile(
      onTap: () {},
      title: Text(itemTitle[index]),
    );
  }
}
