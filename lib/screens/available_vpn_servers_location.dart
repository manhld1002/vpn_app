import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/vpn_location_controller.dart';
import 'package:vpn_basic_project/widgets/vpn_location_card_widget.dart';

class AvailableVpnServersLocationScreen extends StatelessWidget {
  AvailableVpnServersLocationScreen({super.key});

  final vpnLocationController = VpnLocationController();

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnFreeServersAvailableList.isEmpty) {
      vpnLocationController.retrieveVpnInformation();
    }
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "VPN Locations (" +
                vpnLocationController.vpnFreeServersAvailableList.length
                    .toString() +
                ")",
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: () {
              vpnLocationController.retrieveVpnInformation();
            },
            child: Icon(
              CupertinoIcons.refresh_circled,
              size: 40,
            ),
          ),
        ),
        body: vpnLocationController.isLoadingNewLocations.value
            ? loadingUIWidget()
            : vpnLocationController.vpnFreeServersAvailableList.isEmpty
                ? npVpnServerFoundUIWidget()
                : vpnAvailableServersData(),
      ),
    );
  }

  Widget loadingUIWidget() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Gathering Free VPN Locations...",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget npVpnServerFoundUIWidget() {
    return Center(
      child: Text(
        "No VPNs found, try again",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget vpnAvailableServersData() {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServersAvailableList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index) {
        return VpnLocationCardWidget(
          vpnInfo: vpnLocationController.vpnFreeServersAvailableList[index],
        );
      },
    );
  }
}
