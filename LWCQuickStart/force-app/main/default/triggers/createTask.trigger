trigger createTask on Invoice__c (after update) {
	for(Invoice__c currItem: Trigger.new){
        
        if (currItem.Status__c == 'Delivered'){
            Task newTask = new Task ();
            newTask.Subject = currItem.Item_Name__c +' Awaiting Processing';
            newTask.WhatId = currItem.Id;
            newTask.Status = 'Not Started';
            newTask.Description = 'Item has been delivered, and is waiting for processing';
            newTask.ActivityDate = system.today()+7;
            
            insert newTask;
        }
    }
}