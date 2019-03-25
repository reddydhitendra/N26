/*
* 	Date: 15/03/2019
* 	Author: Dhitendra Reddy
* 	Class Name: CustomerSurveyTest
* 	Description: Test class for CustomerSurvey
*  
*/
@isTest
public class CustomerSurveyTest {
    @isTest
    public static void schedularTest(){
        
        String CRON_EXP = '0 0 0 1 1 ? *';
        Test.startTest();
        
        String jobId = System.schedule('ScheduleApexClassTest', CRON_EXP, new CustomerSurvey());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        Test.stopTest();
    }
    @isTest
    public static void batchTest(){
        TestUtility.createContact();
        Test.startTest();
        CustomerSurvey cs = new CustomerSurvey();
         DataBase.executeBatch(cs); 
        Test.stopTest();
    }
    
}