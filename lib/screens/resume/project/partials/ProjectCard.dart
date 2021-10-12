import 'package:flutter/material.dart';
import 'package:resume_builder/module/project.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/project/detailproject.dart';
import 'package:resume_builder/screens/resume/project/partials/projectdropdownmenu.dart';


class ProjectCard extends StatelessWidget {

  final String docId;
  final Map<String,dynamic> data;
  final ResumeUser user;

  const ProjectCard({Key? key,required this.docId,required this.user,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProjectModule project = ProjectModule(title: data["title"],projectSkills: data["projectSkills"] as List<dynamic>,position: data["position"],mainPoints:  data["mainPoints"] as List<dynamic>, type: data["Type"]);

    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                project.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 4.0,),
            Expanded(
              flex: 0,
              child: Text(
                "(${project.position})",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text("Skills Required: ${project.projectSkills.join(", ")}"),
        trailing: user.admin ? ProjectDropDown(docId: docId,selectedProject: project, user: user,) : null,
        isThreeLine: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailProject(selectedProject: project, user: user,)),
          );
        },
      ),
    );
  }
}