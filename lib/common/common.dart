///
///Created by slkk on 2019/9/4
///
class Constant {
  static const String routerLocalPort = "8421";
  static const String routerLocalHttpsPort = "8422";
  static const String routerLocalBindApi = "devices/basic";
  static const String routeMain = 'route_main';
  static const String routeLogin = 'route_login';
  static const String routeGuide = 'route_guide';
  static const String routeForgetPwd = 'route_forget_pwd';
  static const String routeRegister = 'route_register';
  static const String routeDHCPSetPage = 'route_DHCPSetPage';
  static const String routeMyProfilePage = 'route_myProfile';
  static const String routeCropImagePage = 'route_cropImage';
  static const String emailReg =
      r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";
  static const String cellPhoneReg =
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$';

  static const String keyUserName = 'user_name';
  static const String keyUserModel = 'user_model';
  static const String keyAppToken = 'app_token';
  static const String appUUID = 'app_uuid';
  static const String bindDeviceList = 'bind_device_list';
  static const String clinetid = 'clientid';
  static const String routerUUID = 'router_uuid';
  static const String routerMac = 'router_mac';
  static const String currentDevice = 'currentDevice';
  static const String keyShowGuide = 'show_guide';
  static const String operatorl = 'operatorl';
  static const String agent_host = 'agent_host';
  static const String agent_port = 'agent_port';


  static const String mqttTopicToRouterPrefix = '/request/to-router/app/';
  static const String mqttTopicFromRouterPrefix = '/response/to-app/app/';
  static const String mqttTopicPushFromPlatform = '/push/to-app/all-apps';
  static const String mqttTopicPushFromPlatformPrefix = '/push/to-app/';
  static const String mqttTopicPushFromRouterPrefix = '/push/from-router/';

  static const String mqttCmdTypeDevicesCapabilities = 'devices/capabilities';
  static const String mqttCmdTypeDevicesHosts = 'devices/getHosts';
  static const String mqttCmdTypeListHosts = 'devices/listHosts';
  static const String mqttCmdTypeRunningStatus = 'devices/running';
  static const String mqttCmdTypeDeviceStatus = 'devices/status';
  static const String mqttCmdTypeSetHostRateLimit = 'devices/setHostRateLimit';
  static const String mqttCmdTypGetHostInfo2 = 'devices/getHostInfo2';
  static const String mqttCmdTypeGetHostInfo = 'devices/getHostInfo';
  static const String mqttCmdTypeSetHostInfo = 'devices/setHostInfo';
  static const String mqttCmdTypeGetWifiInfo = 'devices/getWiFi';
  static const String mqttCmdTypeSetWifiInfo = 'devices/setWiFi';
  static const String mqttCmdTypeGetInternetConnect =
      'devices/getInternetConnect';
  static const String mqttCmdTypeGetInternetAccess =
      'devices/getInternetAccess';
  static const String mqttCmdTypeAddInternetAccess =
      'devices/addInternetAccess';
  static const String mqttCmdTypeUpdateInternetAccess =
      'devices/updateInternetAccess';
  static const String mqttCmdTypeDeleteInternetAccess =
      'devices/deleteInternetAccess';
  static const String mqttCmdTypeSetInternetAccess =
      'devices/setInternetAccess';
  static const String mqttCmdTypeSetInternetConnect =
      'devices/setInternetConnect';
  static const String mqttCmdTypeSetInternetConnect2 =
      'devices/setInternetConnect2';
  static const String mqttCmdTypeUpdateInternetConnect3 =
      'devices/updateInternetConnect3';
  static const String mqttCmdTypeGetNetwork = 'devices/getNetwork';
  static const String mqttCmdTypeSetNetwork = 'devices/setNetwork';
  static const String mqttCmdTypeGetAntiSteal = 'devices/getAntiSteal';
  static const String mqttCmdTypeSetAntiSteal = 'devices/setAntiSteal';
  static const String mqttCmdTypeListAntiSteal = 'devices/listAntiSteal';
  static const String mqttCmdTypeAddAntiSteal = 'devices/addAntiSteal';
  static const String mqttCmdTypeDeleteAntiSteal = 'devices/deleteAntiSteal';
  static const String mqttCmdTypeUpdateAntiSteal = 'devices/updateAntiSteal';
  static const String mqttCmdTypeGetVpns = 'devices/getVpns';
  static const String mqttCmdTypeUpdateVpn = 'devices/updateVpn';
  static const String mqttCmdTypeAddVpn = 'devices/addVpn';
  static const String mqttCmdTypeGetVpnInfo = 'devices/getVpnInfo';
  static const String mqttCmdTypeGetVpnPolicy = 'devices/getVpnPolicys';
  static const String mqttCmdTypeAddVpnPolicy = 'devices/addVpnPolicys';
  static const String mqttCmdTypeDeleteVpnPolicy = 'devices/deleteVpnPolicys';
  static const String mqttCmdTypeUpdateVpnPolicy = 'devices/updateVpnPolicys';
  static const String mqttCmdTypeReboot = 'devices/reboot';
  static const String mqttCmdTypeGetLed = 'devices/getLed';
  static const String mqttCmdTypeSetLed = 'devices/updateLed';
  static const String mqttCmdTypeRestoreDefault = 'devices/restoredefault';
  static const String mqttCmdTypeGetTime = 'devices/getTime';
  static const String mqttCmdTypeSetTime = 'devices/setTime';
  static const String mqttCmdTypeReSetpwd = 'devices/resetpwd';
  static const String mqttCmdTypeGetGuestWiFi = 'devices/getGuestWiFi';
  static const String mqttCmdTypeSetGuestWiFi = 'devices/setGuestWiFi';
  static const String mqttCmdTypeGetSmartRateLimit =
      'devices/getSmartRateLimit';
  static const String mqttCmdTypeSetSmartRateLimit =
      'devices/setSmartRateLimit';
  static const String mqttCmdTypeGetMesh = 'devices/getMesh';
  static const String mqttCmdTypeSetMesh = 'devices/updateMesh';
  static const String mqttCmdTypeGetUsb30 = 'devices/getUSB30';
  static const String mqttCmdTypeSetUsb30 = 'devices/updateUSB30';
  static const String mqttCmdTypeChangePassword = 'devices/changePassword';
  static const String mqttCmdTypeListCronReboot = 'devices/listCronReboot';
  static const String mqttCmdTypeUpdateCronReboot = 'devices/updateCronReboot';
  static const String mqttCmdTypeDeviceDetect = 'devices/deviceDetect';
  static const String mqttCmdTypeDeviceInfo = 'devices/info';
  static const String mqttCmdTypeChangeURL = 'devices/changeURL';
  static const String mqttCmdTypeHostSignin = 'devices/hostSignin';
  static const String mqttCmdTypeHostSteal = 'devices/hostSteal';
  static const String mqttCmdTypeOffline= 'devices/offline';
  static const String mqttCmdTypeDevicesBasic= 'devices/basic';
  static const String mqttCmdTypeStartSpeedTest= 'devices/startSpeedTest';
  static const String mqttCmdTypeListInternetConnect= 'devices/listInternetConnect';
  static const String mqttCmdTypeAddInternetConnect= 'devices/addInternetConnect';
  static const String mqttCmdTypeDeleteInternetConnect= 'devices/deleteInternetConnect';
  static const String mqttCmdTypeGetUpgrade= 'devices/getUpgrade';
  static const String mqttCmdTypeSetUpgrade= 'devices/setUpgrade';
}
