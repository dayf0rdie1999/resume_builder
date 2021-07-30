import 'package:flutter/material.dart';
import 'package:resume_builder/module/Contact.dart';
import 'package:resume_builder/screens/resume/contact/partials/header.dart';
import 'package:resume_builder/services/storeservice.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final _contactFormkey = GlobalKey<FormState>();

  // Todo: Creating a value controller
  final _companyNameFormController = TextEditingController();
  final _companyLinkFormController = TextEditingController();
  final _companyContextFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(64.0),
            elevation: 2.0,
            child: Form(
              key: _contactFormkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(),
                        labelText: "Enter Your Company Name",
                      ),
                      controller: _companyNameFormController,
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return "Text Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Header(header: "Company Link",),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(),
                        labelText: "Enter Company Link",
                      ),
                      controller: _companyLinkFormController,
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return null;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Header(header: "Content",),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(),
                      ),
                      controller: _companyContextFormController,
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return "Text Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {

                                // Validating the input text form
                                if(_contactFormkey.currentState!.validate()){

                                  // Creating an Contact object
                                  ContactInfo contact = ContactInfo(company: _companyNameFormController.text,companyLink: _companyLinkFormController.text,message: _companyContextFormController.text);

                                  // Creating an object and store the value
                                  String? result = await StoreService().addContactMessage(contact);

                                  if (result != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }

                              },
                              child: Text("Submit"),
                            ),
                          ),
                          SizedBox(width: 16.0,),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {

                                _companyContextFormController.clear();
                                _companyLinkFormController.clear();
                                _companyNameFormController.clear();

                                Navigator.pop(context);

                              },
                              child: Text("Discard"),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
