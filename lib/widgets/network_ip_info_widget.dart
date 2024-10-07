import 'package:flutter/material.dart';
import 'package:vpn_basic_project/models/network_ip_info.dart';
import 'package:vpn_basic_project/preferences/app_screenSize.dart';

class NetworkIpInfoWidget extends StatelessWidget {
  final NetworkIpInfo networkIpInfo;
  const NetworkIpInfoWidget({
    super.key,
    required this.networkIpInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
        vertical: AppScreensize.getScreenHeight(context) * .01,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: Icon(
          networkIpInfo.iconData.icon,
          size: networkIpInfo.iconData.size ?? 28,
        ),
        title: Text(networkIpInfo.titleText),
        subtitle: Text(networkIpInfo.subtitleText),
      ),
    );
  }
}
