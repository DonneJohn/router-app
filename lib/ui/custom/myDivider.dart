import 'package:flutter/material.dart';

///
///Created by slkk on 2019/9/28/0028 12:59
///
class MyDivider extends Divider {
  final double myHeight;

  final double thickness;

  final double indent;

  final double endIndent;

  final Color color;

  MyDivider(
      {this.thickness,
      this.indent,
      this.endIndent,
      this.color,
      this.myHeight = 1})
      : super(
            height: myHeight,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
            color: color);
}
