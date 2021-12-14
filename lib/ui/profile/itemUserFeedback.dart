import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hg_router/api/userFeedbackApi.dart';
import 'package:hg_router/res/styles.dart';
import 'package:hg_router/ui/custom/widget.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ItemUserFeedback extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemUserFeedback();
}

class _ItemUserFeedback extends State<ItemUserFeedback> {
  List<File> _imageList = List<File>(4);
  TextEditingController suggestController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        preferredSize: Size(double.infinity, 100),
        title: "用户反馈",
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '问题与建议',
                        style: ITextStyles.pageTextStyle,
                      ),
                    ),
                    TextField(
                      controller: suggestController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('问题截图', style: ITextStyles.pageTextStyle),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _getImageItem(index);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 3,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('联系方式', style: ITextStyles.pageTextStyle),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        controller: contactController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundButton(
                      text: '提交',
                      onPressed: () {
                        _doFeedback(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _doFeedback(BuildContext context) {
    var suggest = suggestController.text;
    var contact = contactController.text;
    if (suggestController.text.isEmpty) {
      Util.showSnackBar(context, '建议不能为空');
      return;
    }

    FormData data = new FormData.fromMap({
      "suggest": suggest.toString(),
      "issue": "feedback",
      "contact": contact.isEmpty ? '' : contact.toString(),
      "1": _imageList.length == 1
          ? MultipartFile.fromFile(_imageList[0].path,
              filename: 'feedbackImage_00')
          : null,
      "2": _imageList.length == 2
          ? MultipartFile.fromFile(_imageList[1].path,
              filename: 'feedbackImage_01')
          : null,
      "3": _imageList.length == 3
          ? MultipartFile.fromFile(_imageList[2].path,
              filename: 'feedbackImage_02')
          : null,
    });
    Util.showCircularSnackBar(context, '正在发送用户反馈');
    var userFeedbackApi = UserFeedbackApi();
    var response = userFeedbackApi.doFeedback(data);
    response.then((onResponse) {
      if (onResponse.code == 201) {
        Util.showSnackBar(context, '发送用户反馈成功');
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        Util.showSnackBar(context, "发送用户反馈失败");
      }
    });
  }

  Widget _getImageItem(int index) {
    if (_imageList[index] == null) {
      return Container(
        width: 70,
        height: 70,
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            side: BorderSide(
                style: BorderStyle.solid, color: Colors.grey, width: 0.0),
          ),
          color: Colors.white,
        ),
        child: IconButton(
          onPressed: () {
            print('tap');
            addToImageList(index);
          },
          icon: Icon(
            Icons.add,
            size: 30,
            color: Colors.grey,
          ),
        ),
      );
    }
    return Container(
      width: 100,
      height: 100,
      child: Stack(alignment: Alignment.topRight, children: <Widget>[
        Center(
            child: Image.file(
          _imageList[index],
          width: 70,
          height: 70,
          fit: BoxFit.scaleDown,
        )),
        Container(
          width: 30,
          height: 30,
          child: IconButton(
            padding: EdgeInsets.all(2),
            iconSize: 20,
            onPressed: () {
              setState(() {
                _imageList[index] = null;
              });
            },
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ),
      ]),
    );
  }

  addToImageList(int index) async {
    File image = await _getImage();
    setState(() {
      _imageList[index] = image;
    });
    print(_imageList.length);
  }

  Future<File> _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
