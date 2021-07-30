import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/module/work.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/navigation.dart';
import 'package:resume_builder/screens/resume/work/partials/workdropdownmenu.dart';
import 'package:resume_builder/screens/resume/work/workdetail.dart';
import 'package:resume_builder/screens/resume/work/workadd.dart';

class Work extends StatefulWidget {

  final ResumeUser user;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  const Work({Key? key, required this.user, required this.snapshot}) : super(key: key);

  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {

  final parser = EmojiParser();

  // Todo:
  final int pageIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResumeAppBar(
        user: widget.user,
        title: "Work Experience ${parser.getName('briefcase').code}",
        appBar: AppBar(),
      ),
      body: ListView(
        children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String,dynamic> data = document.data() as Map<String,dynamic>;

          // Todo: Initiating the WorkModule object
          WorkModule workData = WorkModule(workId: document.id,companyName: data["companyName"],position: data["position"]
              ,location: data["location"],fromDate: data["fromDate"],toDate: data["toDate"],mainPoints: data["mainPoints"]);

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkDetail(selectedWork: workData,user: widget.user,)),
                  );
                },
                isThreeLine: true,
                title: Row(
                  children: <Widget>[
                    Text(
                      workData.companyName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Position: ${workData.position}"),
                    Text("Location: ${workData.location}"),
                    Text("Time: ${workData.fromDate} - ${workData.toDate}")
                  ],
                ),
                trailing: widget.user.admin ? WorkDropDownMenu(selectedWork: workData,user: widget.user,) : null,
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: widget.user.admin ? FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddWork(user: widget.user,))
          );
        },
        child: Icon(Icons.add_circle_outline),
      ) : null,
      bottomNavigationBar: ResumeNavigation(user: widget.user,selectedIndex: pageIndex,),
    );
  }
}
