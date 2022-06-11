public class OpportunityService {

    public void createOpportunitiesBasedOnClosedWonOpportunities(List<Opportunity> opportunities) {

        List<Opportunity> newOpportunities = new List<Opportunity>();

        if(opportunities == null || opportunities.isEmpty()) return;

        for(Opportunity opportunity : opportunities) {

            Opportunity newOpportunity = new Opportunity();

            newOpportunity.OwnerId = opportunity.OwnerId;
            newOpportunity.StageName = 'Needs Analysis';

            newOpportunities.add(newOpportunity);

        }

        try {

            insert newOpportunities;


        } catch (Exception e) {

            System.debug(e.getMessage());

        }
    }

    public void sendEmailToOwnerWhenOpportunityIsCreated(List<Opportunity> opportunities) {

        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();

        List<Id> ids = new List<Id>();

        if(opportunities == null || opportunities.isEmpty()) return;

        EmailTemplate template = getEmailTemplate('NotifyNewOpportunity');

        if(template == null) return;

        for(Opportunity opportunity : opportunities) {

            ids.add(opportunity.OwnerId);

        }

        mail.setTargetObjectIds(ids);
        mail.setTemplateId(template.id);

        Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });

    }

    public static EmailTemplate getEmailTemplate(String apiName) {

        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: apiName ];

        if(template == null) return null;

        return template;

    }

}
