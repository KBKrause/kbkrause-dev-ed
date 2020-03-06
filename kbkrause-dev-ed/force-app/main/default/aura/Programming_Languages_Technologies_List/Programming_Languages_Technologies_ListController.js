({
	init : function(component, event, helper) {
        
		var loadListAction = component.get("c.getLanguagesAndTechnologies");
        loadListAction.setParams({ theProjectId : component.get("v.recordId") });

        loadListAction.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + JSON.stringify(response.getReturnValue()));
                component.set("v.languages", response.getReturnValue().languages);
                component.set("v.technologies", response.getReturnValue().technologies);
            }
            else {
                console.log(response.getReturnValue());
            }
        });

        $A.enqueueAction(loadListAction);
	}
})