import 'package:flutter/material.dart';


import '../layout/desktop.dart';
import '../layout/mobile.dart';
import '/layout/layout.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: MobileHomePage(), 
      desktopBody: DesktopHomePage()
    );
  }
}
