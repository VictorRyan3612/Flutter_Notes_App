import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// Search Section, sort and search
class SearchSection extends StatelessWidget {
  final Function _callbackFilter;
  final Function _callbackSort;

  const SearchSection({super.key, callbackFilter, callbackSort})
    : _callbackFilter = callbackFilter ?? (int),
      _callbackSort = callbackSort ?? (int);
    


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
                _callbackSort();
              },
            
            )
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                onChanged: (value) => _callbackFilter(value),
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
