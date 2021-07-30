import 'package:flutter/material.dart';


class WorkInputForm extends StatelessWidget {


  const WorkInputForm({
    Key? key,
    required TextEditingController companyNameController, required this.labelText
  }) : _companyNameController = companyNameController, super(key: key);

  final TextEditingController _companyNameController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          labelText: "Enter $labelText",
        ),
        controller: _companyNameController,
        validator: (value) {
          if (value == null && value!.isEmpty) {
            return "Required Input";
          }
          return null;
        },
      ),
    );
  }
}