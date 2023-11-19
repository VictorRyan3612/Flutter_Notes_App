import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';


class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text("Mobile Layout")
      ),
    );
  }
}
