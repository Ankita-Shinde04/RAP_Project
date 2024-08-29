@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Licensing Type Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZDI_LIC_TYPE
  as select from zdt_license_ty
{

      @ObjectModel.text.element: [ 'Licencetypename' ]
      @UI.textArrangement: #TEXT_FIRST
  key licencetypeid         as Licencetypeid,
      @Semantics.text: true
      licencetypename       as Licencetypename,
      description           as Description,
      validityperiod        as Validityperiod,
      renewalrequired       as Renewalrequired,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
