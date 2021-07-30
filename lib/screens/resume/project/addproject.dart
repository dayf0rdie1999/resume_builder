import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:resume_builder/module/project.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/services/storeservice.dart';


class AddProject extends StatefulWidget {

  final ResumeUser user;

  const AddProject({Key? key,required this.user}) : super(key: key);

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {

  // Todo: Creating all the necessary form key
  final _titleAndPositionFormKey = GlobalKey<FormState>();
  final _projectSkillsFormKey = GlobalKey<FormState>();
  final _projectMainPointsFormKey = GlobalKey<FormState>();

  // Todo: Creating TextEditing Controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _projectSkillsController = TextEditingController();
  final TextEditingController _projectMainPointsController = TextEditingController();

  // Todo: Creating two lists to add data
  final List<String> skillsList = [];
  final List<String> mainPointsList = [];

  // Todo: Initiate StoreService class
  final StoreService _storeService = StoreService();


  @override
  Widget build(BuildContext context) {

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ResumeAppBar(
        user: widget.user,
        title: "Add Project",
        appBar: AppBar(),
      ),
      body:SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Column(
                children: <Widget>[
                  Form(
                    key: _titleAndPositionFormKey,
                    child: Column(
                      children: <Widget>[Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                          child: TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Project Title",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter some text";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                            child: TextFormField(
                              controller: _positionController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter Your Position"
                              ),
                              validator: (value) {
                                if (value == null && value!.isEmpty) {
                                  return "Please enter your position in the project";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),],
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    height: 32.0,
                    color: Colors.blue,
                  ),
                  Form(
                    key: _projectSkillsFormKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                    labelText: "Add Required Project Skills",
                                  ),
                                  controller: _projectSkillsController,
                                  validator: (value) {
                                    if (value == null && value!.isEmpty) {
                                      return "Don't leave empty if you click on me";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  if (_projectSkillsFormKey.currentState!.validate()) {
                                    setState(() {
                                      skillsList.add(_projectSkillsController.text);
                                      _projectSkillsController.clear();
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 36.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Todo: Creating a listview to display each added skills to the widget
                  Container(
                    height: 64.0,
                    child: skillsList.isEmpty ? Center(child: Text("Waiting to add Skills..."),) : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: skillsList.length,
                      itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: InputChip(
                            backgroundColor:  Colors.blue[200],
                            avatar: CircleAvatar(
                              backgroundColor: Colors.blue[400],
                              child: Text(
                                skillsList[index][0],
                                style: TextStyle(
                                  color: Colors.blue[900],
                                ),
                              ),
                            ),
                            label: Text(
                                skillsList[index],
                              style: TextStyle(
                                  color: Colors.blue[900],
                              ),
                            ),
                            deleteIcon: Icon(
                              Icons.remove_circle,
                              color: Colors.indigo[900],
                            ),
                            onDeleted: () {
                              setState(() {
                                skillsList.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    height: 32.0,
                    color: Colors.blue,
                  ),
                  Form(
                    key: _projectMainPointsFormKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                    labelText: "Add Project Main Points",
                                  ),
                                  controller: _projectMainPointsController,
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value == null && value!.isEmpty) {
                                      return "Don't leave empty if you click on me";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  if (_projectMainPointsFormKey.currentState!.validate()) {
                                    setState(() {
                                      mainPointsList.add(_projectMainPointsController.text);
                                      _projectMainPointsController.clear();
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 36.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 100.0,
                      child: mainPointsList.isEmpty ? Center(child: Text("Waiting to add main points..."),) :
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: mainPointsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        mainPointsList[index],
                                        maxLines: 5,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                          mainPointsList.removeAt(index);
                                        });
                                      },
                                      icon: Icon(Icons.remove_circle),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Todo: Checking if all the input requirement are filled
                              if (_titleAndPositionFormKey.currentState!.validate() && skillsList.isNotEmpty && mainPointsList.isNotEmpty) {
                                // Todo: Initiate the projectModule Class
                                ProjectModule _project = ProjectModule(title: _titleController.text,position: _positionController.text,projectSkills: skillsList,mainPoints: mainPointsList);

                                // Todo: Adding data to the firestore through ProjectModule Class
                                String? result = await _storeService.addProject(_project);

                                // Todo: Navigate back to the project through pop if successful store them
                                if (result != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can't Add Project")));
                                } else {
                                  Navigator.pop(context);
                                }
                              }
                          },
                          child: Text("Add Project"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
