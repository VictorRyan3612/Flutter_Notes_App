import 'package:flutter/material.dart';

import 'package:app_notes/widget/dropdownbutton.dart';


// Search Section, sort and search
class SearchSection extends StatelessWidget {
  final Function callbackFilter;
  final Function callbackSort;
  final String? sortParam;


  const SearchSection({super.key, required this.callbackFilter, required this.callbackSort, this.sortParam});

    


  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyDropdownButton(
            )
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                onChanged: (value) => callbackFilter(value),
                decoration: InputDecoration(
                  hintText: "filtrar",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
