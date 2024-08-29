CLASS zcl_fill_medline_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_medline_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_customers TYPE STANDARD TABLE OF zdt_customer.

*    read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).
*   fill internal table (itab)
    lt_customers = VALUE #(
                ( customernumber  = 'CU01' customer_name = 'Ram Ba' phone_number = '555-5672' email_address = 'ramba@flight.example.com'
                                           street = '456 Oak Ave'   city ='Rivertown'         state ='AX' zip_code = '54601')

                ( customernumber = 'CU02' customer_name = 'Bob Smith'
                              phone_number = '555-5678' email_address = 'bob.smith@example.com'
                              street = '456 Oak Ave'    city = 'Rivertown'  state ='TX'  zip_code = '75001'  )

                ( customernumber = 'CU03' customer_name = 'Carol Davis'
                             phone_number = '555-8765' email_address = 'carol.davis@example.com'
                             street = '789 Birch Rd'    city = 'Lakeville'  state ='NY'  zip_code = '10001'  )

                ( customernumber = 'CU04' customer_name = 'David Lee'
                             phone_number = '555-7766' email_address = 'Carol.Davis@example.com'
                             street = '789 Birch Rd'    city = 'Greendale'  state ='IL'  zip_code = '62701'  )
                             ).





*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zdt_customer.
*   insert the new table entries
    INSERT zdt_customer FROM TABLE @lt_customers.

*   check the result
    SELECT * FROM zdt_customer INTO TABLE @lt_customers.
    out->write( |{ sy-dbcnt }  entries inserted successfully!| ).
  ENDMETHOD.
ENDCLASS.
