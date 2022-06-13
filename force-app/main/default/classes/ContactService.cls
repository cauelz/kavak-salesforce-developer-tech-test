public class ContactService {

    public static OpportunityRepository opportunityRepository;

    static {
        opportunityRepository = new OpportunityRepository();
    }

    public void updateOpportunitiesFullName(Map<Id, Contact> contactMappedByAccountId) {

        if(contactMappedByAccountId.isEmpty()) return;

        List<Opportunity> opportunities = opportunityRepository.getClosedOpportunitiesByAccountIds(contactMappedByAccountId.keySet());

        if(opportunities == null || opportunities.isEmpty()) return;

        for(Opportunity opportunity : opportunities) {
            opportunity.ContactFullName__c = contactMappedByAccountId.get(opportunity.AccountId).FirstName + ' ' + contactMappedByAccountId.get(opportunity.AccountId).LastName;
        }

        try {

            update opportunities;

        } catch (Exception e) {

            System.debug(e.getMessage());

        }

    }
}
