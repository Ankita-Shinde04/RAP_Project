@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
 serviceQuality: #A,
 sizeCategory: #S,
 dataClass: #MASTER
 }
define view entity ZDI_CUSTOMER_VH
  as select from zdt_customer
{
      @ObjectModel.text.element: [ 'CustomerName' ]
      @UI.textArrangement: #TEXT_LAST
  key customernumber as CustomerNumber,
      @Semantics.text: true
      customer_name  as CustomerName
}
