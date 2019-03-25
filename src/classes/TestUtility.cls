/*
 * 	Date: 15/03/2019
 * 	Author: Dhitendra Reddy
 * 	Class Name: TestUtility
 * 	Description: Test class to create test data
 *  
*/
@isTest
public class TestUtility {
    
    public static Contact createContact(){
        Contact cnt = new Contact();
        cnt.LastName = 'Test Contact';
        cnt.Product__c = 'Metal';
        cnt.Email = 'reddy.dhitendra@gmail.com';
        cnt.Home_Country__c = 'DE';
        cnt.Language__c = 'de';
        cnt.survey_date__c = Date.ValueOf(System.now()).addDays(20);
        insert cnt;
        return cnt;
    }
    
    public static Case createCase(){
        Contact cnt = new Contact();
           cnt = createContact();
        Case cs = new Case();
        cs.Subject = 'Test Subject';
        cs.Status = 'New';
        cs.Origin = 'Email';
        cs.ContactId = cnt.Id;
        insert cs;
        return cs;
    }
    
    public static Product__c createProduct(){
        Product__c prd = new Product__c();
        prd.Name = 'Black';
        prd.Price__c = '200';
        prd.Location__c = 'DE';
        insert prd;
        return prd;
    }
}