@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for acadamic result'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z_ACADAMIC_RESULT
  as select from zacadamic_result
  association to parent ZI_STUDENTS as _student  on $projection.Id = _student.Id
  association to ZICOURSE           as _course   on $projection.Course = _course.value
  association to ZISEMESTER         as _semester on $projection.Semester = _semester.value
  association to ZISEMRES           as _semres   on $projection.Semresult = _semres.value
{
  key id                    as Id,
  key course                as Course,
  key semester              as Semester,
      semresult             as Semresult,
      _course.Description   as course_desc,
      _semester.Description as semester_desc,
      _semres.Description   as semres_desc,
      _student
}
