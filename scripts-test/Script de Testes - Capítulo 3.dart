Script de Testes - Capítulo 3


SELECT Id, Name, BillingStreet, BillingState, BillingCity FROM Account WHERE BillingState = 'São Paulo'

----------------------------------------------

SELECT Id, ContractNumber, AccountId, Account.Name, Account.BillingAddress FROM Contract WHERE Account.Name = 'Edge Communications' 

----------------------------------------------

SELECT Id, Name, BillingStreet // 1 nível de navegação
, BillingCity__r.Name__c // 2 níveis de navegação
, BillingCity__r.Stace__r.Name // 3 níveis de navegação
, CNAE__r.Description__c 
, CNAE__r.Code__c 
FROM Account 
WHERE Name = 'Edge Communications'

// O SOQL permite até 5 níveis de navegação por relacionamento

----------------------------------------------

//INNER QUERY (SELECT)

SELECT Id, Name
    , (SELECT Id
        , ContractNumber
        , StardDate
        , EndDate
       FROM Contracts) // Nome do objeto no PLURAL
FROM Account
WHERE Name = 'Edge Communications'

// A convenção para inner select em OBJETOS PADRÕES é 
// sempre  utilizar  o  nome  do  objeto  no  plural  

SELECT Id, Name
    , Code__c
    , (SELECT Id
        , Name
       FROM Accounts__r) // Nome do objeto no PLURAL com __r
FROM Advisor__c

// A convenção para inner select em OBJETOS CUSTOMIZADOS é 
// sempre  utilizar  o  nome  do  objeto  no  plural seguido de __r

----------------------------------------------

// SUBQUERY (WHERE)

SELECT Id, Name
FROM Account
WHERE Id IN (SELECT AccountId
                FROM Opportunity
                WHERE StageName = 'Closed Won')

//Esse tipo de subquery só pode ser realizado em campos do 
// tipo Id , isto é, em campos que sejam lookup. 

----------------------------------------------

public List<Account> findByClosedWonOpportunities(){
    return [SELECT Id, Name
            FROM Account
            WHERE Id IN (SELECT AccountId
                            FROM Opportunity
                            WHERE StageName = 'Closed Won')];
}

// Caso não haja resultados, o retorno será uma lista vazia, e não nula

----------------------------------------------

public Account findFirstedgeCommunications(){
    return [SELECT Id, Name
            FROM Account
            WHERE Name = 'Edge Communications'
            ORDER BY CreatedDate 
            LIMIT 1];
}

// Caso não encontre  nenhum  resultado,  será  lançada  uma  exceção
// System.QueryException: List has no rows for assignment to SObject .

----------------------------------------------

List<Opportunity> opportunities;

opportunities = [SELECT Id
                    ,LastModifiedDate, AccountId
                 FROM Opportunity
                 WHERE StageName = 'Closed Lost'
                 ORDER BY LastModifiedDate DESC
                 LIMIT 1];

if (!opportunities.isEmpty()){
    Opportunity opportunity = opportunities.get(0);

    Account account = new Account(Id = opportunity.AccountId);

    account.LastClosedLostOpportunityDate__c = opportunity.LastModifiedDate;
} 

update account;

----------------------------------------------
// Nesse exemplo, quando fazemos a query que retorna um único
// resultado e atribuímos a uma variável que não seja do tipo de uma
// coleção, o APEX lança um erro (Exception) indicando que não foi
// possível obter o resultado


try{

    Opportunity opportunity;

    opportunity = [SELECT Id
                    ,LastModifiedDate, AccountId
                 FROM Opportunity
                 WHERE StageName = 'Closed Lost'
                 ORDER BY LastModifiedDate DESC
                 LIMIT 1];

    if (opportunity != null){

        Account account = new Account(Id = opportunity.AccountId);

        account.LastClosedLostOpportunityDate__c = opportunity.LastModifiedDate;
    } 

    update account;

} catch (QueryException e){
    System.debug ('Erro ao buscar a última oportunidade perdida: ' + e.getMessage());
}

----------------------------------------------
// Código correto:


try{

    List<Opportunity> opportunities;

    opportunities = [SELECT Id
                    ,LastModifiedDate, AccountId
                 FROM Opportunity
                 WHERE StageName = 'Closed Lost'
                 ORDER BY LastModifiedDate DESC
                 LIMIT 1];

    if (!opportunities.isEmpty()){

        Opportunity opportunity = opportunities.get(0);

        Account account = new Account(Id = opportunity.AccountId);

        account.LastClosedLostOpportunityDate__c = opportunity.LastModifiedDate;

        update account;
    } 


} catch (QueryException e){
    System.debug ('Erro ao buscar a última oportunidade perdida: ' + e.getMessage());
}

----------------------------------------------
// Bind variables

String stage = 'Closed Lost';

List<Opportunity> opportunities;

    opportunities = [SELECT Id
                    ,LastModifiedDate, AccountId
                 FROM Opportunity
                 WHERE StageName = :stage
                 ORDER BY LastModifiedDate DESC
                 LIMIT 1];

----------------------------------------------
// WITH SECURITY_ENFORCED

String stage = 'Closed Lost';

List<Opportunity> opportunities;

    opportunities = [SELECT Id
                    ,LastModifiedDate, AccountId
                 FROM Opportunity
                 WHERE StageName = :stage
                 WITH SECURITY_ENFORCED
                 ORDER BY LastModifiedDate DESC
                 LIMIT 1];

// deve ser utilizada com cautela, pois adiciona mais 
// processamento na execução e pode causar  lentidão.

----------------------------------------------
// FUNÇÕES DE AGREGAÇÃO

List<AggregateResult> averageOfSales;

averageOfSales = [SELECT AccountId
                    , AVG(Amount) average
                    FROM Opportunity
                    GROUP BY AccountId];

for (AggregateResult result : averageOfSales){
    System.debug(result.get('AccountId') 
    + ' --- ' 
    + result.get('average'));
}           

----------------------------------------------