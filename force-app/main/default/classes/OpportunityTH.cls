public class OpportunityTH {

    public static OpportunityService opportunityService;

    static {

        opportunityService = new OpportunityService();

    }

    public static void afterUpdateHandler(List<Opportunity> newOpportunities) {

        opportunityService.createOpportunitiesBasedOnClosedWonOpportunities(opportunitiesUpdatedToClosedWon(newOpportunities));

    }

    public static void afterInsertHandler(List<Opportunity> newOpportunities) {

        opportunityService.sendEmailToOwnerWhenOpportunityIsCreated(newOpportunities);
        
    }


    public static List<Opportunity> opportunitiesUpdatedToClosedWon(List<Opportunity> opportunities) {

        List<Opportunity> closedWonOpportunities = new List<Opportunity>();

        if(opportunities == null || opportunities.isEmpty()) return closedWonOpportunities;

        for(Opportunity opportunity : opportunities) {

            if(opportunity.StageName == 'Closed Won') {

                closedWonOpportunities.add(opportunity);

            }
        }

        return closedWonOpportunities;

    }
}
