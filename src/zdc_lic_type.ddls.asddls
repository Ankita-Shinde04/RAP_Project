@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Licensing Type Composition View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZDC_LIC_TYPE
  provider contract transactional_query
  as projection on ZDR_LIC_TYPE
{
  key Licencetypeid,
      Licencetypename,
      Description,
      Validityperiod,
      Renewalrequired,

      @Semantics.user.createdBy: true
      LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt
}
