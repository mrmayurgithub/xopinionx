import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Initialize Utils
void initializeUtils(BuildContext context) async {
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
  currentThemeBrightness = Theme.of(context).brightness;
}

double screenHeight;
double screenWidth;
Brightness currentThemeBrightness;
