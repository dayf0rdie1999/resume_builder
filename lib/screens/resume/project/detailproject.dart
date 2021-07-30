import 'package:flutter/material.dart';
import 'package:resume_builder/module/project.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/appbar.dart';

class DetailProject extends StatefulWidget {

  final ProjectModule selectedProject;
  final ResumeUser user;

  const DetailProject({Key? key, required this.selectedProject, required this.user}) : super(key: key);

  @override
  _DetailProjectState createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResumeAppBar(
        user: widget.user,
        title: widget.selectedProject.title,
        appBar: AppBar(),
      ),
      body: Column(

        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Position: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '${widget.selectedProject.position}', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          )),
                        ],
                      ),
                    ),
                  ),
                  elevation: 2.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Project Skills',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Divider(
                      color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 5,
              children: List.generate(widget.selectedProject.projectSkills.length, (index) {
                return InputChip(
                  tooltip: widget.selectedProject.projectSkills[index],
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue[600],
                    child: Text(widget.selectedProject.projectSkills[index][0]),
                  ),
                  backgroundColor: Colors.blue[200],
                  label: Text(
                    widget.selectedProject.projectSkills[index],
                    style: TextStyle(
                      color: Colors.blue[900]
                    ),
                  ),
                  onPressed: (){},
                );
              })
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Main Points',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedProject.mainPoints.length,
              itemBuilder: (context,index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(widget.selectedProject.mainPoints[index]),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}