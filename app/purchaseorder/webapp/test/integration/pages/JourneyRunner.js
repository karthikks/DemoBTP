sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"demo/purchaseorder/test/integration/pages/PurchaseOrderSetList",
	"demo/purchaseorder/test/integration/pages/PurchaseOrderSetObjectPage",
	"demo/purchaseorder/test/integration/pages/PurchaseItemsSetObjectPage"
], function (JourneyRunner, PurchaseOrderSetList, PurchaseOrderSetObjectPage, PurchaseItemsSetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('demo/purchaseorder') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetList: PurchaseOrderSetList,
			onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
			onThePurchaseItemsSetObjectPage: PurchaseItemsSetObjectPage
        },
        async: true
    });

    return runner;
});

