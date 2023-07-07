trigger EmployeeDeleteHandler on Employee__c (before delete) {
    for (Employee__c a : [SELECT Id FROM Employee__c
                     WHERE Id IN (SELECT BorrowedTo__c FROM Library_Item__c) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete employee with borrowed Items.');
    }
}