import 'package:flutter_test/flutter_test.dart';

import '../lib/models/transaction.dart';

void main(){
  //teste de unidade
    test('Deve retornar o valor quando criar uma transação', (){

      final transactionn = Transaction(null,200,null);

      //O primeiro paramentro é o que você tem e o segundo é o que você espera ter
      expect(transactionn.value, 200);

    });

    test('Deve falhar se o valor da transferencia for menor ou igual a 0',
        (){
          //Devese lançar o erro no metodo chamado, no caso, em Transaction
          expect(() => Transaction(null,0,null),throwsAssertionError);
        });

}