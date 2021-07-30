import 'package:flutter/material.dart';


class Header extends StatelessWidget {

  final String header;

  const Header({
    Key? key, required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Divider()
        ),
        Text(
          "$header",
          style: TextStyle(
            fontSize: 20.0,

          ),
        ),
        Expanded(
            child: Divider()
        ),
      ],
    );
  }
}