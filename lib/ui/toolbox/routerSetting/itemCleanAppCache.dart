import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/res/strings.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class ItemCleanAppCache extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemCleanAppCacheState();
}

class _ItemCleanAppCacheState extends State<ItemCleanAppCache> {
  @override
  void initState() {
    // TODO: implement initState
//    loadCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Str.cleanAppCache),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  _clearCache(context);
                },
                title: Text(Str.cleanAppCache),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  Future<Null> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      tempDir.list(followLinks: false, recursive: true).listen((file) {
        //打印每个缓存文件的路径
        print(file.path);
      });

      logger.i("cache size: " + value.toString());
    } catch (err) {
      logger.e(err.toString());
    }
  }

  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null) {
          for (final FileSystemEntity child in children) {
            total += await _getTotalSizeOfFilesInDir(child);
            return total;
          }
          return 0;
        }
      }
    } catch (e) {
      logger.e(e);
      return 0;
    }
  }

  void _clearCache(BuildContext context) async {
    try {
      var tempDir = await getTemporaryDirectory();
      await delDir(tempDir);
      Util.showSnackBar(context, '清除缓存成功');
    } catch (e) {
      logger.e(e);
      Util.showSnackBar(context, '清除缓存失败');
    } finally {}
  }

  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      logger.e(e);
    }
  }
}
