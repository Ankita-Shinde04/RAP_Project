@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'City Code Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZDI_CITY_VH
  //  with parameters
  //    p_state_id : zde_state_id
  as select from zdt_city_codes
  association [0..1] to ZDI_STATE_VH as _States on $projection.StateId = _States.StateId
{
      @ObjectModel.text.element: [ 'StateName' ]
      @UI.textArrangement: #TEXT_LAST
  key state_id  as StateId,
      @ObjectModel.text.element: [ 'CityName' ]
      @UI.textArrangement: #TEXT_LAST
  key city_id   as CityId,
      @Semantics.text: true
      city_name as CityName,
      @Semantics.text: true
      _States.StateName
}
//where
//  state_id = $parameters.p_state_id
