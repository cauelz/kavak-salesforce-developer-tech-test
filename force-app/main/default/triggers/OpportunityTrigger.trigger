trigger OpportunityTrigger on Opportunity (before insert, before update) {


    switch on Trigger.operationType {

        when BEFORE_INSERT {
            
        }

        when AFTER_INSERT {
            
        }
        
        when BEFORE_UPDATE {

        }
    }

}