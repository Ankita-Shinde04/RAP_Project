@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Licensing Type Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDR_LIC_TYPE
  as select from ZDI_LIC_TYPE
{

  key   Licencetypeid,
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
