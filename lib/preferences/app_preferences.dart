import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/models/vpn_info.dart';

class AppPreferences {
  static late Box boxOfData;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    boxOfData = await Hive.openBox("data");
  }

  // Saving user choice about theme selection
  static bool get isModeDark => boxOfData.get("isModeDark") ?? false;
  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);

  // Saving single selected vpn details
  static VpnInfo get vpnInfoObj =>
      VpnInfo.fromJSON(jsonDecode(boxOfData.get("vpn") ?? '{}'));
  static set vpnInfoObj(VpnInfo value) => boxOfData.put("vpn", value);

  // Saving all VPN Servers details
  static List<VpnInfo> get vpnList {
    List<VpnInfo> tempVpnList = [];

    final dataVpn = jsonDecode(boxOfData.get("vpnList") ?? '[]');
    for (var data in dataVpn) {
      tempVpnList.add(VpnInfo.fromJSON(data));
    }
    return tempVpnList;
  }

  static set vpnList(List<VpnInfo> valueList) =>
      boxOfData.put("vpnList", jsonEncode(valueList));
}
