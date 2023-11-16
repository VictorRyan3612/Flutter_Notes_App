import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAppBar extends HookWidget implements PreferredSizeWidget {
  final _callback;

  MyAppBar({super.key, callback}) : _callback = callback ?? (int) {}
    

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final showFilter = useState(false);

    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: 
            Row(
              children: [
                Text(AppLocalizations.of(context)!.userPageTitle),
                
                IconButton(
                  tooltip: AppLocalizations.of(context)!.userSort,
                  icon: const Icon(Icons.sort_by_alpha),
                  onPressed: (){
                    // 
                  },
                ),
              ],
            ),
          ),
          
          if (showFilter.value)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  onChanged: (value) => _callback(value),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.userFilter,
                  ),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: AppLocalizations.of(context)!.userFilter,
            onPressed: () {
              showFilter.value = !showFilter.value;
            },
          ),
        ],
      ),
    );
  }
}
