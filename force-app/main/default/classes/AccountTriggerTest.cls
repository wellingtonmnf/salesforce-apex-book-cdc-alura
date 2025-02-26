/**
 * @author eduardo.bisso
 */
@isTest
private class AccountTriggerTest {

    @isTest
    static void shouldCreateAccountWithValidDocumentAndCreateTask() {
        // dado (given)
        Account expectedAccount = new Account(Name = 'Test Account', DocumentNumber__c = '111.444.777-35');

        // quando (when)
        insert expectedAccount;

        // então (then)
        Assert.isNotNull(expectedAccount.Id, 'Conta criada com sucesso');

        // verificar se a tarefa foi criada
        List<Task> tasks = [SELECT Id, Subject, Status, WhoId, WhatId FROM Task WHERE WhatId = :expectedAccount.Id];

        Assert.isFalse(tasks.isEmpty(), 'Deve retornar uma tarefa pelo menos'); // retornou resultado

        System.assertEquals(1, tasks.size(), 'Apenas uma tarefa deverá ser criada');
    }

    @isTest
    public static void shouldGenerateErrorWhenTryToCreateAnAccountWithInvalidDocument() {

        // dado (given)
        Account expectedAccount = new Account(Name = 'Test Account', DocumentNumber__c = '111.444.777-95');

        try { // <--- tenta executar o bloco de código

            // quando (when)
            insert expectedAccount; // aqui deve gerar um erro

            Assert.fail('Não deveria criar a conta com CPF inválido');
            
        } catch (DmlException e) { // se for gerado esse tipo de erro executa o bloco de código

            System.debug(e.getDmlMessage(0));

            // verifica se o erro é de Documento inválido
            Assert.isTrue(e.getDmlMessage(0).contains('Documento inválido'));
            
        }
    }

    @isTest
    static void shouldUpdateAccountWithValidDocument() {
        // dado (given)
        Account expectedAccount = new Account(Name = 'Test Account', DocumentNumber__c = '111.444.777-35');

        insert expectedAccount;

        Assert.isNotNull(expectedAccount.Id, 'Conta criada com sucesso');

        expectedAccount.DocumentNumber__c = '023.544.756-08';
        
        // quando (when)
        update expectedAccount;

        // então (then)

        expectedAccount = [SELECT Id, Name, DocumentNumber__c FROM Account WHERE Id = :expectedAccount.Id];

        System.assertEquals('023.544.756-08', expectedAccount.DocumentNumber__c, 'Atualização feita com sucesso');
    }

    @isTest
    public static void shouldGenerateErrorWhenTryToUpdateAnAccountWithInvalidDocument() {

        // dado (given)
        Account expectedAccount = new Account(Name = 'Test Account', DocumentNumber__c = '111.444.777-35');

        insert expectedAccount;

        expectedAccount.DocumentNumber__c = '111.444.777-95'; //número de CPF inválido

        try { // <--- tenta executar o bloco de código

            // quando (when)
            update expectedAccount; // aqui deve gerar um erro

            Assert.fail('Não deveria atualizar a conta com CPF inválido');
            
        } catch (DmlException e) { // se for gerado esse tipo de erro executa o bloco de código

            // vamos verificar se o erro de fato é de Documento inválido
            Assert.isTrue(e.getDmlMessage(0).contains('Documento inválido'));
            
        }
    }
}