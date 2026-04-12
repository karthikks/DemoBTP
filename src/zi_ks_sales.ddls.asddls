@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Interface view for Sales Order'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #FACT
define view entity ZI_KS_SALES
  as select from zks_so_hdr as head
  association of one to many zks_so_itm as _items on $projection.OrderId = _items.order_id
{
  key head.order_id        as OrderId,
  key _items.item_id       as ItemId,
      head.order_no        as orderNo,
      _items.product       as Product,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _items.amount        as Amount,
      _items.currency_code as CurrencyCode,
      @Semantics.quantity.unitOfMeasure: 'uom'
      _items.qty           as Qty,
      _items.uom           as Uom,
      head.buyer           as Buyer

}
