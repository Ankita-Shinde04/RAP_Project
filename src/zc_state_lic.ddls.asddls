@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'State Licenses Composition View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_STATE_LIC
  provider contract transactional_query
  as projection on ZR_STATE_LIC
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
