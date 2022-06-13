trigger ContactTrigger on Contact (after update) {

    switch on Trigger.operationType {

        when AFTER_UPDATE {
            
            ContactTH.afterUpdateHandler(Trigger.new, Trigger.oldMap);
            
        }
    }
}