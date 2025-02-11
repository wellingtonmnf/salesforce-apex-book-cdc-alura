public with sharing class AtualizaCodigoConta {

    public static void salvarConta() {

        Http http = new Http();
        String url = 'https://jsonplaceholder.typicode.com/todos/1';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            
            Map<String,Object> jsonData = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            List<Account> accounts = new List<Account>();

            Account account = new Account();

            Map<String,Object> cnaes = (Map<String,Object>)jsonData.get('CNAE__r');
            Map<String,Object> cities = (Map<String,Object>)jsonData.get('BillingCity__r');

            CNAE__c cnae = new CNAE__c(Code__c = (String) cnaes.get('Code__c'));
            City__c city = new City__c(IBGECode__c = (String) cities.get('IBGECode__c'));

            insert cnae;
            insert city;
           
            account.Name = (String) jsonData.get('Name');
            account.ExternalId__c = (String) jsonData.get('ExternalId__c');
            account.DocumentNumber__c = (String) jsonData.get('DocumentNumber__c');
            account.CNAE__c = cnae.Id;
            account.BillingCity__c = city.Id;

            accounts.add(account);

            upsert accounts ExternalId__c;

            Account conta = [SELECT Name, ExternalId__c, DocumentNumber__c, CNAE__r.Code__c, BillingCity__r.IBGECode__c FROM Account WHERE ExternalId__c = '62132916012'];

            System.debug('Nome da conta teste: ' + conta.Name);
            System.debug('Conta antes do teste: ' + conta.ExternalId__c);
            System.debug('Conta antes do teste: ' + conta.DocumentNumber__c);
            System.debug('Conta antes do teste: ' + conta.CNAE__r.Code__c);
            System.debug('Conta antes do teste: ' + conta.BillingCity__r.IBGECode__c);



        }

    }
}