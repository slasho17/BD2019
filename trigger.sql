-- ainda nao fiz
create or replace 
Trigger MYTRIGGER
After Insert On Table1
Referencing Old As "OLD" New As "NEW" 
For Each Row 
Begin
  Declare Counter Int;
  Select Count(*) From Table2 Where Table2."Email" = :New.U_MAIL  Into Counter;
  IF Counter < 1 THEN
    //INSERT Statement here... 
  END IF;
End;