@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'State Licenses Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_STATE_LIC
  as select from ZI_STATE_LIC
{
  key Stateid,
      Licensetypeid,
      @Semantics.user.createdBy: true
      LocalCreatedBy,
      @Semantics.systemDateTime.createdAt:  true
      LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      LocalLastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LastChangedAt
}
