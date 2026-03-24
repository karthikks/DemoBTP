namespace index.cds;
using { index.db.master as master, index.db.transaction as transaction } from './datamodel';
context CDSViews {
    define view![POWorkList] as 
    select from transaction.purchaseorder
    {
        key ID as![PONodeKey],
        key Items.ID as![POItemNodeKey],
        key PO_ID as![PurchaseOrderId],
        key Items.PO_ITEM_POS as![ItemPosition],
        PARTNER_GUID.BP_ID as![PartnerId],
        PARTNER_GUID.COMPANY_NAME as![CompanyName],
        GROSS_AMOUNT as![GrossAmount],
        NET_AMOUNT as![NetAmount],
        TAX_AMOUNT as![TaxAmount],
        CURRENCY as![CurrencyCode],
        OVERALL_STATUS as![OverallStatus],
        Items.PRODUCT_GUID.PRODUCT_ID as![ProductId],
        PARTNER_GUID.ADDRESS_GUID.CITY as![City],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country]
    }
    define view![productValueHelp] as
    select from master.product
    {
@EndUserText.label:[
{
language:'EN',
text:'Product Id'
},
{
    language:'DE',
    text:'Prodcuct Id'
}
]
  PRODUCT_ID as![ProductId],
@EndUserText.label:[
{
language:'EN',
text:'Descriptiom'
},
{
    language:'DE',
    text:'Desdstyi'
}
]
DESCRIPTION as![DESCRIPTION]
    }
    define view![ItemView]
    as select from transaction.poitems
    {
        key PARENT_KEY.PARTNER_GUID.NODE_KEY as![CustomerId],
        key PRODUCT_GUID.NODE_KEY as![ProductId],
        CURRENCY as![Currency],
        GROSS_AMOUNT as![GrossAmount],
        NET_AMOUNT as![NetAmount],
        TAX_AMOUNT as![TaxAmount],
        CURRENCY as![CurrencyCode],
        PARENT_KEY.OVERALL_STATUS as![Status],
    }
    define view![ProdcuctView] as 
    select from  master.product
mixin
{
    PO_ORDER:Association to many ItemView on PO_ORDER.ProductId = $projection.ProductId
} into 
{
    NODE_KEY as![ProductId],
    DESCRIPTION as![Description],
    CATEGORY as![Category],
    PRICE as![Price],
    SUPPLIER_GUID.BP_ID as![SupplierId],
    SUPPLIER_GUID.COMPANY_NAME as![CompanyName],
    SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
    PO_ORDER as![To_Items]
};
define view CProductValuesView
as select from ProdcuctView
{
    ProductId,
    Country,
    round(sum(To_Items.GrossAmount),2) as![TotalAmount],
    To_Items.CurrencyCode as![CurrencyCode]
}group by ProductId, Country,To_Items.CurrencyCode
}

