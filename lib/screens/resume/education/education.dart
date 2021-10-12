import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/navigation.dart';
import 'package:resume_builder/services/storeservice.dart';


class Education extends StatefulWidget {

  final ResumeUser user;

  final Map<String,dynamic>? educationData;

  final bool isPhone;

  const Education({Key? key,this.educationData, required this.user, required this.isPhone}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {

  final parser = EmojiParser();

  final int pageIndex = 0;

  late bool editMode = false;

  final _EditGPAFormKey = GlobalKey<FormState>();

  final TextEditingController _EditGPAController = TextEditingController();


  Future<void> _editCGPADialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: Text("Update Cumulative Grade Point Average"),
          content: Form(
            key: _EditGPAFormKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _EditGPAController,
              decoration: InputDecoration(
                hintText: "Enter Current CGPA",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_EditGPAFormKey.currentState!.validate() && double.parse(_EditGPAController.text) < 4.0 && double.parse(_EditGPAController.text) > 0.0) {
                  setState(() {


                    // Todo: Updating the GPA in the firestore database
                    StoreService().updateData("adminEducation", "Bachelor", "CGPA", _EditGPAController.text);


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Updating the data")));

                    _EditGPAController.clear();

                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GPA is only valid between 0.0 and 4.0")));
                }
              },
              child: Text("Submit")
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Text("Cancel")
            ),
          ],
        );
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.isPhone ? ResumeAppBar(
        user: widget.user,
        title: "Education ${parser.getName('mortar_board').code}",
        appBar: AppBar(),
      ) : null,
      body: Card(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Embry-Riddle Aeronautical University",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    SizedBox(width: 32.0),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Daytona Beach, FL",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                title: Text(
                  "${widget.educationData?["Major"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Area of Concentration: ${widget.educationData?["Area of Concentration"]}"),
                    Text("Minor: ${widget.educationData?["Minor"]}"),
                  ],
                ),
                trailing: Text(
                    "CGPA: ${widget.educationData?["CGPA"]}/4.00",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                isThreeLine: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Graduation Date:",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "${widget.educationData?["Graduation Date"]}",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${parser.getName('fireworks').code}${parser.getName('fireworks').code}${parser.getName('fireworks').code}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.user.admin ? FloatingActionButton(
        onPressed: () {
          _editCGPADialog(context);
        },
        child: Icon(Icons.edit),
      ) : null ,
      bottomNavigationBar: widget.isPhone ? ResumeNavigation(user: widget.user,selectedIndex: pageIndex,) : null,
    );
  }
}


