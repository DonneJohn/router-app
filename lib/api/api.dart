///
///Created by slkk on 2019/9/5/0005 13:46
///
class Api {
  static const String baseUrlhttp = "http://192.168.61.200:3300";
  static const String baseUrl = "https://192.168.61.200:3443";
  static const String logoutUrl = "/api/v1/mobile/userLogout";
  static const String emailLoginUrl = "/api/v1/mobile/userLogin";
  static const String phoneLoginUrl = "/api/v1/mobile/phoneLogin";
  static const String identifyingCodeUrl = "/api/v1/mobile/userCode";
  static const String registerUrl = "/api/v1/mobile/userRegister1";
  static const String phoneRegisterUrl = "/api/v1/mobile/phoneRegister";
  static const String userResetUrl = "/api/v1/mobile/userReset";
  static const String bindRouterUrl = "/api/v1/devices/bind";
  static const String unBindRouterUrl = "/api/v1/devices/unbind";
  static const String userFeedback = "/api/v1/feedback/note";
  static const String getLocation = "/api/v1/devices/region";
  static const String getBindList = "/api/v1/devices/bindlistM";
  static const String getPhoneCode = "/api/v1/mobile/phoneCode";
  static const String avatorApiUrl = "/api/v1/mobile/avator";
  static const String userNickname = "/api/v1/mobile/nickname";
  static const String deviceNickname = "/api/v1/devices/nickname";
  static const String getUpgrade = "/api/v1/devices/upgrade";
}
