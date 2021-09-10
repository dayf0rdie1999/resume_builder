import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/loading/loading.dart';
import 'package:resume_builder/screens/resume/education/education.dart';
import 'package:resume_builder/services/storeservice.dart';


class FutureEducationData extends StatefulWidget {

  final ResumeUser user;

  const FutureEducationData({Key? key,required this.user}) : super(key: key);

  @override
  _FutureEducationDataState createState() => _FutureEducationDataState();
}

class _FutureEducationDataState extends State<FutureEducationData> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StoreService().getAdminEducation(),
      builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>?> snapshot) {
        if (snapshot.hasData) {
          return Education(user: widget.user,educationData: snapshot.data,);
        } else if (snapshot.hasError) {
          return Text("Something Wrong");
        }
        return Loading();
      }
    );
  }
}
