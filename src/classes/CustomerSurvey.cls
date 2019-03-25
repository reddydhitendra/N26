/*
 * 	Date: 15/03/2019
 * 	Author: Dhitendra Reddy
 * 	Class Name: CustomerSurvey
 * 	Description: This is a Schedulable Batch class to send emails to customers 
 * 	based on the Survey Date and Language fields on Contact Object
 *  
*/
global class CustomerSurvey implements Schedulable,Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.Batchablecontext bc){

        return Database.getQueryLocator(
            'SELECT Id, Name,Email, Language__c, survey_date__c ' +
            'FROM Contact ' + 
            'WHERE survey_date__c != NULL AND survey_date__c>Today LIMIT '+Limits.getLimitEmailInvocations()
        );
    }
    
    public void execute(SchedulableContext SC) {
        Database.executebatch(new CustomerSurvey());
    }
    public void execute(Database.BatchableContext BC, List<Contact> customerList){
        
        
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> ();
        for(Contact customer : customerList){
            List<String> toAddressEmail = new List<String>();
           toAddressEmail.add(customer.Email);
           Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setSubject(customer.Name +Label.Survey_Email_Subject);
            message.setToAddresses(toAddressEmail);
            if(customer.Language__c != Label.German){
            	message.setPlainTextBody('“Hey '+customer.Name+Label.English_Mail_Greetings+Label.Suvery_URL+customer.Id+'”');
            }
            else{
                message.setPlainTextBody('“Hey '+customer.Name+Label.German_Mail_Greetings+Label.Suvery_URL+customer.Id+'”');
            }
            messages.add(message);
            customer.survey_date__c = NULL;
        }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            //System.debug('The email was sent successfully.');
            Database.update(customerList, false);
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
    public void finish(Database.BatchableContext info){
        
    }
}