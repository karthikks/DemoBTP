@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Sales Order'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
define view entity ZCO_KS_SALES
  with parameters
    i_curr :abap.cuky(5)
  as select from ZI_KS_SALES as sales
  association of many to many ZI_KS_PRODUCT as _product on $projection.Product = _product.ProductId
{
  key sales.OrderId,
  key sales.ItemId,
      sales.orderNo,
      sales.Product,
      sales.Amount,
      sales.CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion( amount => Amount,
                           source_currency => CurrencyCode,
                           target_currency => $parameters.i_curr,
                           exchange_rate_date => $session.system_date ) as ConvertedAmount,
      cast('USD' as abap.cuky)                                          as ConvertCurrency,
      sales.Qty,
      sales.Uom,
      sales.Buyer,
      _product.Name                                                     as ProductName,
      _product.Category                                                 as ProductCategory
}
