@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity Travel'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define root view entity ZKS_R_TRAVEL
  as select from /dmo/travel_m
  composition [0..*] of ZKS_BOOKING                  as _booking
  association of one to one /DMO/I_Agency            as _agency        on $projection.AgencyId = _agency.AgencyID
  association of one to one /DMO/I_Customer          as _customer      on $projection.CustomerId = _customer.CustomerID
  association of one to one I_Currency               as _currency      on $projection.CurrencyCode = _currency.Currency
  association of one to one /DMO/I_Overall_Status_VH as _OverallStatus on $projection.OverallStatus = _OverallStatus.OverallStatus
{
      @ObjectModel.text.element: [ 'Description' ]
  key travel_id                                                        as TravelId,
      _agency.Name                                                     as AgencyName,
      @ObjectModel.text.element: [ 'AgencyName' ]
      @Consumption.valueHelpDefinition: [{
      entity:{
      name : '/DMO/I_Agency',
      element: 'AgencyID'
      }
       }]
      agency_id                                                        as AgencyId,
      concat(concat(_customer.FirstName,''),_customer.LastName)        as CustomerName,
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{
      entity:{
      name : '/DMO/I_Customer',
      element: 'CustomerID'
      }
      }]
      customer_id                                                      as CustomerId,
      begin_date                                                       as BeginDate,
      end_date                                                         as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee                                                      as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price                                                      as TotalPrice,
      @Consumption.valueHelpDefinition: [{
      entity:{
      name : 'I_Currency',
      element: 'Currency'
      }
      }]
      currency_code                                                    as CurrencyCode,
      case overall_status
      when 'O'
      then 2
      when 'A'
      then 3
      when 'X'
      then 1
      end                                                              as statuscolor,
      description                                                      as Description,
      _OverallStatus._Text[ Language = $session.system_language ].Text as OverallStatusText,
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      @Consumption.valueHelpDefinition: [{
      entity:{
      name : '/DMO/I_Overall_Status_VH',
      element: 'OverallStatus'
      }
      }]
      overall_status                                                   as OverallStatus,
      @Semantics.user.createdBy: true
      created_by                                                       as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                                       as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                                                  as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at                                                  as LastChangedAt,
      _agency,
      _customer,
      _currency,
      _OverallStatus,
      _booking
}
