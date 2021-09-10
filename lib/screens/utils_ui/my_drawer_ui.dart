import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {

  final Function(String) updateWidget;

  const MyDrawer({Key? key, required this.updateWidget}) : super(key: key);

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
            onTap: () {
              widget.updateWidget("Profile");
            },
            child: ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.account_box),
            ),
          ),
          InkWell(
            onTap: () {
              widget.updateWidget("Education");
            },
            child: ListTile(
              title: Text("Education"),
              trailing: Icon(Icons.school),
            ),
          ),
          InkWell(
            onTap: () {
              widget.updateWidget("Project");
            },
            child: ListTile(
              title: Text("Project"),
              trailing: Icon(Icons.design_services),
            ),
          ),
          InkWell(
            onTap: () {
              widget.updateWidget("Jobs");
            },
            child: ListTile(
              title: Text("Jobs"),
              trailing: Icon(Icons.work),
            ),
          ),
        ],
      ),
    );
  }
}
