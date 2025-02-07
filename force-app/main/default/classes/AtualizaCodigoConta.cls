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
           
            account.Name = (String) jsonData.get('Name');
            //account.DocumentNumber__c = (String) jsonData.get('DocumentNumber__c');
            account.ExternalId__c = (String) jsonData.get('ExternalId__c');
            accounts.add(account);

            upsert accounts ExternalId__c;


        }

    }
}