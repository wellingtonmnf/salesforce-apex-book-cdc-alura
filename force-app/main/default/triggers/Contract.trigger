/**
 * @author eduardo.bisso - dev-builder
 */
trigger Contract on Contract (after update) {

    // Determina quais registros foram atualizados.
    // Coleção sempre no plural!
    List<Contract> newContracts = Trigger.new;
    Map<Id, Contract> oldContracts = Trigger.oldMap;

    //Identifica qual o evento/operação foi executada.
    switch on Trigger.operationType {

        when AFTER_UPDATE {

            ContractFilter filter = new ContractFilter();
            
            List<Contract> amendmentContracts = filter.byChangedToSignedStatus(newContracts, oldContracts);

            if ( !amendmentContracts.isEmpty() ) {

                ContractRepository contractRepository = new ContractRepository();

                // consulta os contratos originais para inativação 
                List<Contract> originalContracts = contractRepository.findByIds(filter.extractOriginalContractIds(amendmentContracts));
                
                // determina a relação do contrato original com o contrato assinado
                if ( !originalContracts.isEmpty() ) {

                    Map<Id, Contract> indexedOriginalContracts = filter.indexById(originalContracts);
        
                    // determina o contrato original com base no novo contrato assinado e
                    // atualiza o contrato original como Inativado
                    for (Contract amendmentContract : amendmentContracts ) {

                        Contract originalContract = indexedOriginalContracts.get (amendmentContract.OriginalContract__c);

                        originalContract.Status = 'Inativado';

                    }
                    //RETORNA UMA LISTA QUE PRECISA SER ARMAZENADA EM UMA VARIÁVEL
                    contractRepository.save(originalContracts);

                }

            }

        }
            
    }
        
}
