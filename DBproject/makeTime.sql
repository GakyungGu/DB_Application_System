create or replace PROCEDURE makeTime(
  teachHour IN NUMBER,
  startTime OUT NUMBER,
  endTime OUT NUMBER)
IS
BEGIN
  startTime := 0;
  endTime := 0;

  IF (teachHour = 1) THEN
   startTime := 900;
   endTime := 1015;
  ELSIF (teachHour = 2) THEN
   startTime := 1030;
   endTime := 1145;
  ELSIF (teachHour = 3) THEN
   startTime := 1200;
   endTime := 1315;
  ELSIF (teachHour = 4) THEN
   startTime := 1330;
   endTime := 1445;
  ELSIF (teachHour = 5) THEN
   startTime := 1500;
   endTime := 1615;
  ELSIF (teachHour = 6) THEN
   startTime := 1630;
   endTime := 1745;
  ELSIF (teachHour = 7) THEN
   startTime := 830;
   endTime := 1020;
  ELSIF (teachHour = 8) THEN
   startTime := 1000;
   endTime := 1150;
  ELSIF (teachHour = 9) THEN
   startTime := 1100;
   endTime := 1250;
  ELSIF (teachHour = 10) THEN
   startTime := 1200;
   endTime := 1450;
  ELSIF (teachHour = 11) THEN
   startTime := 1500;
   endTime := 1650;
  ELSIF (teachHour = 12) THEN
   startTime := 1530;
   endTime := 1650;
  ELSIF (teachHour = 13) THEN
   startTime := 1700;
   endTime := 1950;
 END IF;
END;
/
