import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/loading/loading.dart';
import 'package:resume_builder/screens/resume/work/work.dart';
import 'package:resume_builder/services/storeservice.dart';

class WorkData extends StatefulWidget {
  final ResumeUser user;
  const WorkData({Key? key, required this.user}) : super(key: key);

  @override
  _WorkDataState createState() => _WorkDataState();
}

class _WorkDataState extends State<WorkData> {

  final StoreService _storeService = StoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _storeService.getWork(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return Text("Unable to load the data");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return Work(user: widget.user,snapshot: snapshot,);
      }
    );
  }
}
