@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Status Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
 serviceQuality: #A,
 sizeCategory: #S,
 dataClass: #MASTER
 }
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZDI_STATE_VH
  as select from zdt_state_codes
{
      @UI.textArrangement: #TEXT_LAST
      @ObjectModel.text.element: ['StateName']
  key state_id   as StateId,
      @Semantics.text: true
      state_name as StateName
}
