trigger borrowingTrigger on Library_Item__c (before update) {
    for(Library_Item__c currItem: Trigger.new){
        
        if (currItem.Item_Status__c == 'Borrowed'){
            if(currItem.BorrowedTo__c == null){
                currItem.addError('Please input a borrower');
            }
        }
    }
}