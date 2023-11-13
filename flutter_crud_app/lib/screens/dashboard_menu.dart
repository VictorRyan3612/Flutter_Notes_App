import 'package:flutter/material.dart';


class DashboardMenu extends StatelessWidget {
  final String titulo;
  // final List<Map<String, dynamic>> lista;
  final List<Map<String, dynamic>> cards;
  const DashboardMenu({required this.titulo, required this.cards, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: 
                      cards.map((item) {
                        return CustomCard(
                          title: item['title'],
                          rota: item['rota'],
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class CustomCard extends StatelessWidget {
  final String title;
  final String rota;

  const CustomCard({
    required this.title,
    required this.rota,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      height: 160.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 63, 63, 63)),
          elevation: const MaterialStatePropertyAll(2),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ))
        ),

        onPressed: (){
          Navigator.pushNamed(context, rota);
        }, 
        
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ) 
      ),
    );
  }
}
