public abstract class HoldingHistoryTriggerHandler {
    
    // For each holding that was modified, iterate through its histories.
    // Set the all the old histories to not most recent.
    public static void handleAfterInsert(List<Holding_History__c> newHHs) {        
        Set<Id> newHHsIds = new Set<Id>();
        for (Holding_History__c hh : newHHs) {
            newHHsIds.add(hh.Id);
        }
        
        Set<Id> holdingIds = new Set<Id>();
        List<Holding_History__c> hhs = new List<Holding_History__c>();
        
        for(Holding_History__c hh : newHHs) {
            if (!holdingIds.contains(hh.Holding__c)) {
                holdingIds.add(hh.Holding__c);
            }
        }
        
        for(Id holdingId : holdingIds) {
            hhs = [SELECT Id, Holding__c, Most_Recent__c
                   FROM Holding_History__c
                   WHERE Holding__c = :holdingId
                   AND Id NOT IN :newHHsIds];
            
            if (!hhs.isEmpty()) {
                // HoldingTriggerHandler manages setting this to true.
                // Exclude the one that is already true.
                for (Holding_History__c hh : hhs) {
                    hh.Most_Recent__c = false;
                }                
            }
            
        }
        
        if (!hhs.isEmpty()) {
            update hhs;
        }
    }
}