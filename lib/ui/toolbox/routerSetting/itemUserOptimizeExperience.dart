import 'package:flutter/material.dart';
import 'package:hg_router/utils/utils.dart';

class ItemUserOptimizeExperience extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemUserOptimizeExperienceState();
}

class _ItemUserOptimizeExperienceState
    extends State<ItemUserOptimizeExperience> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('用户体验改进计划'),
      ),
      body: Builder(
        builder: (context) {
          return Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  Util.showSnackBar(context, '退出用户体验计划成功');
                },
                child: Text('退出用户体验计划'),
              ),
            ],
          );
        },
      ),
    );
  }
}
