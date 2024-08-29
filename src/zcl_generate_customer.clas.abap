CLASS zcl_generate_customer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GENERATE_CUSTOMER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_customers TYPE STANDARD TABLE OF zdt_city_codes.


*   fill internal table (itab)

*    lt_customers = VALUE #(
*           ( state_id = 'CA' city_id = '001' city_name = 'San Francisco')
*           ( state_id = 'TX' city_id = '002' city_name = 'Austin')
*           ( state_id = 'FL' city_id = '003' city_name = 'Orlando')
*           ( state_id = 'IL' city_id = '004' city_name = 'Springfield')
*           ( state_id = 'NY' city_id = '005' city_name = 'New York') ).








*
*
**   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zdt_agency_d.
**   insert the new table entries
*    INSERT zdt_city_codes FROM TABLE @lt_customers.
*
*    DELETE FROM zdt_brnch_lic_d.

    out->write( |{ sy-dbcnt }  entries inserted successfully!| ).


  ENDMETHOD.
ENDCLASS.
