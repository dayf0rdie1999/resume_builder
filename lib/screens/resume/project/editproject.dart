import 'package:flutter/material.dart';
import 'package:resume_builder/module/project.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/services/storeservice.dart';

class EditProject extends StatefulWidget {

  final ProjectModule selectedProject;
  final String docId;
  final ResumeUser user;

  const EditProject({Key? key, required this.selectedProject,required this.docId, required this.user}) : super(key: key);

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {


  // Todo: Creating all the controller
  final _positionController = TextEditingController();
  final  _projectMainPointsController = TextEditingController();
  final _titleController = TextEditingController();
  final _projectSkillsController = TextEditingController();
  final _projectTypeController = TextEditingController();



  // Todo: Creating all the form keys
  final _titleAndPositionFormKey = GlobalKey<FormState>();
  final _projectSkillsFormKey = GlobalKey<FormState>();
  final _projectMainPointsFormKey = GlobalKey<FormState>();
  final _projectTypeFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    _titleController.text = widget.selectedProject.title;
    _positionController.text = widget.selectedProject.position;
    _projectTypeController.text = widget.selectedProject.type;
    // TODO: implement initState
    super.initState();
  }

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
                        onChanged: (value) {
                          setState(() {
                            widget.selectedProject.title = value;
                          });
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
                          onChanged: (value) {
                            setState(() {
                              widget.selectedProject.position = value;
                            });
                          },
                        ),
                      ),
                    ),],
                ),
              ),
              // Todo: Adding TextFormField to input type of projects
              Form(
                key: _projectTypeFormKey,
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        labelText: "Add Project Type*",
                      ),
                      controller: _projectTypeController,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return "Required Project Type";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          widget.selectedProject.type = value;
                        });
                      },
                    ),
                  ),
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
                                  widget.selectedProject.projectSkills.add(_projectSkillsController.text);
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
                child: widget.selectedProject.projectSkills.isEmpty ? Center(child: Text("Waiting to add Skills..."),) : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.selectedProject.projectSkills.length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: InputChip(
                        backgroundColor:  Colors.blue[200],
                        avatar: CircleAvatar(
                          backgroundColor: Colors.blue[400],
                          child: Text(
                            widget.selectedProject.projectSkills[index][0],
                            style: TextStyle(
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                        label: Text(
                          widget.selectedProject.projectSkills[index],
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
                            widget.selectedProject.projectSkills.removeAt(index);
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
                                  widget.selectedProject.mainPoints.add(_projectMainPointsController.text);
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
                // Todo: Checking if the ModuleProject mainpoints list is empty or not
                child: widget.selectedProject.mainPoints.isEmpty ? Center(child: Text("Waiting to add main points..."),) :
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  // Todo: Passing the length of the ModuleProject mainpoints list
                  itemCount: widget.selectedProject.mainPoints.length,
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
                                  // Todo: Passing the ProjectModule object MainPoints data
                                  widget.selectedProject.mainPoints[index],
                                  maxLines: 5,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    // Removing the object directly in the object
                                    widget.selectedProject.mainPoints.removeAt(index);
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
                          // Todo: Checking if all the forms are filled and the list is not empty
                          if (_titleAndPositionFormKey.currentState!.validate() && widget.selectedProject.projectSkills.isNotEmpty && widget.selectedProject.mainPoints.isNotEmpty) {

                            // Todo: Update the data to the database
                            String? result = await StoreService().updateProject(widget.docId, widget.selectedProject);
                            // Todo: Response to the result that it sends back
                           if (result != null) {
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                           } else {
                             Navigator.pop(context);
                           }
                          }
                        },
                        child: Text("Update"),
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
