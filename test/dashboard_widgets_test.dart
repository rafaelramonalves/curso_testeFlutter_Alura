//teste de widgets

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';
import '../lib/screens/dashboard.dart';

void main(){
  testWidgets('Deve apresentar a imagem principal na tela quando o'
      'dashboard for aberto', (WidgetTester widgetTester) async{

    //Usar o wait para que a tela esteje pronta antes de executar os testes
    await  widgetTester.pumpWidget(MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image); //Verificar se foi encontrada uma imagem
    
    expect(mainImage, findsOneWidget);

  });

  testWidgets('Deve apresentar a primeira funcionalidade quando o dashboard for aberto',
          (tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    
    final firstFeature = find.byType(FeatureItem);
    expect(firstFeature, findsWidgets);//Ele vai achar mais de um widegt, já
            // que a imagem ja foi criada
  });
}
