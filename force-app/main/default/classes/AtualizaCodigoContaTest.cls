@isTest
private class AtualizaCodigoContaTest implements HttpCalloutMock {

    @isTest
    static void testSalvarConta() {
        
        Test.setMock(HttpCalloutMock.class, new AtualizaCodigoContaTest());
        
        Test.startTest();
        AtualizaCodigoConta.salvarConta();
        Test.stopTest();

        Account conta = [SELECT Name, ExternalId__c, DocumentNumber__c, CNAE__r.Code__c, BillingCity__r.IBGECode__c FROM Account WHERE ExternalId__c = '62132916012'];
        
        System.assertEquals('Super Mega Cliente1', conta.Name);
        System.assertEquals('62132916012', conta.ExternalId__c);
        System.assertEquals('62132916012', conta.DocumentNumber__c);
        System.assertEquals('2923392', conta.CNAE__r.Code__c);
        System.assertEquals('5030857', conta.BillingCity__r.IBGECode__c);

    }


    public HTTPResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"Name": "Super Mega Cliente1", "DocumentNumber__c": "62132916012", "ExternalId__c":  "62132916012", "CNAE__r": {"Code__c" : "2923392"},"BillingCity__r": {"IBGECode__c" : "5030857"}}');
        return response;
    }
}