import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import 'package:vpn_basic_project/models/ip_info.dart';
import 'package:vpn_basic_project/models/network_ip_info.dart';
import 'package:vpn_basic_project/widgets/network_ip_info_widget.dart';

class ConnectedNetworkIpInfoScreen extends StatelessWidget {
  const ConnectedNetworkIpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipInfo = IPInfor.fromJson({}).obs;
    ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Connected Network IP Information",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            ipInfo.value = IPInfor.fromJson({});
            ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
          },
          child: Icon(
            CupertinoIcons.refresh_circled,
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(3),
        children: [
          // Ip Address
          Obx(
            () => NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "IP Address",
                subtitleText: ipInfo.value.query,
                iconData: Icon(
                  Icons.my_location_outlined,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),

          // isp
          Obx(
            () => NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Internet Service Provider",
                subtitleText: ipInfo.value.internetServiceProvider,
                iconData: Icon(
                  Icons.account_tree,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),

          // Location
          Obx(
            () => NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Location",
                subtitleText: ipInfo.value.countryName.isEmpty
                    ? "Retrieving..."
                    : "${ipInfo.value.regionName}, ${ipInfo.value.countryName}",
                iconData: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),

          // Zip code
          Obx(
            () => NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Pin code",
                subtitleText: ipInfo.value.zipCode,
                iconData: Icon(
                  CupertinoIcons.map_pin_ellipse,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
          ),

          // Time zone
          Obx(
            () => NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Timezone",
                subtitleText: ipInfo.value.timezone,
                iconData: Icon(
                  Icons.share_arrival_time_outlined,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
