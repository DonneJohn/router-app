import 'package:flutter/material.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/ui/homePage.dart';
import 'package:hg_router/ui/profile/myProfile.dart';
import 'package:hg_router/ui/registerAndLogin/loginPage.dart';
import 'package:hg_router/ui/splashPage.dart';
import 'package:hg_router/ui/registerAndLogin/guidepage.dart';
import 'package:hg_router/ui/registerAndLogin/emailRegisterPage.dart';
import 'package:hg_router/ui/registerAndLogin/forgetPwd.dart';
import 'package:hg_router/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hg_router/res/config.dart';
import 'package:hg_router/utils/SpUtil.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    await SpUtil.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        // You need to add them if you are using the material library.
        // The material components uses this delegates to provide default
        // localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: S.delegate.resolution(
          fallback: SpUtil.getString('language',
                      defValue: AppConfig.languageConfig['language']) ==
                  'zh'
              ? Locale('zh', 'CN')
              : Locale('en', '')),
      routes: {
        Constant.routeMain: (context) => HomePage(),
        Constant.routeLogin: (context) => LoginPage(),
        Constant.routeGuide: (context) => GuidePage(),
        Constant.routeRegister: (context) => EmailRegisterPage(),
        Constant.routeForgetPwd: (context) => ForgetPwdPage(),
        Constant.routeMyProfilePage: (context) => MyProfilePage(),
      },
      home: SplashPage(),
      theme: ThemeData.light().copyWith(primaryColor: Colors.blue),
    );
  }
}
