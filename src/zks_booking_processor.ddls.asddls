@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Booking Processor'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@Metadata.allowExtensions: true
define view entity ZKS_BOOKING_PROCESSOR as projection on ZKS_BOOKING
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    LastChangedAt,
    /* Associations */
    _bookingstat,
    _carrier,
    _connection,
    _customer,
    _suppl:redirected to composition child ZKS_BOOKINGSUPPL_PROCESSOR,
    _travel:redirected to parent ZKS_TRAVEL_PROCESSOR
}
