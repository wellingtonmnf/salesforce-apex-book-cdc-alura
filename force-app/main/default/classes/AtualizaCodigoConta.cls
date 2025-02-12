public with sharing class AtualizaCodigoConta {

    public static void salvarConta() {
        //Cria um novo objeto HTTP para enviar uma solicitação
        Http http = new Http();
        String url = 'https://jsonplaceholder.typicode.com/todos/1';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // Executa o código caso a resposta seja bem-sucedida
        if (response.getStatusCode() == 200) {
            //Desserializa o JSON da resposta e cria uma lista de contas
            Map<String,Object> jsonData = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            List<Account> accounts = new List<Account>();
            // Cria uam conta para receber os dados a serem atualizados
            Account account = new Account();
            // Cria mapas para indexar os dados de CNAE e Cidade vindos do JSON
            Map<String,Object> cnaes = (Map<String,Object>)jsonData.get('CNAE__r');
            Map<String,Object> cities = (Map<String,Object>)jsonData.get('BillingCity__r');
            // Busca o CNAE e a cidade no banco de dados
            CNAE__c cnae = [SELECT Id, Name, Code__c FROM CNAE__c WHERE Code__c = :(String)cnaes.get('Code__c')];
            City__c city = [SELECT Id, Name, IBGECode__c FROM City__c WHERE IBGECode__c = :(String)cities.get('IBGECode__c')];
            // Preenche os dados da conta
            account.Name = (String) jsonData.get('Name');
            account.ExternalId__c = (String) jsonData.get('ExternalId__c');
            account.DocumentNumber__c = (String) jsonData.get('DocumentNumber__c');
            account.CNAE__c = cnae.Id;
            account.BillingCity__c = city.Id;
            // Adiciona a conta à lista de contas
            accounts.add(account);
            // Insere as contas no banco de dados
            upsert accounts ExternalId__c;
            // Verifica se a conta foi salva com sucesso
            if (accounts.size() > 0) {
                System.debug('Conta salva com sucesso!');
                // Busca a conta no banco de dados
                Account conta = [SELECT Name, ExternalId__c, DocumentNumber__c, CNAE__r.Code__c, BillingCity__r.IBGECode__c FROM Account WHERE ExternalId__c = '62132916012'];
                // Exibe os dados da conta no console
                System.debug('Nome da conta: ' + conta.Name);
                System.debug('ID Externo da conta: ' + conta.ExternalId__c);
                System.debug('CNPJ: ' + conta.DocumentNumber__c);
                System.debug('CNAE: ' + conta.CNAE__r.Code__c);
                System.debug('Código IBGE: ' + conta.BillingCity__r.IBGECode__c);
            } else {
                System.debug('Erro ao salvar conta!');
            }

        }

    }
}