import 'package:flutter/material.dart';
class SectionHeader extends StatelessWidget {

  final String header;

  const SectionHeader({
    Key? key, required this.header
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(),
          ),
          Text(
            header,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Expanded(
            child: Divider(),
          )
        ],
      ),
    );
  }
}