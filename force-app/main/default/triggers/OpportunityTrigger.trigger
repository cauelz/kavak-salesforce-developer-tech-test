trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {


    switch on Trigger.operationType {

        when BEFORE_INSERT {
            
        }

        when AFTER_INSERT {

            OpportunityTH.afterInsertHandler(Trigger.new);

        }

        when BEFORE_UPDATE {



        }

        when AFTER_UPDATE {
            
            OpportunityTH.afterUpdateHandler(Trigger.new, Trigger.oldMap);

        }
    }

}