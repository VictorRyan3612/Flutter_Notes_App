import 'package:flutter/material.dart';

class FocusSettings {
  FocusNode? lastFocusedNode;

  final FocusNode textFieldFocusNode = FocusNode();
  
  void saveFocus(FocusNode? focusNode) {
    lastFocusedNode = focusNode;
  }
  void saveActualFocus(){
    lastFocusedNode = FocusManager.instance.primaryFocus;
  }
  void restoreLastFocus() {
    lastFocusedNode?.requestFocus();
  }
  void focusSeachTextField(){
    saveActualFocus();
    if(textFieldFocusNode.canRequestFocus){
      textFieldFocusNode.requestFocus();
    }
  }

}
FocusSettings focusSettings = FocusSettings();
