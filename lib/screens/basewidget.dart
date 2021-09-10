import 'package:flutter/cupertino.dart';
import 'package:resume_builder/module/sizinginformation.dart';
import 'package:resume_builder/utils/ui_utils.dart';
import 'package:resume_builder/utils/web_utils.dart';

class BaseWidget extends StatelessWidget {

  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  const BaseWidget({Key? key,required  this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context,boxConstraints) {
      var sizingInformation = SizingInformation(
        screenSize: mediaQuery.size,
        orientation: mediaQuery.orientation,
        deviceScreenType: getDeviceType(mediaQuery),
        localWidgetSize: Size(boxConstraints.maxWidth,boxConstraints.maxHeight),
        isKsiWeb: isKsiWeb(),
      );

      return builder(context, sizingInformation);
    });
  }
}
