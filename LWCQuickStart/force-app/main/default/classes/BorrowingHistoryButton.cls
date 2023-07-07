public class BorrowingHistoryButton {
    @AuraEnabled
    public static List<Employee__c> getBorrowingHistory(String itemNo){
        
        //call searchForID method to get the Id 
        Id libItemId = BorrowingHistoryButton.searchForID(itemNo);
        //query Histories for record matching Id, get history items
        List<Library_Item__History>employeeNames = [SELECT OldValue FROM Library_Item__History
                        WHERE parentId=:libItemId and Field ='BorrowedTo__c'
                                 ];
        List< Employee__c > borrowingHistory = new List<Employee__c> ();
        List<String> IdList = new List<String> ();
        for (Integer i=0; i<employeeNames.size(); i++){
            //filter out items with null values or have Ids displayed
           if(employeeNames[i].OldValue!= null && (string.valueOf(employeeNames[i].OldValue).startsWith('a0'))){
              IdList.add(string.valueOf(employeeNames[i].OldValue));
           }
        }
        for(String empID : IdList){
            Employee__c emp = [SELECT Name, Library_ID__c FROM Employee__c 
                              WHERE Id =: empID];
            borrowingHistory.add(emp);
        }
        
        return borrowingHistory;
    }
    
    @AuraEnabled
    public static Id searchForID(String itemNum){
        List<Id> itemIDList = new List<Id>();
        for(Library_Item__c libItem: [SELECT Id FROM Library_Item__c
                              WHERE Item_Number__c=:itemNum]){
                                  itemIDList.add(libItem.id);
                              }
        
        return itemIDList[0];
    }
}