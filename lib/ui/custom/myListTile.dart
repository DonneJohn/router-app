import 'package:flutter/material.dart';

///
///Created by slkk on 2019/9/28/0028 13:05
///
class MyListTile extends StatelessWidget {
  final Widget leading;

  final Widget title;

  final Widget subtitle;

  final Widget trailing;

  final bool isThreeLine;

  final bool dense;

  final EdgeInsetsGeometry contentPadding;

  final bool enabled;

  final GestureTapCallback onTap;

  final GestureLongPressCallback onLongPress;

  final bool selected;
  final double height;

  const MyListTile({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense = false,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.height = 55,
  })  : assert(isThreeLine != null),
        assert(enabled != null),
        assert(selected != null),
        assert(!isThreeLine || subtitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: ListTile(
        isThreeLine: isThreeLine,
        dense: dense,
        contentPadding: contentPadding,
        enabled: enabled,
        onLongPress: onLongPress,
        selected: selected,
        onTap: onTap,
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
