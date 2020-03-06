public class ProgrammingLanguageTech_Controller {

    @AuraEnabled
    public static ListWrapper getLanguagesAndTechnologies(Id theProjectId) {
		ListWrapper returnWrapper = new ListWrapper();
        returnWrapper.languages = [SELECT Id, Programmatic_Language__c, Programmatic_Language__r.Name, Project_Experience__c 
                                   FROM Projects_to_Languages__c
                                   WHERE Project_Experience__c = :theProjectId];
        
        returnWrapper.technologies = [SELECT Id, Technology__c, Technology__r.Name, Project_Experience__c
                                     FROM Projects_to_Frameworks__c
                                     WHERE Project_Experience__c = :theProjectId];
        
        return returnWrapper;
    }
    
    public class ListWrapper {
        @AuraEnabled public List<Projects_to_Languages__c> languages {get; set;}
        @AuraEnabled public List<Projects_to_Frameworks__c> technologies {get; set;}
    }
}