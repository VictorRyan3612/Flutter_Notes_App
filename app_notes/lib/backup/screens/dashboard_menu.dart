import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';

class DashboardMenu extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> cards;
  const DashboardMenu({required this.title, required this.cards, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                          route: item['route'],
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


