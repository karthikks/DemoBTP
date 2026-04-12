@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Interface view for Business Partner'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
define view entity ZI_KS_BPA
  as select from zks_bpa
{
  key bp_id        as BuisnessPartnerID,
      bp_role      as BpRole,
      company_name as CompanyName,
      country      as Country
}
