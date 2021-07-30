import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/module/work.dart';
import 'package:resume_builder/screens/resume/appbar.dart';
import 'package:resume_builder/screens/resume/work/partials/sectionheader.dart';
import 'package:resume_builder/screens/resume/work/partials/workinputform.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/services/storeservice.dart';

class AddWork extends StatefulWidget {

  final ResumeUser user;

  const AddWork({Key? key, required this.user}) : super(key: key);

  @override
  _AddWorkState createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {

  final _singleValueFormKey = GlobalKey<FormState>();
  final _mainPointsFormKey = GlobalKey<FormState>();

  final _companyNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _locationController = TextEditingController();
  final _mainPointController = TextEditingController();

  DateTime fromDateData = DateTime.now();
  DateTime toDateData = DateTime.now();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final List<String> mainPointsList = [];

  _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDateData, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != fromDateData)
      setState(() {
        fromDateData = picked;
      });
  }

  _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDateData, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != toDateData)
      setState(() {
        toDateData = picked;
      });
  }


  @override
  Widget build(BuildContext context) {

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ResumeAppBar(
        user: widget.user,
        title: "Add Work",
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
                            formatter.format(fromDateData),
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
                            formatter.format(toDateData),
                            style: TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline
                            ),
                          ),
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
                                mainPointsList.add(_mainPointController.text);
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
                mainPointsList.isEmpty ? Center(child: Text("Waiting for inputting main points..."),) : Container(
                  height: 200.0,
                  child: ListView.builder(
                      itemCount: mainPointsList.length,
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
                                          mainPointsList[index],
                                          style: TextStyle(
                                            color: Colors.blue[600],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            mainPointsList.removeAt(index);
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

                              WorkModule newWork = WorkModule(companyName: _companyNameController.text,position: _positionController.text,location: _locationController.text,
                              mainPoints: mainPointsList,fromDate: formatter.format(fromDateData),toDate: formatter.format(toDateData),workId: "Null");

                              // Todo: Updating the data
                              String? result = await StoreService().addWork(newWork);

                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text("Add Work"),
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
