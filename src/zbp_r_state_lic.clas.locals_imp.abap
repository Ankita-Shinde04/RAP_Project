CLASS lhc_ZR_STATE_LIC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR State_License RESULT result.
    METHODS validatefields FOR VALIDATE ON SAVE
      IMPORTING keys FOR state_license~validatefields.

ENDCLASS.

CLASS lhc_ZR_STATE_LIC IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.





  METHOD validateFields.



    READ ENTITIES OF zr_state_lic IN LOCAL MODE
        ENTITY State_License
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(it_statdata)
        REPORTED DATA(it_reported)
        FAILED DATA(it_failed).

    "validate the data
    LOOP AT it_statdata INTO DATA(is_statdata).

      "CLEARING OLD MESSAGES
      reported-state_license = VALUE #(
                                                BASE reported-state_license
                                                  (
                                                    %tky = is_statdata-%tky
                                                    %state_area = 'VALIDATE_STATEID'
                                                   )


                                                  (
                                                    %tky = is_statdata-%tky
                                                    %state_area = 'VALIDATE_LICID'
                                                   )

                                            ).


      "VALIDATE THE DATA

      IF is_statdata-Stateid       IS INITIAL OR
         is_statdata-Licensetypeid IS INITIAL.

        failed-state_license = VALUE #( ( %tky = is_statdata-%tky ) ).



        IF is_statdata-Stateid IS INITIAL.
          reported-state_license = VALUE #( BASE reported-state_license
                                                         ( %tky           = is_statdata-%tky
                                                           %state_area    = 'VALIDATE_STATEID'
                                                           %element-stateid = if_abap_behv=>mk-on
                                                           %msg           = new_message_with_text(
                                                                                severity = if_abap_behv_message=>severity-error
                                                                                text     = 'StateId is Required!' ) ) ).

        ENDIF.



        IF is_statdata-Licensetypeid IS INITIAL.

          reported-state_license = VALUE #( BASE reported-state_license
                                               ( %tky           = is_statdata-%tky
                                                 %state_area    = 'VALIDATE_LICID'
                                                 %element-licensetypeid = if_abap_behv=>mk-on
                                                 %msg           = new_message_with_text(
                                                                      severity = if_abap_behv_message=>severity-error
                                                                      text     = 'LicencetypeId is Required!' ) ) ).

        ENDIF.
      ENDIF.

    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
