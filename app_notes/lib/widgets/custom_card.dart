import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String route;

  const CustomCard({
    required this.title,
    required this.route,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      height: 160.0,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(2),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Ajuste para centralizar verticalmente
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
