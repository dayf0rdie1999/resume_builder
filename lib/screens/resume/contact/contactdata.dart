import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/loading/loading.dart';
import 'package:resume_builder/screens/resume/contact/contact.dart';
import 'package:resume_builder/services/storeservice.dart';


class ContactData extends StatefulWidget {

  final ResumeUser user;


  const ContactData({Key? key, required this.user}) : super(key: key);

  @override
  _ContactDataState createState() => _ContactDataState();
}

class _ContactDataState extends State<ContactData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoreService().getContactMessages(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return Text("Unable to retrieve data");
        }

        if ( snapshot.connectionState == ConnectionState.active) {
          return Contact(user: widget.user,snapshot: snapshot,);
        }

        return Loading();
      }
    );
  }
}
