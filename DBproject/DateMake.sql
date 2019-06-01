create or replace function DateMaker(
  startHour IN VARCHAR2,
  startMinute IN VARCHAR2,
  endHour IN VARCHAR2,
  endMinute IN VARCHAR2
)
  RETURN VARCHAR2
  IS
    l_hour teach.t_hour%TYPE;
  BEGIN
    l_hour := startHour + ":" + startMinute +"~" + endHour + ";" + endMinute;
    RETURN l_hour;
  END;
  /
