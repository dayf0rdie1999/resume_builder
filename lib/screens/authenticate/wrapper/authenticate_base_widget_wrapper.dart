import 'package:flutter/material.dart';
import 'package:resume_builder/enum/device_screen_type.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/authenticate/CheckAdmin.dart';
import 'package:resume_builder/screens/authenticate/check_admin_tablet.dart';
import 'package:resume_builder/screens/basewidget.dart';

class AuthenticateBaseWidgetWrapper extends StatelessWidget {

  final ResumeUser user;
  const AuthenticateBaseWidgetWrapper({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BaseWidget(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
            return CheckAdmin(user: user, isPhone: true);
          } else if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
            return CheckAdminTabletUI(user: user, isFromPhone: false);
          } else {
            return Text("Desktop Size UI");
          }
        }
    );
  }
}
