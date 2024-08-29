CLASS lhc_agency DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR agency RESULT result.

    METHODS validatefields FOR VALIDATE ON SAVE
      IMPORTING keys FOR agency~validatefields.

*    METHODS getdefaultsforcreate FOR READ
*      IMPORTING keys FOR FUNCTION agency~getdefaultsforcreate RESULT result.

*    METHODS massdownload FOR READ
*      IMPORTING keys FOR FUNCTION agency~massdownload RESULT result.

*    METHODS validateexcel FOR MODIFY
*      IMPORTING keys FOR ACTION agency~validateexcel RESULT result.
*    METHODS massupload FOR MODIFY
*      IMPORTING keys FOR ACTION agency~massupload RESULT result.
*    METHODS massdownload FOR READ
*      IMPORTING keys FOR FUNCTION agency~massdownload REQUEST requested_fields RESULT result.
    CLASS-METHODS get_next_id IMPORTING agency_id TYPE /dmo/agency_id RETURNING VALUE(r_next_id) TYPE /dmo/agency_id.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE agency.

    CLASS-DATA: lv_id TYPE /dmo/agency_id.
    CLASS-DATA: lv_flag TYPE abap_boolean.

ENDCLASS.


CLASS lhc_agency IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA lt_entities TYPE TABLE FOR CREATE zdr_agencies\\agency.

    lt_entities = VALUE #(  FOR ls IN entities WHERE ( AgencyId IS INITIAL )
                           ( ls ) ).

    IF lt_entities IS NOT INITIAL.

      " Get Max Agency ID From Persistent Table
      SELECT MAX( agency_id ) FROM zdt_agency INTO @FINAL(lv_max_agency_id).

      " Get Max Agency ID From Draft Table
      SELECT MAX( agencyid ) FROM zdt_agency_d INTO @FINAL(lv_max_draft_id).

      " Determine MAX Agency ID
      DATA(lv_agency_id) = COND #( WHEN lv_max_agency_id > lv_max_draft_id THEN lv_max_agency_id ELSE lv_max_draft_id ).

      " Next MAX ID
      lv_agency_id += 1.
      " Assignment of Key
    ENDIF.
    mapped-agency = VALUE #( FOR entity IN entities
                                LET max_id = lhc_agency=>get_next_id( agency_id = lv_agency_id )
                                IN
                             ( %cid      = entity-%cid
                               %is_draft = entity-%is_draft
                               agencyid  = COND #( WHEN entity-agencyid IS INITIAL
                                                   THEN max_id
                                                   ELSE entity-agencyid ) ) ).
  ENDMETHOD.

  METHOD validatefields.
    DATA lv_email_flag TYPE abap_boolean.

    READ ENTITIES OF zdr_agencies IN LOCAL MODE
         ENTITY Agency
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT FINAL(lt_agency)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(lt_failed)
         " TODO: variable is assigned but never used (ABAP cleaner)
         REPORTED FINAL(lt_reported).
    LOOP AT lt_agency ASSIGNING FIELD-SYMBOL(<fs_agency>).

      " Email Validaton Logic"
      IF <fs_agency>-EmailAddress IS NOT INITIAL.
        FINAL(lo_regex) = NEW cl_abap_regex( pattern     = '\w+(\.\w+)*@(\w+\.)+(\w{2,4})'
                                             ignore_case = abap_true  ) ##REGEX_POSIX.

        FINAL(lo_matcher) = lo_regex->create_matcher( text = <fs_agency>-EmailAddress ).
        IF lo_matcher->match( ) IS INITIAL.
          lv_email_flag = abap_true.
        ELSE.
          lv_email_flag = abap_false.
        ENDIF.
      ENDIF.

      reported-agency = VALUE #( BASE reported-agency
                                 %tky = <fs_agency>-%tky
                                 ( %state_area = 'ST_AGENCY' )
                                 ( %state_area = 'ST_PHONE' )
                                 ( %state_area = 'ST_PHONE2' )
                                 ( %state_area = 'ST_EMAIL' )
                                 ( %state_area = 'ST_EMAIL2' )
                                 ( %state_area = 'ST_STREET' )
                                 ( %state_area = 'ST_STATE' )
                                 ( %state_area = 'ST_CITY' )
                                 ( %state_area = 'ST_ZIPCODE' )
                                 ( %state_area = 'ST_ZIPCODE2' ) ).

      IF
            <fs_agency>-AgencyName            IS INITIAL
         OR <fs_agency>-PhoneNumber           IS INITIAL
         OR strlen( <fs_agency>-PhoneNumber ) <> 10
         OR <fs_agency>-EmailAddress          IS INITIAL
         OR lv_email_flag = abap_true
         OR <fs_agency>-Street                IS INITIAL
         OR <fs_agency>-State                 IS INITIAL
         OR <fs_agency>-City                  IS INITIAL
         OR strlen( <fs_agency>-ZipCode )     <> 5
         OR <fs_agency>-ZipCode               IS INITIAL.

        failed-agency = VALUE #( ( %tky = <fs_agency>-%tky ) ).

        IF <fs_agency>-AgencyName IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky                = <fs_agency>-%tky
                                       %state_area         = 'ST_AGENCY'
                                       %element-AgencyName = if_abap_behv=>mk-on
                                       %msg                = new_message_with_text(
                                                                 severity = if_abap_behv_message=>severity-error
                                                                 text     = 'Agency Name is Mandatory!!' ) ) ).
        ENDIF.

        IF <fs_agency>-PhoneNumber IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky                 = <fs_agency>-%tky
                                       %state_area          = 'ST_PHONE'
                                       %element-PhoneNumber = if_abap_behv=>mk-on
                                       %msg                 = new_message_with_text(
                                                                  severity = if_abap_behv_message=>severity-error
                                                                  text     = 'Phone Number is Mandatory!!' ) ) ).
        ENDIF.

        IF strlen( <fs_agency>-PhoneNumber ) <> 10.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky                 = <fs_agency>-%tky
                                       %state_area          = 'ST_PHONE2'
                                       %element-PhoneNumber = if_abap_behv=>mk-on
                                       %msg                 = new_message_with_text(
                                           severity = if_abap_behv_message=>severity-error
                                           text     = 'Please Enter 10 digit Phone Number.' ) ) ).
        ENDIF.

        IF <fs_agency>-EmailAddress IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky                  = <fs_agency>-%tky
                                       %state_area           = 'ST_EMAIL'
                                       %element-EmailAddress = if_abap_behv=>mk-on
                                       %msg                  = new_message_with_text(
                                                                   severity = if_abap_behv_message=>severity-error
                                                                   text     = 'Email Address is Mandatory!!' ) ) ).
        ENDIF.

        IF lv_email_flag = abap_true.

          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky                  = <fs_agency>-%tky
                                       %state_area           = 'ST_EMAIL2'
                                       %element-EmailAddress = if_abap_behv=>mk-on
                                       %msg                  = new_message_with_text(
                                                                   severity = if_abap_behv_message=>severity-error
                                                                   text     = 'Invalid Email Address!!' ) ) ).
        ENDIF.

        IF <fs_agency>-Street IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky            = <fs_agency>-%tky
                                       %state_area     = 'ST_STREET'
                                       %element-Street = if_abap_behv=>mk-on
                                       %msg            = new_message_with_text(
                                                             severity = if_abap_behv_message=>severity-error
                                                             text     = 'Street Address is Mandatory!!' ) ) ).
        ENDIF.

        IF <fs_agency>-State IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky           = <fs_agency>-%tky
                                       %state_area    = 'ST_STATE'
                                       %element-State = if_abap_behv=>mk-on
                                       %msg           = new_message_with_text(
                                                            severity = if_abap_behv_message=>severity-error
                                                            text     = '(Please choose a valid State!!' ) ) ).
        ENDIF.

        IF <fs_agency>-City IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky          = <fs_agency>-%tky
                                       %state_area   = 'ST_CITY'
                                       %element-City = if_abap_behv=>mk-on
                                       %msg          = new_message_with_text(
                                                           severity = if_abap_behv_message=>severity-error
                                                           text     = 'Please choose a valid City!!!' ) ) ).
        ENDIF.

        IF <fs_agency>-ZipCode IS INITIAL.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky             = <fs_agency>-%tky
                                       %state_area      = 'ST_ZIPCODE'
                                       %element-ZipCode = if_abap_behv=>mk-on
                                       %msg             = new_message_with_text(
                                                              severity = if_abap_behv_message=>severity-error
                                                              text     = 'Zip Code is Mandatory!!' ) ) ).
        ENDIF.

        IF strlen( <fs_agency>-ZipCode ) <> 5.
          reported-agency = VALUE #( BASE reported-agency
                                     ( %tky             = <fs_agency>-%tky
                                       %state_area      = 'ST_ZIPCODE2'
                                       %element-ZipCode = if_abap_behv=>mk-on
                                       %msg             = new_message_with_text(
                                                              severity = if_abap_behv_message=>severity-error
                                                              text     = 'Zip Code must be of 5 Digits!!' ) ) ).
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_next_id.
    lv_id = COND #( WHEN lv_flag = abap_false
                        THEN agency_id
                    ELSE  lv_id + 1 ).
    r_next_id = lv_id.
    lv_flag = abap_true.
  ENDMETHOD.

ENDCLASS.
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
