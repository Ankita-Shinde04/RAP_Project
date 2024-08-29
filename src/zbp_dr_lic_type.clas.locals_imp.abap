CLASS lhc_ZDR_LIC_TYPE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zdr_lic_type RESULT result.
    METHODS validatefields FOR VALIDATE ON SAVE
      IMPORTING keys FOR zdr_lic_type~validatefields.

ENDCLASS.

CLASS lhc_ZDR_LIC_TYPE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD validateFields.

    READ ENTITIES OF zdr_lic_type IN LOCAL MODE
            ENTITY zdr_lic_type
            ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(it_lic)
            REPORTED DATA(it_reported)
            FAILED DATA(it_failed).


    "validate the data

    LOOP AT it_lic INTO DATA(ls_lic).


      "CLEARING OLD MESSAGES
      reported-zdr_lic_type = VALUE #(
                                                BASE reported-zdr_lic_type
                                                (
                                                    %tky = ls_lic-%tky
                                                    %state_area = 'VALIDATE_LICENCETYPEID'
                                                   )
                                                  (
                                                    %tky = ls_lic-%tky
                                                    %state_area = 'VALIDATE_LICENCETYPENAME'
                                                   )

                                                  (
                                                    %tky = ls_lic-%tky
                                                    %state_area = 'VALIDATE_DESCRIPTION'
                                                   )

                                                   (
                                                    %tky = ls_lic-%tky
                                                    %state_area = 'VALIDATE_RENEWAL'
                                                   )
                                            ).

      IF ls_lic-Licencetypeid IS INITIAL OR
         ls_lic-Licencetypename IS INITIAL OR
         ls_lic-Validityperiod IS INITIAL OR
          ls_lic-Description IS INITIAL.



        failed-zdr_lic_type = VALUE #( ( %tky = ls_lic-%tky ) ).



        IF ls_lic-Licencetypeid IS INITIAL.

          reported-zdr_lic_type = VALUE #( BASE reported-zdr_lic_type
                                       ( %tky           = ls_lic-%tky
                                         %state_area    = 'VALIDATE_LICENCETYPEID'
                                         %element-licencetypeid = if_abap_behv=>mk-on
                                         %msg           = new_message_with_text(
                                                              severity = if_abap_behv_message=>severity-error
                                                              text     = 'LicenceTypeId is Required!' ) ) ).


        ENDIF.



*
        IF ls_lic-Licencetypename IS INITIAL.

          reported-zdr_lic_type = VALUE #( BASE reported-zdr_lic_type
                                       ( %tky           = ls_lic-%tky
                                         %state_area    = 'VALIDATE_LICENCETYPENAME'
                                         %element-licencetypename = if_abap_behv=>mk-on
                                         %msg           = new_message_with_text(
                                                              severity = if_abap_behv_message=>severity-error
                                                              text     = 'LicenceTypeName is Required!' ) ) ).


        ENDIF.


        IF ls_lic-Description IS INITIAL.
          reported-zdr_lic_type = VALUE #( BASE reported-zdr_lic_type
                                       ( %tky           = ls_lic-%tky
                                         %state_area    = 'VALIDATE_DESCRIPTION'
                                         %element-description = if_abap_behv=>mk-on
                                         %msg           = new_message_with_text(
                                                              severity = if_abap_behv_message=>severity-error
                                                              text     = 'Description is Required!' ) ) ).


        ENDIF.

*


      ENDIF.

      IF ls_lic-Validityperiod IS INITIAL.
        reported-zdr_lic_type = VALUE #( BASE reported-zdr_lic_type
                                       ( %tky           = ls_lic-%tky
                                         %state_area    = 'VALIDATE_RENEWAL'
                                         %element-validityperiod = if_abap_behv=>mk-on
                                         %msg           = new_message_with_text(
                                                              severity = if_abap_behv_message=>severity-error
                                                              text     = 'Validityperiod is Required!' ) ) ).


      ENDIF.

    ENDLOOP.

  ENDMETHOD.


ENDCLASS.
