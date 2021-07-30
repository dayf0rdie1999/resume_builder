import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/contact/contact.dart';
import 'package:resume_builder/screens/resume/contact/contactdata.dart';

class ResumeAppBar extends StatelessWidget implements PreferredSizeWidget {

  final AppBar appBar;
  final String title;
  final ResumeUser user;

  const ResumeAppBar({Key? key, required this.appBar, required this.title, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: <Widget>[

        IconButton(
          onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactData(user: user,)),
            );

          },
          icon: Icon(Icons.email),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

