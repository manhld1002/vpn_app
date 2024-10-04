import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/preferences/app_preferences.dart';
import 'package:vpn_basic_project/preferences/app_screenSize.dart';
import 'package:vpn_basic_project/widgets/custom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {},
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

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Container(
                  height: AppScreensize.getScreenHeight(context) * .14,
                  width: AppScreensize.getScreenWidth(context) * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
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
                        "Tap to connect",
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Free VPN"),
        leading: IconButton(
          onPressed: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "Location",
                subTitleText: "FREE",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.redAccent,
                  child: Icon(
                    Icons.flag_circle,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomWidget(
                titleText: "60 ms",
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
          ),

          // Button for vpn
          vpnRoundButton(),

          // Download + Upload
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "0 kbps",
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
                titleText: "0 kbps",
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
          )
        ],
      ),
    );
  }
}
