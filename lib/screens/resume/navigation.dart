import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/education/educationdata.dart';
import 'package:resume_builder/screens/resume/profile/profile.dart';
import 'package:resume_builder/screens/resume/project/project.dart';
import 'package:resume_builder/screens/resume/project/project_categories.dart';
import 'package:resume_builder/screens/resume/project/projectdata.dart';
import 'package:resume_builder/screens/resume/work/work.dart';
import 'package:resume_builder/screens/resume/work/workdata.dart';

class ResumeNavigation extends StatefulWidget {

  final ResumeUser user;
  late int selectedIndex;
  ResumeNavigation({Key? key, required this.user, required this.selectedIndex}) : super(key: key);

  @override
  _ResumeNavigationState createState() => _ResumeNavigationState();
}

class _ResumeNavigationState extends State<ResumeNavigation> {


  _onItemTapped(int index) {
     if (index == 0 && widget.selectedIndex != index) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => FutureEducationData(user: widget.user, isPhone: true))
      );
    } else if (index == 1 && widget.selectedIndex != index) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ProjectCategoriesUI(user: widget.user,isPhone: true))
      );
    } else if (index == 2 && widget.selectedIndex != index) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WorkData(user: widget.user,isPhone: true,))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Education',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.design_services),
          label: 'Project',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Jobs',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
