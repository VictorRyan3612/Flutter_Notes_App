import 'package:app_notes/config/theme_config.dart';
import 'package:flutter/material.dart';


class ColorSelect extends StatelessWidget {
  const ColorSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: Container(
          width: 600,
          height: 600,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Container clicado!');
                      },
                    child:
                      Container(
                        color: Colors.blue,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Container clicado!');
                      },
                    child:
                      Container(
                        color: Colors.blue,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Container clicado!');
                      },
                    child:
                      Container(
                        color: Colors.blue,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Container clicado!');
                      },
                    child:
                      Container(
                        color: Colors.blue,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
