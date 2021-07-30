import 'package:flutter/material.dart';
import 'package:resume_builder/module/Contact.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/contact/partials/header.dart';

class ContactDetail extends StatelessWidget {

  final ResumeUser user;
  final ContactInfo contact;

  const ContactDetail({Key? key, required this.user, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResumeAppBar(
        user:  user,
        title: "Contact Detail",
        appBar: AppBar(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Header(header: "Company Name",),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Text(
                contact.company,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[600],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Header(header: "Company Link",),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Text(
                (contact.companyLink! == "") ? "No Link To Connect" : contact.companyLink!,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[600],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Header(header: "Message",),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          contact.message,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue[600],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
