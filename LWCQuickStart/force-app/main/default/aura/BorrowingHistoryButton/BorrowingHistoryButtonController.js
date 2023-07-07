({
    
    doInit : function(component, event, helper) {
        component.set('v.columns',[
            
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Library ID', fieldName: 'Library_ID__c', type: 'text'},
            
        ]);
            
            var action=component.get("c.getBorrowingHistory");
            var itemName = component.find("libItem").get("v.value");
            action.setParams({itemNo : itemName})
            action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
            
            var result=response.getReturnValue();
            component.set("v.data",result);
            }
            });
            $A.enqueueAction(action);
            },
            
})