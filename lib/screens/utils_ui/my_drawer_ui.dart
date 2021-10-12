import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {

  final Function(String) updateWidget;

  final String currentWidget;

  const MyDrawer({Key? key, required this.updateWidget, required this.currentWidget}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: const DecorationImage(
                          image: AssetImage('assets/me.jpg'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                      width: 64.0,
                      height: 64.0,
                    ),
                    SizedBox(height: 8.0,),
                    Text(
                      "Email: paulduonganh@gmail.com",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Welcome to my resume",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
          ),
          InkWell(
            onTap: (widget.currentWidget == "CheckAdmin") ? null :() {
              widget.updateWidget("Education");
            },
            child: ListTile(
              title: Text(
                "Education",
                style: TextStyle(
                    color: (widget.currentWidget == "CheckAdmin") ? Colors.grey : Colors.black
                ),
              ),
              trailing: Icon(
                Icons.school,
                color: (widget.currentWidget == "CheckAdmin") ? Colors.grey : Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: (widget.currentWidget == "CheckAdmin") ? null : () {
              widget.updateWidget("Project");
            },
            child: ListTile(
              title: Text(
                "Project",
                style: TextStyle(
                    color: (widget.currentWidget == "CheckAdmin") ? Colors.grey : Colors.black
                ),
              ),
              trailing: Icon(
                Icons.design_services,
                color: (widget.currentWidget == "CheckAdmin") ? Colors.grey: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: (widget.currentWidget == "CheckAdmin") ? null : () {
              widget.updateWidget("Jobs");
            },
            child: ListTile(
              title: Text(
                "Jobs",
                style: TextStyle(
                  color: (widget.currentWidget == "CheckAdmin") ? Colors.grey : Colors.black
                ),
              ),
              trailing: Icon(
                Icons.work,
                color: (widget.currentWidget == "CheckAdmin") ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
