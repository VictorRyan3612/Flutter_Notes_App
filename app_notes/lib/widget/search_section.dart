import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ordenar"),
                  const Icon(Icons.sort_by_alpha)
                ], 
              ),
              onPressed: (){
                callbackSort(sortParam);
              },
            
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
