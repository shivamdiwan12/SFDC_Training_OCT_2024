/**
 *   Description   	: This class is used to process Account records Asynchronously.
 *
 *   Created By    	: Shivam Diwan
 *
 *   Created Date  	: 12/18/2024
 *
 *   Revision Logs 	: V_1.0 - Created - Shivam Diwan - 12/18/2024
 * 
**/
public class AccountProcessor {

/**
 *   @description    :   This method used to update Contact Count on Account.
 *
 *   @arg            :   List<Id> accountIds
 *
 *   @return         :   Void
 *
 *   @Revision Log   :   V_1.0 - Created - Shivam Diwan - 12/18/2024
 * 
 **/  
    @future
    public static void countContacts(List<Id> accountIds){
        
        //Storing unique Account Ids(not a mandatory step)
        Set<Id> setUniqueAccountIds = new Set<Id>(accountIds);
        
        //List of Accounts to update
        List<Account> listAccounts = new List<Account>();
        
        for(Account acc : [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: setUniqueAccountIds]){
            if(!acc.Contacts.isEmpty())
            	acc.Number_Of_Contacts__c = acc.Contacts.size();
            	listAccounts.add(acc);
        }
        
        if(!listAccounts.isEmpty())
            update listAccounts;
    }
}