@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking CDS Entity as First Child'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #CONSUMPTION
define view entity ZKS_BOOKING as select from /dmo/booking_m
composition[0..*] of ZKS_BOOKING_SUPPL as _suppl
association to parent ZKS_R_TRAVEL as _travel on
$projection.TravelId = _travel.TravelId
association of one to one /DMO/I_Customer as _customer
on $projection.CustomerId = _customer.CustomerID
association of one to one /DMO/I_Carrier as _carrier
on $projection.CarrierId = _carrier.AirlineID
association of one to one /DMO/I_Connection as _connection
on $projection.ConnectionId = _connection.ConnectionID
and $projection.CarrierId = _connection.AirlineID
association of one to one /DMO/I_Booking_Status_VH as _bookingstat
on $projection.BookingStatus = _bookingstat.BookingStatus
{
   key travel_id as TravelId,
   key booking_id as BookingId,
   booking_date as BookingDate,
   customer_id as CustomerId,
   carrier_id as CarrierId,
   connection_id as ConnectionId,
   flight_date as FlightDate,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   flight_price as FlightPrice,
   currency_code as CurrencyCode,
   booking_status as BookingStatus,
   @Semantics.systemDateTime.localInstanceLastChangedAt: true
   last_changed_at as LastChangedAt,
   _customer,
   _carrier,
   _connection,
   _bookingstat,
   _travel,
   _suppl
}
