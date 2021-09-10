import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/education/education.dart';
import 'package:resume_builder/screens/resume/education/educationdata.dart';
import 'package:resume_builder/screens/resume/profile/profile.dart';
import 'package:resume_builder/screens/resume/project/projectdata.dart';
import 'package:resume_builder/screens/resume/work/workdata.dart';


class ResumeTabletScreenWrapperUI extends StatelessWidget {
  final ResumeUser user;
  final String widgetName;
  const ResumeTabletScreenWrapperUI({Key? key, required this.widgetName, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (widgetName == "Profile") {
      return Profile(user: user,);
    } else if (widgetName == "Education") {
      return FutureEducationData(user: user,);
    } else if (widgetName == "Project") {
      return StreamProjectData(user: user,);
    } else {
      return WorkData(user: user);
    }

  }
}
