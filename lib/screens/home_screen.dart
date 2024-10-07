import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/preferences/app_preferences.dart';
import 'package:vpn_basic_project/preferences/app_screenSize.dart';
import 'package:vpn_basic_project/screens/available_vpn_servers_location.dart';
import 'package:vpn_basic_project/screens/connected_network_ip_info_screen.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';
import 'package:vpn_basic_project/widgets/custom_widget.dart';
import 'package:vpn_basic_project/widgets/timer_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());

  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(
              () => AvailableVpnServersLocationScreen(),
            );
          },
          child: Container(
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(
              horizontal: AppScreensize.getScreenWidth(context) * .04,
            ),
            height: 62,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Select Country / Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vpnRoundButton(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          // vpn button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                homeController.connectToVpnNow();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withOpacity(.1),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        homeController.getRoundVpnButtonColor.withOpacity(.3),
                  ),
                  child: Container(
                    height: AppScreensize.getScreenHeight(context) * .14,
                    width: AppScreensize.getScreenHeight(context) * .14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.getRoundVpnButtonColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          homeController.getRoundVpnButtonText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // status of connection
          Container(
            margin: EdgeInsets.only(
              top: AppScreensize.getScreenHeight(context) * .015,
              bottom: AppScreensize.getScreenHeight(context) * .02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              homeController.vpnConnectionState.value ==
                      VpnEngine.vpnDisconnectedNow
                  ? "Not Connected"
                  : homeController.vpnConnectionState
                      .replaceAll("_", " ")
                      .toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),

          // timer
          Obx(
            () => TimerWidget(
              initTimerNow: homeController.vpnConnectionState.value ==
                  VpnEngine.vpnConnectedNow,
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen(
      (event) {
        homeController.vpnConnectionState.value = event;
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Free VPN"),
        leading: IconButton(
          onPressed: () {
            Get.to(() => ConnectedNetworkIpInfoScreen());
          },
          icon: Icon(Icons.perm_device_info),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark);
              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: Icon(Icons.brightness_2_outlined),
          ),
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Location + Ping
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    titleText:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? "Location"
                            : homeController.vpnInfo.value.countryLongName,
                    subTitleText: "FREE",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.redAccent,
                      child:
                          homeController.vpnInfo.value.countryLongName.isEmpty
                              ? Icon(
                                  Icons.flag_circle,
                                  size: 30,
                                  color: Colors.white,
                                )
                              : null,
                      backgroundImage:
                          homeController.vpnInfo.value.countryLongName.isEmpty
                              ? null
                              : AssetImage(
                                  "assets/countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png",
                                ),
                    ),
                  ),
                  CustomWidget(
                    titleText:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? "60 ms"
                            : "${homeController.vpnInfo.value.ping} ms",
                    subTitleText: "PING",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.graphic_eq,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Button for vpn
          vpnRoundButton(context),

          // Download + Upload

          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    titleText: '${snapshot.data?.byteIn ?? '0 kbps'}',
                    subTitleText: "DOWNLOAD",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.arrow_circle_down,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomWidget(
                    titleText: '${snapshot.data?.byteOut ?? '0 kbps'}',
                    subTitleText: "UPLOAD",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
