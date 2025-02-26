public with sharing class InactivateOriginalContractEnricher {
    
    ContractRepository repository;
    ContractFilter filter;

    public InactivateOriginalContractEnricher() {
        this.repository = new ContractRepository();
        this.filter = new ContractFilter();
    }

    public List<Contract> inactivatedBy (List<Contract> signedContracts){

        List<Contract> originalContracts = findOriginalContracts(signedContracts);

        if (originalContracts.isEmpty()) {
            return new List<Contract>();
        }

        List<Contract> inactivatedContracts = inactivateOriginalContracts(originalContracts, signedContracts);

        return repository.save(inactivatedContracts);

    }

    private List<Contract> findOriginalContracts(List<Contract> signedContracts) {

        List<String> originalContractIds = filter.extractOriginalContractIds(signedContracts);

        return repository.findByIds(originalContractIds);
    }

    private List<Contract> inactivateOriginalContracts(List<Contract> originalContracts, List<Contract> signedContracts) {

        Map<Id,Contract> indexedOriginalContracts = this.filter.indexById(originalContracts);

        for (Contract signedContract : signedContracts) {
            
            Contract originalContract = indexedOriginalContracts.get(signedContract.OriginalContract__c);

            originalContract.Status = 'Inativado';
        }

        return originalContracts;
    }
}