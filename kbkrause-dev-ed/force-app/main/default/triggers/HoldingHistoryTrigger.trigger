trigger HoldingHistoryTrigger on Holding_History__c (after insert) {
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            HoldingHistoryTriggerHandler.handleAfterInsert(Trigger.new);
        }
    }
}