﻿create or replace function compareHour(
 teach_sHour IN NUMBER,
 teach_eHour IN NUMBER,
 insert_sHour IN NUMBER,
 insert_eHour IN NUMBER)
 RETURN NUMBER
IS
 conflict_checker NUMBER;
BEGIN
 conflict_checker := 0;

IF (insert_sHour >= teach_sHour and insert_sHour <= teach_eHour) THEN
  conflict_checker := conflict_checker + 1;
ELSIF (insert_eHour >= teach_sHour and insert_eHour <= teach_eHour) THEN
 conflict_checker := conflict_checker + 1;
ELSIF (insert_sHour <= teach_sHour and insert_eHour >= teach_eHour) THEN
 conflict_checker := conflict_checker + 1;
END IF;

RETURN conflict_checker;
END;
/

create or replace function compareDay(
  teachDay IN NUMBER,
  insertDay IN NUMBER)
  RETURN number
  IS
  conflict_checker NUMBER;
BEGIN
  conflict_checker := 0;
  IF (teachDay = insertDay) THEN
    conflict_checker := 1;
  ELSIF ((teachDay = 1 and insertDay = 6) or (teachDay = 6 and insertDay = 1)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 2 and insertDay = 7) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 3 and (insertDay = 6 or insertDay = 8)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 4 and insertDay = 7) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 5 and insertDay = 8) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 6 and (insertDay = 1 or insertDay = 3)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 7 and (insertDay = 2 or insertDay = 4)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 8 and (insertDay = 3 or insertDay = 5)) THEN
    conflict_checker := 1;
  END IF;
  RETURN conflict_checker;
END;
/
/*
create or replace function makeDay(
  teachDay IN NUMBER)
  RETURN VARCHAR2
  IS
  strDay VARCHAR2(5);
BEGIN
  strDay := '';
  IF (teachDay = 1) THEN
    strDay := '월';
  ELSIF (teachDay = 2) THEN
    strDay := '화';
  ELSIF (teachDay = 3) THEN
    strDay := '수';
  ELSIF (teachDay = 4) THEN
    strDay := '목';
  ELSIF (teachDay = 5) THEN
    strDay := '금';
  ELSIF (teachDay = 6) THEN
    strDay := '월수';
  ELSIF (teachDay = 7) THEN
    strDay := '화목';
  ELSIF (teachDay = 8) THEN
    strDay := '수금';
  END IF;
  RETURN strDay;
END;
/
*/
