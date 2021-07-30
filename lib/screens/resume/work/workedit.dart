import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/module/work.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/work/partials/sectionheader.dart';
import 'package:resume_builder/screens/resume/work/partials/workinputform.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/services/storeservice.dart';

class WorkEdit extends StatefulWidget {

  final WorkModule selectedWork;
  final ResumeUser user;


  const WorkEdit({Key? key, required this.selectedWork, required this.user}) : super(key: key);

  @override
  _WorkEditState createState() => _WorkEditState();
}

class _WorkEditState extends State<WorkEdit> {

  final _singleValueFormKey = GlobalKey<FormState>();
  final _mainPointsFormKey = GlobalKey<FormState>();

  final _companyNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _locationController = TextEditingController();
  final _mainPointController = TextEditingController();



  final DateFormat formatter = DateFormat('yyyy-MM-dd');


  _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.selectedWork.fromDate), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != DateTime.parse(widget.selectedWork.fromDate))
      setState(() {
        widget.selectedWork.fromDate = formatter.format(picked);
      });
  }

  _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.selectedWork.toDate), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != DateTime.parse(widget.selectedWork.toDate))
      setState(() {
        widget.selectedWork.toDate = formatter.format(picked);
      });
  }

  @override
  void initState() {
    _companyNameController.text = widget.selectedWork.companyName;
    _positionController.text = widget.selectedWork.position;
    _locationController.text = widget.selectedWork.location;
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
        title: "Edit Work",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Form(
            key: _singleValueFormKey,
            child: Column(
              children: <Widget>[
                SectionHeader(header: "Company Name",),
                WorkInputForm(companyNameController: _companyNameController,labelText: "Company Name",),
                SectionHeader(header: "Position",),
                WorkInputForm(companyNameController: _positionController,labelText: "Position",),
                SectionHeader(header: "Location",),
                WorkInputForm(companyNameController: _locationController,labelText: "Location",),
                SectionHeader(header: "Work Time",),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                          onPressed: () {
                            _selectFromDate(context);
                          },
                          child: Text(
                            widget.selectedWork.fromDate,
                            style: TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.underline
                            ),
                          )
                      ),
                      Expanded(
                          child: Divider()
                      ),
                      TextButton(
                          onPressed: () {
                            _selectToDate(context);
                          },
                          child: Text(
                            widget.selectedWork.toDate,
                            style: TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SectionHeader(header: "Main Points",),
                Form(
                  key: _mainPointsFormKey,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLines: 5,
                              controller: _mainPointController,
                              validator: (value) {
                                if (value == null && value!.isEmpty) {
                                  return "Input Text Required";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                labelText: "Add Main Points",
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_mainPointsFormKey.currentState!.validate()) {
                              setState(() {
                                widget.selectedWork.mainPoints.add(_mainPointController.text);
                                _mainPointController.clear();
                              });
                            }
                          },
                          icon: Icon(Icons.add_circle_outline),
                          iconSize: 48.0,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200.0,
                  child: ListView.builder(
                      itemCount: widget.selectedWork.mainPoints.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.selectedWork.mainPoints[index],
                                          style: TextStyle(
                                            color: Colors.blue[600],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.selectedWork.mainPoints.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.remove_circle),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_singleValueFormKey.currentState!.validate()) {
                              widget.selectedWork.companyName = _companyNameController.text;
                              widget.selectedWork.position = _positionController.text;
                              widget.selectedWork.location = _locationController.text;

                              // Todo: Updating the data
                              String? result = await StoreService().updateWork(widget.selectedWork);

                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text("Save"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




