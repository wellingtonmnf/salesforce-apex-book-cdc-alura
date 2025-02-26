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

            InactivateOriginalContractEnricher inactivateOriginalContract = new InactivateOriginalContractEnricher();
            
            List<Contract> amendmentContracts = filter.byChangedToSignedStatus(newContracts, oldContracts);

            inactivateOriginalContract.inactivatedBy(amendmentContracts);

        }
            
    }
        
}
