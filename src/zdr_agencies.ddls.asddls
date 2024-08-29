@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root: Agencies Master Data'
define root view entity ZDR_AGENCIES
  as select from ZDI_AGENCIES
    association [0..1] to ZDI_STATE_VH as _States on  $projection.State = _States.StateId
    association [0..1] to ZDI_CITY_VH  as _City   on  $projection.State = _City.StateId
                                                  and $projection.City  = _City.CityId
{
  key AgencyId,
      AgencyName,
      PhoneNumber,
      EmailAddress,
      Street,
      City, 
      State, 
      ZipCode,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      _States,
      _City
}
