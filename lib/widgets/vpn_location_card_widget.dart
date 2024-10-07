import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn_info.dart';
import 'package:vpn_basic_project/preferences/app_preferences.dart';
import 'package:vpn_basic_project/preferences/app_screenSize.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';

class VpnLocationCardWidget extends StatelessWidget {
  final VpnInfo vpnInfo;
  const VpnLocationCardWidget({
    super.key,
    required this.vpnInfo,
  });

  String formatSpeedBytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return "0 B";
    }

    const suffixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];

    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();
    return "${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimals)} ${suffixesTitle[speedTitleIndex]}";
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
          vertical: AppScreensize.getScreenHeight(context) * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfo;
          AppPreferences.vpnInfoObj = vpnInfo;
          Get.back();

          if (homeController.vpnConnectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();

            Future.delayed(
                Duration(seconds: 3), () => homeController.connectToVpnNow());
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          // Country flag
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              "assets/countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 40,
              width: AppScreensize.getScreenWidth(context) * 0.15,
              fit: BoxFit.cover,
            ),
          ),

          // Country name
          title: Text(vpnInfo.countryLongName),

          // Vpn speed
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),

          // number of sessions
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionsNum.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).lightTextColor,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
