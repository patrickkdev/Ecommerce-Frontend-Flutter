import 'package:flutter/material.dart';

class AppTheme {
  final bool? isDark;

  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;

  final TextStyle? appHeadlineLarge;
  final TextStyle? appHeadlineMedium;
  final TextStyle? appHeadlineSmall;

  final TextStyle? appDisplayLarge;
  final TextStyle? appDisplayMedium;
  final TextStyle? appDisplaySmall;

  final TextStyle? appTitleLarge;
  final TextStyle? appTitleMedium;
  final TextStyle? appTitleSmall;

  final TextStyle? appBodyLarge;
  final TextStyle? appBodyMedium;
  final TextStyle? appBodySmall;

  final TextStyle? appLabelLarge;
  final TextStyle? appLabelMedium;
  final TextStyle? appLabelSmall;

  const AppTheme({
    this.isDark = false,
    this.primaryColor = const Color.fromARGB(255, 238, 238, 238),
    this.secondaryColor = Colors.white,
    this.accentColor = Colors.amber,
    this.appHeadlineLarge = const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
    this.appHeadlineMedium = const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    this.appHeadlineSmall = const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
    this.appDisplayLarge = const TextStyle(fontSize: 32, color: Colors.black),
    this.appDisplayMedium = const TextStyle(fontSize: 22, color: Colors.black),
    this.appDisplaySmall = const TextStyle(fontSize: 15, color: Colors.black),
    this.appBodyLarge = const TextStyle(fontSize: 25, color: Colors.black),
    this.appBodyMedium = const TextStyle(fontSize: 18, color: Colors.black),
    this.appBodySmall = const TextStyle(fontSize: 12, color: Colors.black),
    this.appTitleLarge = const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
    this.appTitleMedium = const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    this.appTitleSmall = const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
    this.appLabelLarge = const TextStyle(fontSize: 25, color: Colors.black),
    this.appLabelMedium = const TextStyle(fontSize: 18, color: Colors.black),
    this.appLabelSmall = const TextStyle(fontSize: 12, color: Colors.black),
  });

  // for texttheme fields we have no defaults if not set.
  factory AppTheme.lightDefault() {
    return const AppTheme();
  }
}
