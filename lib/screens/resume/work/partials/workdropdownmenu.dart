import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/module/work.dart';
import 'package:resume_builder/screens/resume/work/workedit.dart';
import 'package:resume_builder/services/storeservice.dart';


class WorkDropDownMenu extends StatefulWidget {

  final WorkModule  selectedWork;
  final ResumeUser user;

  const WorkDropDownMenu({Key? key, required this.selectedWork, required this.user }) : super(key: key);

  @override
  _WorkDropDownMenuState createState() => _WorkDropDownMenuState();
}

class _WorkDropDownMenuState extends State<WorkDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      enabled: true,
      onSelected: (value) async {
        if (value == "Edit") {

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkEdit(selectedWork: widget.selectedWork,user: widget.user,)),
          );

        } else if (value == "Delete") {
          String? result = await StoreService().deleteWork(widget.selectedWork);

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
    );;
  }
}
