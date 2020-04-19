trigger HoldingTrigger on Holding__c (after insert, after update) {
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            HoldingTriggerHandler.handleAfterInsert(Trigger.oldMap, Trigger.newMap);
        }
        
        else if (Trigger.isUpdate) {
            HoldingTriggerHandler.handleAfterUpdate(Trigger.oldMap, Trigger.newMap);
        }
    }
    
}