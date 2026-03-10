@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Course data definition'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZICOURSE
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZCOURSE'  )
{
  key domain_name,
  key value_position,
      @Semantics.language: true
  key language,
      value_low as value,
      @Semantics.text: true
      text as Description
}
