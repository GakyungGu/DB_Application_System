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
  ELSIF ((teachDay = 0 and insertDay = 5) or (teachDay = 5 and insertDay = 0)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 1 and insertDay = 6) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 2 and (insertDay = 5 or insertDay = 7)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 3 and insertDay = 6) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 4 and insertDay = 7) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 5 and (insertDay = 0 or insertDay = 2 or insertDay = 7)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 6 and (insertDay = 1 or insertDay = 3)) THEN
    conflict_checker := 1;
  ELSIF (teachDay = 7 and (insertDay = 2 or insertDay = 4 or insertDay = 5)) THEN
    conflict_checker := 1;
  END IF;
  RETURN conflict_checker;
END;
/