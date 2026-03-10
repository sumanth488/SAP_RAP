CLASS lhc_ZI_STUDENTS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_students RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_students RESULT result.
    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION zi_students~setadmitted RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR studentdetails RESULT result.
    METHODS validateage FOR VALIDATE ON SAVE
      IMPORTING keys FOR studentdetails~validateage.

ENDCLASS.

CLASS lhc_ZI_STUDENTS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setAdmitted.
    MODIFY ENTITIES OF zi_students IN LOCAL MODE
      ENTITY StudentDetails
      UPDATE
      FIELDS (  Status )
      WITH VALUE #(  FOR key IN keys (  %tky = key-%tky Status = abap_true ) )
      FAILED failed
      REPORTED reported.

    "Get the response from the updated record.

    READ ENTITIES OF zi_students IN LOCAL MODE
        ENTITY StudentDetails
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(studentdata).
    result = VALUE #( FOR studentrec IN studentdata
    ( %tky = studentrec-%tky %param = studentrec ) ).
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_students IN LOCAL MODE
    ENTITY StudentDetails
    FIELDS ( Status ) WITH CORRESPONDING #( keys )
    RESULT DATA(Studentadmitted)
    FAILED failed.

    result =
    VALUE #(

    FOR stud IN studentadmitted
    LET statusvalue = COND #(  WHEN stud-Status = abap_true
                               THEN if_abap_behv=>fc-o-disabled
                               ELSE if_abap_behv=>fc-o-enabled )

                               IN ( %tky = stud-%tky %action-setAdmitted =  statusvalue )

                                ).




  ENDMETHOD.

  METHOD validateage.

    READ ENTITIES OF zi_students IN LOCAL MODE
    ENTITY StudentDetails
    FIELDS ( Age ) WITH CORRESPONDING #( keys )
    RESULT DATA(studentage).

    LOOP AT studentage INTO DATA(studentsage).

      IF  studentsage-Age < 21.

        APPEND VALUE #( %tky =  studentsage-%tky    ) TO failed-studentdetails.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                         %msg =  new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'Age can not be les than 21'
                                 ) ) TO reported-studentdetails.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
