//Teste de fluxo

import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';


import 'martches.dart';
import 'mocks.dart';

void main(){

  testWidgets('Devera salvar o contato', (tester) async{

    final mockContactDao = MockContactDao(); //Objeto simulado

    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,)); //BytebanckApp é a primeira tela chamada

    //Verificar se o dashboard foi apresentado na arvore
    final dasboard = find.byType(Dashboard);
    expect(dasboard,findsOneWidget);

    //Verificar se o item de transfereência foi criado
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        verificacaoIgualdadeItem(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    
    //Testar ação de clique mo item (de tranferência)
   await tester.tap(transferFeatureItem);

   //Fazer com que as microtarefas sejam executadas antes de conitnuar o teste
    await tester.pumpAndSettle();

    //Encontrar a lista de contatos clicar no item de transferência
    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    //Encontrar o floatActionButton
    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    //Encontrar o formulário
    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    //Encontrar o nome no formulário
    final nameTextField = find.byWidgetPredicate((widget){
      if(widget is TextField){
        return widget.decoration.labelText == 'Full name';
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);
    //Colocar um nome no formulário
    await tester.enterText(nameTextField, 'Rafael');


    //Encontrar o número da conta no formulário
    final acoountNumberTextField = find.byWidgetPredicate((widget){
      if(widget is TextField){
        return widget.decoration.labelText == 'Account number';
      }
      return false;
    });
    expect(acoountNumberTextField, findsOneWidget);
    //Colocar um nome no formulário
    await tester.enterText(acoountNumberTextField, '1000');


    //Encontrar o botão no formulário
    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    //verificar se o botão é criado
    await tester.tap(createButton);
    await tester.pumpAndSettle();


    //Verificar se o contato foi colocado na lista de contatos
    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

  });
}