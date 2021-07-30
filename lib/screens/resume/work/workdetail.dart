import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/module/work.dart';
import 'package:resume_builder/screens/resume/appbar.dart';

class WorkDetail extends StatelessWidget {

  final WorkModule selectedWork;
  final ResumeUser user;

  const WorkDetail({Key? key, required this.selectedWork, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResumeAppBar(
        user: user,
        title: "Work Detail",
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              children: [
                Expanded(
                    child: Divider()
                ),
                Text(
                  "Company Name",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: Divider()
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedWork.companyName,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue[600],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              children: [
                Expanded(
                    child: Divider()
                ),
                Text(
                  "Position",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: Divider()
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedWork.position,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue[600],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider()
                ),
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: Divider()
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedWork.location,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue[600],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              children: [
                Expanded(
                    child: Divider()
                ),
                Text(
                  "Working Date",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: Divider()
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(64.0, 8.0, 64.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedWork.fromDate,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue[600],
                  ),
                ),
                Expanded(
                  child: Divider(),
                ),
                Text(
                  selectedWork.toDate,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue[600],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Row(
              children: [
                Expanded(
                    child: Divider()
                ),
                Text(
                  "Main Points",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: Divider()
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedWork.mainPoints.length,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    selectedWork.mainPoints[index],
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
