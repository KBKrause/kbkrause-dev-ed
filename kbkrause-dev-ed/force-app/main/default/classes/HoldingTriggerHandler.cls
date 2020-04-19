public abstract class HoldingTriggerHandler {
    
    public static void handleAfterInsert(Map<Id, Holding__c> oldMap, Map<Id, Holding__c> newMap) {
        List<Holding_History__c> newHHs = new List<Holding_History__c>();
        
        // Ids in either map will point to the same sobject record.
        for (Id holdingRecord : newMap.keySet()) {
            Holding_History__c newHH = new Holding_History__c();
            newHH.Holding__c = holdingRecord;
            newHH.Prior_Valuation__c = 0;
            newHH.Current_Valuation__c = newMap.get(holdingRecord).Amount__c;
            newHHs.add(newHH);
        }
        
        if (!newHHs.isEmpty()) {
            insert newHHs;
        }
    }
    
    public static void handleAfterUpdate(Map<Id, Holding__c> oldMap, Map<Id, Holding__c> newMap) {
        List<Holding_History__c> newHHs = new List<Holding_History__c>();
        
        // Ids in either map will point to the same sobject record.
        for (Id holdingRecord : oldMap.keySet()) {
            Holding_History__c newHH = new Holding_History__c();
            newHH.Holding__c = holdingRecord;
            newHH.Prior_Valuation__c = oldMap.get(holdingRecord).Amount__c;
            newHH.Current_Valuation__c = newMap.get(holdingRecord).Amount__c;
            newHHs.add(newHH);
        }
        
        newHHs.get(newHHs.size() - 1).Most_Recent__c = true;
        
        if (!newHHs.isEmpty()) {
            insert newHHs;
        }
    }
}