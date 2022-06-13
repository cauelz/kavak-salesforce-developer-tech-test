public class OpportunityRepository {

    public List<Opportunity> getClosedOpportunitiesByAccountIds(Set<Id> accountIds) {

        return [SELECT Id, AccountId, ContactFullName__c FROM Opportunity WHERE AccountId IN: accountIds AND isClosed = false];

    }
}
