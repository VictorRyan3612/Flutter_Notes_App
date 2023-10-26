import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:card_settings/card_settings.dart';

class TelaConfigs extends HookWidget implements PreferredSizeWidget{
  final ValueNotifier<Brightness> currentBrightness;

  const TelaConfigs({required this.currentBrightness, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de configurações'),
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child:CardSettings.sectioned(
                  children: [
                    CardSettingsSection(
                      header: CardSettingsHeader(
                        label: 'Geral',
                      ),
                      children: [
                        CardSettingsSwitch(
                          trueLabel: '', 
                          falseLabel: '',
                          label: 'Modo noturno',
                          initialValue: true,
                          onChanged: (value) {
                            if (currentBrightness.value == Brightness.dark) {
                              currentBrightness.value = Brightness.light;
                            } 
                            else {
                              currentBrightness.value = Brightness.dark;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}