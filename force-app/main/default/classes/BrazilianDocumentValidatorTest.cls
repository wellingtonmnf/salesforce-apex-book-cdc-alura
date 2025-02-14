@isTest
private class BrazilianDocumentValidatorTest {

    @isTest
    static void shouldValidateCnpj() {

        String cnpj = '93.320.424/0001-14';

        BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

        System.assert(validator.isCnpj (cnpj), 'Deve ser um número de CNPJ brasileiro válido');
        
        System.assert(validator.isCnpj ('08857729000190'), 'Deve ser um número de CNPJ brasileiro válido');
        System.assert(validator.isCnpj ('8857729000190'), 'Deve ser um número de CNPJ brasileiro válido');

        System.assertEquals( false, validator.isCnpj ('123456789'), 'Deve ser um número de CNPJ brasileiro inválido');
                                                      
        System.assertEquals( false, validator.isCnpj ('11111111111111'), 'Deve ser um número de CNPJ brasileiro inválido');
        System.assertEquals( false, validator.isCnpj ('22222222222222'), 'Deve ser um número de CNPJ brasileiro inválido');

    }

    @isTest
    static void shouldValidateCpf() {

        String cpf = '229.760.560-99';

        System.assert(new BrazilianDocumentValidator().isCpf (cpf), 'Deve ser um número de CPF brasileiro válido');
        
        System.assert(new BrazilianDocumentValidator().isCpf ('86989551003'), 'Deve ser um número de CPF brasileiro válido');

        System.assertEquals( false, new BrazilianDocumentValidator().isCpf ('123245678'), 'Deve ser um número de CPF brasileiro inválido');

    }



    @isTest
    static void shouldValidateDocument() {
        
        BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

        System.assert(validator.isValid('86989551003'), 'Deve ser um número de CPF brasileiro válido');
        System.assert(validator.isValid('8857729000190'), 'Deve ser um número de CNPJ brasileiro válido');

    }
}