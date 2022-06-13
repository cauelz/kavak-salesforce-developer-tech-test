public class OpportunityTH {

    public static OpportunityService opportunityService;
    public static final String CLOSE_WON_STAGENAME= 'Closed Won';

    static {

        opportunityService = new OpportunityService();

    }

    public static void afterUpdateHandler(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunity) {

        opportunityService.createOpportunitiesBasedOnClosedWonOpportunities(opportunitiesUpdatedToClosedWon(newOpportunities, oldOpportunity));
        OpportunityIntegrationService.execute(notifyExternalSystem(newOpportunities, oldOpportunity));

    }

    public static void afterInsertHandler(List<Opportunity> newOpportunities) {

        opportunityService.sendEmailToOwnerWhenOpportunityIsCreated(newOpportunities);
        
    }


    public static List<Opportunity> opportunitiesUpdatedToClosedWon(List<Opportunity> opportunities, Map<Id, Opportunity> oldOpportunity) {

        List<Opportunity> closedWonOpportunities = new List<Opportunity>();

        if(opportunities == null || opportunities.isEmpty()) return closedWonOpportunities;

        for(Opportunity opportunity : opportunities) {

            if(opportunity.StageName != oldOpportunity.get(opportunity.Id).StageName && opportunity.StageName == CLOSE_WON_STAGENAME) {

                closedWonOpportunities.add(opportunity);

            }
        }

        return closedWonOpportunities;

    }

    public static String notifyExternalSystem(List<Opportunity> opportunities, Map<Id, Opportunity> oldOpportunity) {

        List<Opportunity> opportunitiesToSend = new List<Opportunity>();
        
        if(opportunities == null || opportunities.isEmpty()) return JSON.serialize(opportunitiesToSend);

        for(Opportunity opportunity : opportunities) {

            if(opportunity.StageName != oldOpportunity.get(opportunity.Id).StageName && opportunity.isClosed) {
                opportunitiesToSend.add(opportunity);
            }

        }

        return JSON.serialize(opportunitiesToSend, true);

    }
}
