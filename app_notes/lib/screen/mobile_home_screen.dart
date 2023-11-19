import 'package:flutter/material.dart';
import 'dart:math';


class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 10, // Defina o número desejado de itens
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Color.fromARGB(
            255,
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          ),
        ),
      ),
    );
  }
}