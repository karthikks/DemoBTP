@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Sales Cube'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #CUBE
define view entity ZCO_KS_SALES_CUBE
  as select from ZCO_KS_SALES(i_curr: 'USD') as sales
  association of many to many ZI_KS_BPA as _business_partner on $projection.Buyer = _business_partner.BuisnessPartnerID
{
  key OrderId,
  key ItemId,
      orderNo,
      Product,
      ProductCategory,
      Amount,
      CurrencyCode,
      ConvertCurrency,
      Buyer,
      @Aggregation.default: #SUM
      ConvertedAmount,
      _business_partner.CompanyName
}
