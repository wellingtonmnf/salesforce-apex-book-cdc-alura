Script de Testes - Capítulo 2


NotaFiscal notaFiscal = new NotaFiscal();
notaFiscal.imprimeNota (1231.00);

----------------------------------------------

Celular motorolaXPTO = new Celular();

motorolaXPTO.numeroNucleosProcessador = 8;
motorolaXPTO.marca = 'Moto XPTO';
motorolaXPTO.fabricante = 'Motorola';

System.debug ('Motorola XPTO' + motorolaXPTO);

Celular iPhoneXXX = new Celular();

iPhoneXXX.numeroNucleosProcessador = 8;
iPhoneXXX.marca = 'iPhone';
iPhoneXXX.fabricante = 'Apple';

System.debug ('iPhoneXXX' + iPhoneXXX);

----------------------------------------------

ItemPedido item = new ItemPedido();
item.setQuantidade(1);
item.setPreco(1000.00);
item.setPrecoLiquido(980.00);


Pedido pedido = new Pedido();

pedido.adicionarItem(item);

System.debug ('Total sem impostos: ' + pedido.getTotalLiquido());
System.debug ('Total Geral: ' + pedido.getTotal());
