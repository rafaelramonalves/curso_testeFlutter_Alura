
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/martches.dart';
import '../mock/mocks.dart';
import 'actions.dart';

void main(){
  testWidgets('Tranferencia para o contato', (tester) async{


    final mockContactDao = MockContactDao(); //Objeto simulado

    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,)); //BytebanckApp é a primeira tela chamada

    //Verificar se o dashboard foi apresentado na arvore
    final dasboard = find.byType(Dashboard);
    expect(dasboard,findsOneWidget);

    //mock
    when(mockContactDao.findAll()).thenAnswer((invocation) async{

      debugPrint('Name invocation ${invocation.memberName}');
      return [Contact(0, 'Rafael', 1000)];

    });

    //Verificar se o item de transfereência foi criado
    await cliqueNaTransferencia(tester);

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

    //Receber o argumento e garantir se foi chamado (mock /unidade 4)
    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget){

      if(widget is ContactItem){
        return widget.contact.name == 'Rafael' &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

  });
}

