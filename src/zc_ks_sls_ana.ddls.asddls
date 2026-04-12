@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View for Sales Analytics'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
define view entity ZC_KS_SLS_ANA
  as select from ZCO_KS_SALES_CUBE
{
  key Product,
  key CompanyName,
  key ProductCategory,
      CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      ConvertedAmount,
      ConvertCurrency


}
