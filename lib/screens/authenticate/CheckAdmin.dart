import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:resume_builder/enum/admin_status.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/authenticate/check_admin_tablet.dart';
import 'package:resume_builder/screens/resume/education/education.dart';
import 'package:resume_builder/screens/resume/education/educationdata.dart';
import 'package:resume_builder/screens/resume/profile/profile.dart';
import 'package:resume_builder/services/storeservice.dart';


class CheckAdmin extends StatefulWidget {

  final ResumeUser user;

  final bool isPhone;

  const CheckAdmin({Key? key, required this.user, required this.isPhone}) : super(key: key);

  @override
  _CheckAdminState createState() => _CheckAdminState();
}

class _CheckAdminState extends State<CheckAdmin> {

  final parser = EmojiParser();

  final _CheckAdminFormKey = GlobalKey<FormState>();

  final _AdminCodeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _AdminCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isPhone ? AppBar(
        title: Text("Are you Admin${parser.getName('question').code}"),
        centerTitle: true,
      ): null,
      body: Form(
        key: _CheckAdminFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 0.0),
              child: TextFormField(
                obscureText: true,
                controller: _AdminCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter The Admin Code'
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                     final Map? result = await StoreService().getAdminCode();

                     if (result?["result"] != null && result?["Error"] == null) {
                       if (_AdminCodeController.text == result!["result"]) {
                         widget.user.admin = true;
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(builder: (context) => (widget.isPhone) ? FutureEducationData(user: widget.user,isPhone: true) : CheckAdminTabletUI(user: widget.user, isFromPhone: true, status: AdminStatus.Admin,))
                         );
                       } else {
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect Admin Passcode")));
                       }

                     } else if ((result?["result"] != null && result?["Error"] == null)) {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${result![Error]}')));
                     }

                    },
                    child: Text("Submit")
                  ),
                  TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => (widget.isPhone) ? FutureEducationData(user: widget.user,isPhone: true) : CheckAdminTabletUI(user: widget.user, isFromPhone: true, status: AdminStatus.User,))
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16.0,
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
