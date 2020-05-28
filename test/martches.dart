import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';

bool verificacaoIgualdadeItem(Widget widget, String nome, IconData icon) {
  if(widget is FeatureItem){
    return widget.name == nome && widget.icon == icon;
  }
  return false;
}