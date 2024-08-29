@EndUserText.label: 'Projection: Agencies Master Data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZDC_AGENCIES
  provider contract transactional_query
  as projection on ZDR_AGENCIES
{
  key AgencyId,
      AgencyName,
      PhoneNumber,
      EmailAddress,
      Street,
      @ObjectModel.text.element: [ 'CityName' ]
      City,
      _City.CityName    as CityName,
      @ObjectModel.text.element: [ 'StateName' ]
      State,
      _States.StateName as StateName,
      ZipCode,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _City,
      _States
}
