import 'package:app_notes/layout/desktop.dart';
import 'package:flutter/material.dart';

import '../widget/tela_principal.dart';
import '../widget/drawer_menu.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        bool isMobile = constraints.maxWidth < 600;
        return Scaffold(
          drawer: DrawerMenu(),
          appBar: isMobile ? AppBar(title: Text("Mobile Layout")) : AppBar(title: Text("Desktop Layout")),
          body: isMobile 
          ? TelaPrincipal()
          : DesktopHomePage()
        );
      },
    );
  }
}
