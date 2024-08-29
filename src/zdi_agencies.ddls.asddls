@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface: Agencies Master Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDI_AGENCIES
  as select from zdt_agency
{
      @UI.textArrangement: #TEXT_LAST
      @ObjectModel.text.element: [ 'AgencyName' ]
  key agency_id             as AgencyId,
      @Semantics.name.fullName: true
      @Semantics.text: true
      name                  as AgencyName,
      @Semantics.telephone.type: [ #WORK ]
      phone_number          as PhoneNumber,
      @Semantics.eMail.address: true
      email_address         as EmailAddress,
      @Semantics.address.street: true
      street                as Street,
      @Semantics.address.city: true
      city                  as City,
      @Semantics.address.region: true
      state                 as State,
      @Semantics.address.zipCode: true
      zip_code              as ZipCode,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt:  true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt
}
