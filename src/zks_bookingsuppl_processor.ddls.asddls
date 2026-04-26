@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Booking Supplement Processor'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@Metadata.allowExtensions: true
define view entity ZKS_BOOKINGSUPPL_PROCESSOR as projection on ZKS_BOOKING_SUPPL
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _booking:redirected to parent ZKS_BOOKING_PROCESSOR,
    _supplement,
    _supplementText,
    _travel:redirected to ZKS_TRAVEL_PROCESSOR
}
