trigger Account on Account (before insert
                            , before update
                            , after insert) {

    // Determina quais registros foram atualizados
    // Coleção sempre no plural
    List<Account> newAccounts = Trigger.new;

    BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

    // Identifica qual o evento/operação foi executado
    switch on Trigger.operationType {

        when  BEFORE_INSERT, BEFORE_UPDATE {

            // Itera sobre as contas para aplicar as validações
            for (Account account : newAccounts) {

                if (!validator.isValid(account.DocumentNumber__c)) {

                    // Adiciona um erro caso não seja válido
                    account.DocumentNumber__c.addError('Documento inválido');
                    
                }
                
            }
            
        }

        when AFTER_INSERT {

            List<Task> tasks = new List<Task>();

            for (Account account : newAccounts) {
                
                Task task = new Task();

                task.Subject = 'Lembre-se de entrar em contato com o cliente ' + account.Name;
                task.Description = 'Entrar em contato para agendar a primeira reunião';
                task.ActivityDate = Date.today().addDays(1);
                task.WhatId = account.Id;
                
                tasks.add(task);
            }

            insert tasks;

        }
        
    }

}