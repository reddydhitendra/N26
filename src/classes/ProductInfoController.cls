/*
 * 	Date: 15/03/2019
 * 	Author: Dhitendra Reddy
 * 	Class Name: ProductInfoController
 * 	Description: This is a Controller class for Product Info lightining component
 *  
*/
public class ProductInfoController {
    
    /*
     * Method to Product and Home country based on Case Id
*/
    
    
    @AuraEnabled
    public static Contact getProductInformation(Id caseId){
        Contact cnt = new Contact();
        cnt = [SELECT Id,Name,Product__c,Home_Country__c FROM Contact WHERE Id 
               IN(SELECT ContactId FROM Case WHERE Id =: caseId)];
        return cnt;
    }
    
    @AuraEnabled
    public static List<Product__c> getProductInfo(String location, String product){
        System.debug('location :'+location +' '+product);
        List<Product__c> prodList = new List<Product__c>();
        prodList = [SELECT Id,Name,Price__c,Location__c, RecordType.Name 
                    FROM Product__c WHERE Name =:product AND Location__c =: location];
        return prodList;
    }
    
    
}