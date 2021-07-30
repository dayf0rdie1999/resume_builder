import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/profile/partials/profilerowfield.dart';
import 'package:resume_builder/screens/resume/profile/profile.dart';

import '../../navigation.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.bottom,
    required this.widget,
    required this.pageIndex,
    required this.user,

  }) : super(key: key);

  final double bottom;
  final Profile widget;
  final int pageIndex;
  final ResumeUser user;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ResumeAppBar(
        user: user,
        title: "Profile",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Form(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 32.0,),
                  Container(
                    width: 128.0,
                    height: 128.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/me.jpg")
                        )
                    ),
                  ),
                  Divider(
                    height: 16.0,
                    thickness: 2.0,
                    indent: 32.0,
                    endIndent: 32.0,
                  ),
                  ProfileInputForm(user: widget.user,
                    heading: "Name",
                    docKey: "name",),
                  SizedBox(height: 32.0,),
                  ProfileInputForm(user: widget.user,
                    heading: "Email",
                    docKey: "email",),
                  SizedBox(height: 32.0,),
                  ProfileInputForm(user: widget.user,
                    heading: "Phone Number",
                    docKey: "phone",),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ResumeNavigation(
        user: widget.user, selectedIndex: pageIndex,),
    );
  }
}