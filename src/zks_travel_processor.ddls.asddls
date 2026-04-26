@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Travel Processor'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@Metadata.allowExtensions: true
define root view entity ZKS_TRAVEL_PROCESSOR
  as projection on ZKS_R_TRAVEL

{
  key TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      AgencyName,
      CustomerName,
      OverallStatusText,
      statuscolor,
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _agency,
      _booking : redirected to composition child ZKS_BOOKING_PROCESSOR,
      _currency,
      _customer,
      _OverallStatus
}
