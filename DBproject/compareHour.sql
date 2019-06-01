create or replace function compareHour(
 teachHour IN NUMBER,
 insertHour IN NUMBER)
 RETURN NUMBER
IS
 startTime NUMBER;
 endTime NUMBER;
 insertStartTime NUMBER;
 insertEndTime NUMBER;
 conflict_checker NUMBER;
BEGIN
 conflict_checker := 0;
 startTime := 0;
 endTime := 0;
 insertStartTime := 0;
 insertEndTime := 0;

 makeTime(teachHour, startTime, endTime);
 makeTime(insertHour, insertStartTime, insertEndTime);

IF (insertStartTime >= startTime and insertStartTime <= endTime) THEN
  conflict_checker := conflict_checker + 1;
ELSIF (insertEndTime >= startTime and insertEndTime <= endTime) THEN
 conflict_checker := conflict_checker + 1;
ELSIF (insertStartTime <= startTime and insertEndTime >= endTime) THEN
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
