import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/navigation.dart';
import 'package:resume_builder/screens/resume/project/addproject.dart';
import 'package:resume_builder/screens/resume/project/partials/ProjectCard.dart';

class Project extends StatefulWidget {

  final ResumeUser user;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final bool isPhone;
  const Project({Key? key, required this.user, required this.snapshot, required this.isPhone}) : super(key: key);

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {

  final parser = EmojiParser();

  final int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResumeAppBar(
        user: widget.user,
        title: "Project Experience ${parser.getName('clipboard').code}",
        appBar: AppBar(),
      ),
      body: ListView(
        children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String,dynamic> data = document.data() as Map<String,dynamic>;

          return ProjectCard(data: data,user: widget.user,docId: document.id,);

        }).toList(),
      ),
      floatingActionButton: widget.user.admin ? FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProject(user: widget.user,)),
          );
        },
        child: Icon(Icons.add),
      ) : null,
      bottomNavigationBar: widget.isPhone ? ResumeNavigation(user: widget.user,selectedIndex: pageIndex,) : null,
    );
  }
}





