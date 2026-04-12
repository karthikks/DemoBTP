@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Interface view for Product'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
define view entity ZI_KS_PRODUCT
  as select from zks_product
{
  key product_id as ProductId,
      name       as Name,
      category   as Category,
      @Semantics.amount.currencyCode: 'Currency'
      price      as Price,
      currency   as Currency,
      discount   as Discount
}
