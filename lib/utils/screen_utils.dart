
import 'package:flutter/material.dart';

class ScreenUtil {
  static late double hight;
  static late double width;

  static void init(BuildContext context) {
    hight = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}


