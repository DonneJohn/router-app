import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hg_router/res/colors.dart';
import 'package:hg_router/res/styles.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    this.width,
    this.height = 50,
    this.margin,
    this.radius,
    this.bgColor,
    this.highlightColor,
    this.splashColor,
    this.child,
    this.text,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  final double radius;
  final Color bgColor;
  final Color highlightColor;
  final Color splashColor;

  final Widget child;

  final String text;
  final TextStyle style;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color _bgColor = bgColor ?? Theme.of(context).primaryColor;
    BorderRadius _borderRadius = BorderRadius.circular(radius ?? (height / 2));
    return new Container(
      width: width,
      height: height,
      margin: margin,
      child: new Material(
        borderRadius: _borderRadius,
        color: _bgColor,
        child: new InkWell(
          borderRadius: _borderRadius,
          onTap: () => onPressed(),
          child: child ??
              new Center(
                child: new Text(
                  text,
                  style:
                      style ?? new TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key key,
    this.width,
    this.height = 50,
    this.margin,
    this.radius,
    this.bgColor,
    this.highlightColor,
    this.splashColor,
    this.child,
    this.text,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  final double radius;
  final Color bgColor;
  final Color highlightColor;
  final Color splashColor;

  final Widget child;

  final String text;
  final TextStyle style;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 35, 30, 0),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 53, 37, 176),
            Color.fromARGB(255, 184, 101, 211)
          ]), // 渐变色
          borderRadius: BorderRadius.circular(25)),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.transparent,
        // 设为透明色
        elevation: 0,
        // 正常时阴影隐藏
        highlightElevation: 0,
        // 点击时阴影隐藏
        onPressed: onPressed,

        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class LoginItem extends StatefulWidget {
  const LoginItem({
    Key key,
    this.prefixIcon,
    this.hasSuffixIcon = false,
    this.hintText,
    this.controller,
    this.inputFormatters,
  }) : super(key: key);

  final IconData prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;

  @override
  State<StatefulWidget> createState() {
    return LoginItemState();
  }
}

class LoginItemState extends State<LoginItem> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new IconButton(
            iconSize: 28,
            icon: new Icon(
              widget.prefixIcon,
              color: Color.fromARGB(255, 44, 185, 176),
            ),
            onPressed: () {}),
        Gaps.hGap10,
        new Expanded(
          child: new TextField(
              obscureText: _obscureText,
              controller: widget.controller,
              style: new TextStyle(color: Colours.gray_66, fontSize: 14),
              inputFormatters: widget.inputFormatters,
              decoration: new InputDecoration(
                hintText: widget.hintText,
                hintStyle: new TextStyle(color: Colours.gray_99, fontSize: 14),
                suffixIcon: widget.hasSuffixIcon
                    ? new IconButton(
                        icon: new Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colours.gray_66,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        })
                    : null,
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colours.green_de)),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colours.green_de)),
              )),
        ),
      ],
    );
  }
}

class MyAppBar extends PreferredSize {
  final String title;
  final Size preferredSize;
  final List<Widget> action;

  const MyAppBar(
      {Key key,
      @required this.title,
      @required this.preferredSize,
      this.action})
      : super(key: key, preferredSize: preferredSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colours.priBlue, Colours.priRed],
        ),
      ),
      child: AppBar(
        actions: action,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        flexibleSpace: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: ITextStyles.pageTitleStyle,
          ),
          margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
        ),
      ),
    );
  }
}
