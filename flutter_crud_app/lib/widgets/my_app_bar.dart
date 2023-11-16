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
            child: Text(AppLocalizations.of(context)!.userPageTitle),
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
            icon: Icon(Icons.search),
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
