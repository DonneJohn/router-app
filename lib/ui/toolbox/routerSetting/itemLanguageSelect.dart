
import 'package:flutter/material.dart';
import 'package:hg_router/ui/app.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hg_router/res/config.dart';
import 'package:hg_router/utils/SpUtil.dart';

class ItemLanguageSelect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemLanguageSelectState();
}

class _ItemLanguageSelectState extends State<ItemLanguageSelect> {
  String language;
  List<String> itemTitle = ['zh', 'en'];

  @override
  void initState() {
    language = SpUtil.getString('language',
        defValue: AppConfig.languageConfig['language']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    S.of(context).languageSelect_simplifiedChinese;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).language_setting),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => _getItem(context, index),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 2),
    );
  }

  Widget _getItem(BuildContext context, int index) {
    return CheckboxListTile(
      title: getItemTitle(index),
      value: language == itemTitle[index],
      onChanged: (value) {
        setState(() {
          language = value ? itemTitle[index] : language;
        });
        if (index == 0) {
          SpUtil.putString('language', 'zh');
        } else if (index == 1) {
          SpUtil.putString('language', 'en');
        }
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).rebootForEffect)));
      },
    );
  }

  Widget getItemTitle(int index) {
    if (index == 0) {
      return Text(S.of(context).languageSelect_simplifiedChinese);
    } else if (index == 1) {
      return Text(S.of(context).languageSelect_english);
    }
  }
}
