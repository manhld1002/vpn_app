import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/models/ip_info.dart';
import 'package:vpn_basic_project/models/vpn_info.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/preferences/app_preferences.dart';

class ApiVpnGate {
  static Future<List<VpnInfo>> retrieveAllAvailableFreeVpnServers() async {
    final List<VpnInfo> vpnServersList = [];

    try {
      final result =
          await http.get(Uri.parse("https://www.vpngate.net/api/iphone/"));
      // Get the second element of the List String, then replace * = null, means delete *
      final seperatedResult = result.body.split("#")[1].replaceAll("*", "");
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(seperatedResult);
      final header = listData[0];

      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};

        for (int innerCounter = 0;
            innerCounter < header.length;
            innerCounter++) {
          jsonData.addAll({
            header[innerCounter].toString(): listData[counter][innerCounter]
          });
        }
        vpnServersList.add(VpnInfo.fromJSON(jsonData));
      }
    } catch (e) {
      Get.snackbar(
        "Error Occured",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.8),
      );
    }
    vpnServersList.shuffle();

    // Hive storage : Local Storage
    if (vpnServersList.isNotEmpty) AppPreferences.vpnList = vpnServersList;
    return vpnServersList;
  }

  static Future<void> retrieveIPDetails(
      {required Rx<IPInfor> ipInformation}) async {
    try {
      final respone = await http.get(Uri.parse('http://ip-api.com/json/'));
      final dataFromApi = jsonDecode(respone.body);

      ipInformation.value = IPInfor.fromJson(dataFromApi);
    } catch (e) {
      Get.snackbar(
        "Error Occured",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.8),
      );
    }
  }
}
