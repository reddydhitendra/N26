/*
 * 	Date: 15/03/2019
 * 	Author: Dhitendra Reddy
 * 	Class Name: ProductInfoControllerTest
 * 	Description: Test class for ProductInfoController
 *  
*/
@isTest
public class ProductInfoControllerTest {
    
    @isTest
    public static void getProductInformationTest(){
        Contact cnt = TestUtility.createContact();
        Case cs = TestUtility.createCase();
        Test.startTest();
        ProductInfoController.getProductInformation(cs.Id);
        Test.stopTest();
    }
    
    @isTest
    public static void getProductInfo(){
        Product__c prd = TestUtility.createProduct();
        Test.startTest();
        ProductInfoController.getProductInfo('DE', 'Black');
        Test.stopTest();
    }
}