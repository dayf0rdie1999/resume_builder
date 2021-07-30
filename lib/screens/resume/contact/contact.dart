import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/module/Contact.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/contact/contactForm.dart';
import 'package:resume_builder/screens/resume/contact/contactdetail.dart';
import 'package:resume_builder/screens/resume/contact/partials/header.dart';
import 'package:resume_builder/services/storeservice.dart';

class Contact extends StatefulWidget {

  final ResumeUser user;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  const Contact({Key? key, required this.user, required this.snapshot}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ResumeAppBar(
        user: widget.user,
        title: "Contact",
        appBar: AppBar(),
      ),
      body: widget.user.admin ? ListView(
        children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String,dynamic> data = document.data() as Map<String,dynamic>;
          ContactInfo contact = ContactInfo(company: data["companyName"],companyLink: data["companyLink"],message: data["message"]);

          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactDetail(user: widget.user,contact: contact,)),
                );
              },
              title: Text(contact.company),
              subtitle: (contact.companyLink! == "") ? Text("No Link To Connect") : Text(contact.companyLink!),
              trailing: IconButton(
                onPressed: () async {

                  String? result = await StoreService().deleteContact(document.id);

                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully delete the message")));
                  }

                },
                icon: Icon(Icons.remove_circle),
              ),
            ),
          );
        }).toList(),
      ) : ContactForm(),
    );
  }
}


