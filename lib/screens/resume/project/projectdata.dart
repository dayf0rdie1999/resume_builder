import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/loading/loading.dart';
import 'package:resume_builder/screens/resume/project/project.dart';
import 'package:resume_builder/services/storeservice.dart';


class StreamProjectData extends StatelessWidget {

  final ResumeUser user;

  final bool isPhone;

  const StreamProjectData({Key? key, required this.user, required this.isPhone}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoreService().getProjects(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return Text("Something went wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return Project(user: user,snapshot: snapshot,isPhone: isPhone,);
      }
    );
  }
}
