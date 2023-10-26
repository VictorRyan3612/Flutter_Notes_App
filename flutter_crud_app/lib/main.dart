import 'package:flutter/material.dart';
import 'package:flutter_crud_app/dashboard_menu.dart';
import 'package:flutter_crud_app/tela_configs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentBrightness = useState(Brightness.dark);
    
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)
    );
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175)
    );
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      
      theme: currentBrightness.value == Brightness.dark ? darkTheme : lightTheme,

      
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardMenu(),
        '/users': (context) => const Home(),
        '/configs': (context) => TelaConfigs(currentBrightness: currentBrightness)
      }
    );
      
  }
}

class Home extends StatelessWidget{
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sub menu")
      ),
      body: const Center(
        child: Text("Hello World")
      ),
    );
  }
}
