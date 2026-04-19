@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Child View Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKS_BOOKING_SUPPL as select from /dmo/booksuppl_m
association to parent ZKS_BOOKING as _booking
on $projection.TravelId = _booking.TravelId
and $projection.BookingId = _booking.BookingId
association[1..1] to  ZKS_R_TRAVEL as _travel
on $projection.TravelId = _travel.TravelId
association[1..1] to /DMO/I_Supplement as _supplement
on $projection.SupplementId = _supplement.SupplementID
association[1..1] to /DMO/I_SupplementText as _supplementText
on $projection.SupplementId = _supplementText.SupplementID
{
    
   key /dmo/booksuppl_m.travel_id as TravelId,
   key /dmo/booksuppl_m.booking_id as BookingId,
   key /dmo/booksuppl_m.booking_supplement_id as BookingSupplementId,
   /dmo/booksuppl_m.supplement_id as SupplementId,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   /dmo/booksuppl_m.price as Price,
   /dmo/booksuppl_m.currency_code as CurrencyCode,
   @Semantics.systemDateTime.lastChangedAt: true
   /dmo/booksuppl_m.last_changed_at as LastChangedAt,
   _booking,
   _travel,
   _supplement,
   _supplementText
}
