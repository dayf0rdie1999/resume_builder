import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/navigation.dart';
import 'package:resume_builder/screens/resume/project/projectdata.dart';

class ProjectCategoriesUI extends StatelessWidget {

  final ResumeUser user;

  final bool isPhone;

  const ProjectCategoriesUI({Key? key, required this.user,required this.isPhone}) : super(key: key);

  final int pageIndex = 1;

  @override
  Widget build(BuildContext context) {

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: isPhone ? ResumeAppBar(
        title: "Select Project Type",
        appBar: AppBar(), user: user,
      ): null,
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StreamProjectData(user: user, isPhone: isPhone, type: "Aerospace",))
                      );
                    },
                  child: Container(
                    height: 240.0,
                    width: 240.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/aircraft.jpg'),
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Aerospace",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ),
              ),
              SizedBox(height: 40.0,),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StreamProjectData(user: user, isPhone: isPhone, type: "Software",))
                  );
                },
                child: Card(
                  child: Container(
                    height: 240.0,
                    width: 240.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/wop_tracker.jpg'),
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Software",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: isPhone ? ResumeNavigation(user: user,selectedIndex: pageIndex,) : null,
    );
  }
}
