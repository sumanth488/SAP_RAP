@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for student details'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZI_STUDENTS
  as select from zms_student
  association [0..1] to ZIGENDER          as _gender on $projection.Gender = _gender.value
  composition [0..*] of Z_ACADAMIC_RESULT as _acadamic
{
  key id                  as Id,
      firstname           as Firstname,
      lastname            as Lastname,
      dob                 as Dob,
      age                 as Age,
      course              as Course,
      courseduration      as Courseduration,
      status              as Status,
      gender              as Gender,
      createdon           as Createdon,
      lastchangedat       as Lastchangedat,
      _gender,
      _gender.dicsription as Genderdesc,
      _acadamic


}
