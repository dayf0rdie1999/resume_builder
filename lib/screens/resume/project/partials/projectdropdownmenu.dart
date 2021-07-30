import 'package:flutter/material.dart';
import 'package:resume_builder/module/project.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/project/editproject.dart';
import 'package:resume_builder/services/storeservice.dart';


class ProjectDropDown extends StatefulWidget {

  final String docId;
  final ProjectModule selectedProject;
  final ResumeUser user;

  const ProjectDropDown({Key? key,required this.docId,required this.selectedProject,required this.user}) : super(key: key);

  @override
  _ProjectDropDownState createState() => _ProjectDropDownState();
}

class _ProjectDropDownState extends State<ProjectDropDown> {


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      enabled: true,
      onSelected: (value) async {
        if (value == "Edit") {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProject(selectedProject: widget.selectedProject,docId: widget.docId,user: widget.user,))
          );
        } else if (value == "Delete") {
           String? result = await StoreService().deleteProject(widget.docId);

           if (result != null) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
           }
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Edit"),
          value: "Edit",
        ),
        PopupMenuItem(
          child: Text("Delete"),
          value: "Delete",
        ),
      ],
    );
  }
}
