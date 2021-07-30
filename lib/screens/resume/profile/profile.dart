
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/profile/partials/profilewidget.dart';
import 'package:resume_builder/services/storeservice.dart';


class Profile extends StatefulWidget {

  final ResumeUser user;

  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final StoreService _storeService = StoreService();

  final int pageIndex = 0;

  @override
  Widget build(BuildContext context) {


    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return ProfileWidget(bottom: bottom, widget: widget, pageIndex: pageIndex, user: widget.user,);

  }
}








