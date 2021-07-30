import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/loading/loading.dart';
import 'package:resume_builder/screens/resume/education/education.dart';
import 'package:resume_builder/services/storeservice.dart';


class FutureEducationData extends StatelessWidget {

  final ResumeUser user;

  const FutureEducationData({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StoreService().getAdminEducation(),
      builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>?> snapshot) {
        if (snapshot.hasData) {
          return Education(user: user,educationData: snapshot.data,);
        } else if (snapshot.hasError) {
          return Text("Something Wrong");
        }
        return Loading();
      }
    );
  }
}
