import 'package:flutter/material.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/services/storeservice.dart';

class ProfileInputForm extends StatefulWidget {

  final String heading;
  final ResumeUser user;
  final String docKey;

  const ProfileInputForm({Key? key,required this.docKey,required this.user,required this.heading}) : super(key: key);

  @override
  _ProfileInputFormState createState() => _ProfileInputFormState();
}

class _ProfileInputFormState extends State<ProfileInputForm> {

  final StoreService _storeService = StoreService();

  bool _editMode = false;

  final TextEditingController _controller = TextEditingController();

  getAdminSpecificData() async {
    _controller.text = await _storeService.getAdminSpecificData(widget.docKey);
  }

  @override
  void initState() {
    getAdminSpecificData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 16.0,),
        Text(
          "${widget.heading}: ",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        SizedBox(width: 8.0,),
        Expanded(
          child: TextFormField(
            enabled:_editMode,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            ),
            controller: _controller,
          ),
        ),
        SizedBox(width: 8.0,),
        IconButton(
          disabledColor: Colors.grey,
          onPressed: widget.user.admin ? () {
            if (_editMode == false) {
              setState(() {
                _editMode = true;
              });
            } else {

              // Todo: Update to the Firestore of the data changes
              _storeService.updateData("admin", "profile", widget.docKey, _controller.text);

              // Todo:
              setState(() {
                _editMode = false;
              });

            }
          } : null,
          icon: Icon(Icons.edit),
        ),
        SizedBox(width: 8.0,),
      ],
    );
  }
}