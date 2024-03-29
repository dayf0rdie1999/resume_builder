import 'package:flutter/material.dart';
import 'package:resume_builder/enum/device_screen_type.dart';

class SizingInformation {
  final Orientation? orientation;
  final DeviceScreenType? deviceScreenType;
  final Size? screenSize;
  final Size? localWidgetSize;
  final bool? isKsiWeb;


  SizingInformation({this.orientation, this.deviceScreenType, this.screenSize, this.localWidgetSize, this.isKsiWeb});


  @override
  String toString() {
    return 'Orientation: $orientation DeviceType: $deviceScreenType ScreenSize: $screenSize localWidgetSize: $localWidgetSize isKsiWeb: $isKsiWeb';
  }
}