import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/martches.dart';

Future<void> cliqueNaTransferencia(WidgetTester tester){
  //Verificar se o item de transfereência foi criado
  final transferFeatureItem = find.byWidgetPredicate((widget) =>
      verificacaoIgualdadeItem(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);

  //Testar ação de clique mo item (de tranferência)
  return tester.tap(transferFeatureItem);
}
