import 'package:flutter/material.dart';
import 'package:vpn_basic_project/preferences/app_screenSize.dart';

class CustomWidget extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Widget roundWidgetWithIcon;
  const CustomWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.roundWidgetWithIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppScreensize.getScreenWidth(context) * .45,
      child: Column(
        children: [
          roundWidgetWithIcon,
          const SizedBox(
            height: 7,
          ),
          Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            subTitleText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
