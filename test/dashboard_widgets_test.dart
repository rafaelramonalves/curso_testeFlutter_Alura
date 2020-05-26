//teste de widgets

import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';


void main(){
  testWidgets('Deve apresentar a imagem principal na tela quando o'
      'dashboard for aberto', (WidgetTester widgetTester) async{

    //Usar o wait para que a tela esteja pronta antes de executar os testes
    await  widgetTester.pumpWidget(MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image); //Verificar se foi encontrada uma imagem
    
    expect(mainImage, findsOneWidget);

    /*

    *Executamos o nosso teste a partir de um Image que carrega a imagem por
     meio de um asset, porém, é muito comum o uso da alternativa via rede:

        Image.network('https://image_address.jpg')

    Se por algum motivo você tentar executar um teste que receba esse tipo
    de Widget durante a execução do tester.pumpWidget(), será apresentado
    um problema do HTTP, pois é um comportamento padrão em testes de widget
     que evita comunicações externas. Para evitar esse problema,
      confira esse artigo:

      https://iiro.dev/2018/09/16/image-network-widget-tests/

     */

  });

  testWidgets('Deve apresentar a primeira funcionalidade (transferência) quando o dashboard for aberto',
          (tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    
    final firstFeature = find.byType(FeatureItem);


    /*
      - Buscar por icone dentro do Feature -

      final iconTransferFeatureIcon = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
      expect(iconTransferFeatureIcon, findsWidgets);

      - Buscar pelo texto do Feature -

      final nameTranferFeatureItem = find.widgetWithText(FeatureItem, 'Transfer');
      expect(nameTranferFeatureItem, findsOneWidget);

    */

    //- Buscar pelo item do Feature -

    final transferFeatureItem = find.byWidgetPredicate((widget){

      return verificacaoIgualdadeItem(widget,'Transfer', Icons.monetization_on);

    });

    expect(transferFeatureItem, findsOneWidget);

    //expect(firstFeature, findsWidgets);//Ele vai achar mais de um widegt, já
            // que a imagem ja foi criada
  });


  testWidgets('Deve apresentar a segunda funcionalidade (transação) quando o dashboard for aberto',
          (tester) async{

        await tester.pumpWidget(MaterialApp(home: Dashboard()));

        final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
            verificacaoIgualdadeItem(widget, 'Transaction Feed', Icons.description));

        expect(transactionFeedFeatureItem, findsOneWidget);

      /*
        Buscar por icone dentro do Feature

        final iconTransactionFeatureIcon = find.widgetWithIcon(FeatureItem, Icons.monetization_on);

        expect(iconTransactionFeatureIcon, findsWidgets);

        final nameTransactionFeatureItem = find.widgetWithText(FeatureItem, 'Transaction Feed');
        expect(nameTransactionFeatureItem, findsOneWidget);

        */


      });

}

bool verificacaoIgualdadeItem(Widget widget, String nome, IconData icon) {
  if(widget is FeatureItem){
    return widget.name == nome && widget.icon == icon;
  }
  return false;
}
