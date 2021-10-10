import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/authenticate/CheckAdmin.dart';
import 'package:resume_builder/screens/resume/education/educationdata.dart';
import 'package:resume_builder/screens/resume/project/projectdata.dart';
import 'package:resume_builder/screens/resume/work/workdata.dart';


class ResumeTabletScreenWrapperUI extends StatelessWidget {
  final ResumeUser user;
  final String widgetName;
  const ResumeTabletScreenWrapperUI({Key? key, required this.widgetName, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (widgetName == "CheckAdmin") {
      return CheckAdmin(user: user,isPhone: false,);
    } else if (widgetName == "Education") {
      return FutureEducationData(user: user,isPhone: false,);
    } else if (widgetName == "Project") {
      return StreamProjectData(user: user,isPhone: false,);
    } else {
      return WorkData(user: user,isPhone: false,);
    }

  }
}
