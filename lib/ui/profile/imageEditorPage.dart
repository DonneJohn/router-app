import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:hg_router/api/avatorApi.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/res/colors.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import 'crop_editor_helper.dart';

///
///  create by slkk on 2019/11/16
///

class ImageEditorPage extends StatefulWidget {
  final int type;
  final String avatarFilePath;

  const ImageEditorPage({Key key, this.type, this.avatarFilePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  List<AspectRatioItem> _aspectRatios = List<AspectRatioItem>()
    ..add(AspectRatioItem(text: "custom", value: CropAspectRatios.custom))
    ..add(AspectRatioItem(text: "original", value: CropAspectRatios.original))
    ..add(AspectRatioItem(text: "1*1", value: CropAspectRatios.ratio1_1));
  AspectRatioItem _aspectRatio;
  bool _cropping = false;
  File _fileImage;

  Future<File> _initImage(int type) async {
    if (type == 0) {
      File image = await picker.ImagePicker.pickImage(
          source: picker.ImageSource.gallery);
      return image;
    } else {
      File image =
          await picker.ImagePicker.pickImage(source: picker.ImageSource.camera);
      return image;
    }
  }

  @override
  void initState() {
    _initImage(widget.type).then((onValue) {
      setState(() {
        _fileImage = onValue;
      });
    });
    _aspectRatio = _aspectRatios[2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colours.priRed,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _cropImage(false);
            },
          ),
        ],
      ),
      body: _fileImage == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: ExtendedImage.file(
              _fileImage,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.editor,
              enableLoadState: true,
              extendedImageEditorKey: editorKey,
              initEditorConfigHandler: (state) {
                return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: EdgeInsets.all(20.0),
                    hitTestSize: 20.0,
                    initCropRectType: InitCropRectType.imageRect,
                    cropAspectRatio: _aspectRatio.value);
              },
            )),
    );
  }

  void _showCropDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext content) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Material(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "select library to crop",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Image",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launch(
                                          "https://github.com/brendan-duncan/image");
                                    }),
                              TextSpan(
                                  text:
                                      "(Dart library) for decoding/encoding image formats, and image processing. It's stable.")
                            ],
                          ),
                          TextSpan(text: "\n\n"),
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "ImageEditor",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launch(
                                          "https://github.com/fluttercandies/flutter_image_editor");
                                    }),
                              TextSpan(
                                  text:
                                      "(Native library) support android/ios, crop flip rotate. It's faster.")
                            ],
                          )
                        ])),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlineButton(
                              child: Text(
                                'Dart',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _cropImage(false);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            OutlineButton(
                              child: Text(
                                'Native',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _cropImage(true);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ))),
              Expanded(
                child: Container(),
              )
            ],
          );
        });
  }

//  void _cropImage(bool useNative) async {
//    if (_cropping) return;
//    var msg = "";
//    try {
//      _cropping = true;
//      showBusyingDialog();
//      Uint8List fileData;
//      fileData =
//          await cropImageDataWithDartLibrary(state: editorKey.currentState);
//      await saveImage(widget.avatarFilePath, fileData);
////      upload(fileData);
//    } catch (e) {
//      msg = "save faild: $e";
//      print(msg);
//    }
//
////    showToast(msg);
//  }

  void _cropImage(bool useNative) async {
    if (_cropping) return;
    var msg = "";
    try {
      _cropping = true;

      showBusyingDialog();

      Uint8List fileData;

      /// 保留这部分，万一有bug可以切换到另一个库
      if (useNative) {
//        fileData =
//            await cropImageDataWithNativeLibrary(state: editorKey.currentState);
      } else {
        fileData =
            await cropImageDataWithDartLibrary(state: editorKey.currentState);
      }

      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      getTemporaryDirectory().then((onValue) {
        String filePath = onValue.path + "/" + filename + ".jpg";
        saveImage(filePath, fileData);
      });
    } catch (e) {
      msg = "save faild: $e";
      print(msg);
    }
    _cropping = false;
  }

  Future showBusyingDialog() async {
    var primaryColor = Theme.of(context).primaryColor;
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "正在上传中请稍后...",
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
          ),
        ));
  }

  void upload(File source, String path) async {
    logger.d("path: $path");
    FormData data = FormData.fromMap({
      "avator": await MultipartFile.fromFile(source.path,
          filename: path.substring(path.lastIndexOf("/") + 1))
    });
    AvatorApi api = AvatorApi();
    api.updateAvator(data).then((onValue) {
      if (onValue.code == 200) {
        logger.i("上传成功");
        _cropping = false;
//        Navigator.popUntil(context, ModalRoute.withName(Constant.routeMain));
        Navigator.of(context)..pop()..pop(path);
      }
    });
  }

  Future<void> saveImage(String path, List<int> bytes) async {
    File file = File(path);
    await file.writeAsBytes(bytes, flush: true).then((onValue) {
      upload(onValue, path);
    });
  }
}

class AspectRatioItem {
  final String text;
  final double value;

  AspectRatioItem({this.value, this.text});
}
