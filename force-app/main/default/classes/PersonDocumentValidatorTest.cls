@isTest
private class PersonDocumentValidatorTest {

    // Deve retornar false para CPF null ou vazio
    @isTest
    public static void shouldReturnFalseForNullOrEmptyCpf() {

        PersonDocumentValidator validator = new PersonDocumentValidator();

        System.assert(!validator.isCPF(null), 'CPF Nulo NÃO é válido');
        Assert.isFalse(validator.isCPF(null), 'CPF Nulo NÃO é válido');
        System.assert(!validator.isCPF(''), 'CPF vazio NÃO é válido');
        Assert.isFalse(validator.isCPF(''), 'CPF vazio NÃO é válido');
        
    }

    // Deve remover caracteres de mascara (###.###.###-##)
    @isTest
    public static void shouldRemoveMaskChars(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String result = validator.removeMaskChars('XXX.XXX-AAA');

        Assert.areEqual('XXXXXXAAA', result, 'Remove os caracteres esperados');

        // Caractere "/" inválido não será removido
        result = validator.removeMaskChars('111/ZZZ-XX');

        Assert.areEqual('111/ZZZXX', result, 'Não remove outros caracteres especiais');

    }

    @isTest
    public static void shouldReturnFalseForCpfWithText(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '111.444.777-XX';

        Boolean result = validator.isCPF(cpf);

        Assert.isFalse(result, 'CPF 111.444.777-XX NÃO é válido');
        // Caractere "/" conta como alfanumético
        cpf = '111.444/777-11';

        Assert.isFalse(validator.isCPF(cpf), 'CPF 111.444/777-11 NÃO é válido');
    }

    @isTest
    public static void shouldReturnInvalidLenghtForCpf(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '111.444.777-111';

        Boolean result = validator.isCPF(cpf);

        Assert.isFalse(result, 'CPF 111.444.777-111 NÃO é válido');

        cpf = '9111.444.777-11';

        Assert.isFalse(validator.isCPF(cpf), 'CPF 9111.444.777-11 NÃO é válido');
    }

    @isTest
    public static void shouldRejectSameDigits(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '###.###.###-##';

        for (Integer i = 0; i < 10; i++) {

            Boolean result = validator.isCPF(cpf.replaceAll('#', i+''));

            Assert.isFalse(result, 'CPF é inválido');
            
        }
    }

    @isTest
    static void shouldCalculateFirstCpfDigit(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '11144477735';

        List<String> digits = cpf.split('');

        Integer digit = validator.calculateDigit(digits, 10, 9);

        Assert.areEqual(3, digit, 'Primeiro dígito verificador está correto');

    }

    @isTest
    static void shouldCalculateSecondCpfDigit(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '11144477735';

        List<String> digits = cpf.split('');

        Integer digit = validator.calculateDigit(digits, 11, 10);

        Assert.areEqual(5, digit, 'Segundo dígito verificador está correto');

    }

    @isTest
    static void shouldCalculateCpfDigitWithZeroRest(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '86989551003';

        List<String> digits = cpf.split('');

        Integer digit = validator.calculateDigit(digits, 10, 9);

        Assert.areEqual(0, digit, 'Primeiro dígito verificador está correto');

    }

    @isTest
    public static void shouldAcceptValidCpfNumber(){

        PersonDocumentValidator validator = new PersonDocumentValidator();

        String cpf = '331.099.440-65';

        Boolean result = validator.isCPF(cpf);

        Assert.isTrue(result, 'CPF 331.099.440-65 é um CPF válido');

        cpf = '221.935.320-60';

        result = validator.isCPF(cpf);

        Assert.isTrue(result, 'CPF 221.935.320-60 é um CPF válido');
    }

}