({
    getProductInfo : function(component, event) {
        let action = component.get("c.getProductInformation");
        action.setParams({ caseId : component.get("v.recordId")});
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state == 'SUCCESS'){
                let productInfo = response.getReturnValue();
                component.set("v.ProductInfo", productInfo);
                let prodAction = component.get("c.getProductInfo");
                prodAction.setParams({  location: component.get("v.ProductInfo.Home_Country__c"),
                                      product: component.get("v.ProductInfo.Product__c")});
                prodAction.setCallback(this, function(response) {
                    let state = response.getState();
                    if(state == 'SUCCESS'){
                        component.set("v.products", response.getReturnValue());
                    }
                });
                $A.enqueueAction(prodAction);
            }
        });
        $A.enqueueAction(action);
    }
})