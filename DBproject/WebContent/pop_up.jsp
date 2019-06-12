<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" import="java.sql.*" import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분반 추가</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/layout.css" />
<%
	/* 분반 자동 생성  시 나머지 사항(장소, 요일, 시간) 입력 받아서 insert_verify.jsp로 넘기는 기능 */
	String p_id = request.getParameter("id");
	String c_id = request.getParameter("c_id");
	String c_no = null;
	String c_name = null;
	String c_credit = null;
	String t_room = null;
	String t_max = null;
	String t_day = null;
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1616612";
	String passwd ="2997";
	String sSQL = null;
	Connection myConn = null;
	Statement stmt = null;
	CallableStatement cstmt = null;
	ResultSet myResultSet = null;
%>
</head>
<body>
<%	int next_no = 0;
	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		sSQL = "select c_name, c_credit from course where c_id='" + c_id + "'";
		cstmt = myConn.prepareCall("{? = call getNextCno(?)}");
		cstmt.setString(2, c_id);
		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt.execute();
		next_no = cstmt.getInt(1);
		myResultSet = stmt.executeQuery(sSQL);
	}catch(SQLException e){
		e.printStackTrace();
		System.out.print("section 1");
	}finally {
		if(myResultSet.next()) {
			c_name = myResultSet.getString("c_name");
			c_credit = myResultSet.getString("c_credit");
		}
		stmt.close();
		cstmt.close();
		myConn.close();
	}
	boolean myMode = false;
	
%>	

	<table width="75%" align="center" border>
	<form method="post" action="insert_verify.jsp?mode=<%=myMode%>&id=<%=p_id%>&courseName=<%=URLEncoder.encode(c_name,"UTF-8")%>&courseNo=<%=next_no%>&courseUnit=<%=c_credit%>&add=true">
	<tr>
	<td colspan=2><div align="center"><h2 style="background-color: #E0FFDB; font-size:25px;"><%=c_name%> 분반 추가</h2><hr></div></td>
	</tr>
	<tr>
	<td><div align="center">요일</div></td>
	<td><div align="center">
	<input type="checkbox" name="courseDay" value="mon">월
	<input type="checkbox" name="courseDay" value="tue">화
	<input type="checkbox" name="courseDay" value="wed">수
	<input type="checkbox" name="courseDay" value="thu">목
	<input type="checkbox" name="courseDay" value="fri">금 <br><br>
	</div></td>
	</tr>
	<tr>
	<td><div align="center">시간</div></td>
	<td><div align="center">
	<input type="text" style="width:20px" name="startHour" > :
	<input type="text" style="width:30px" name="startMinute"> ~
	<input type="text" style="width:20px" name="endHour"> :
	<input type="text" style="width:30px" name="endMinute">	<br><br>	
	</div></td>
	</tr>
	<tr>
	<td><div align="center">장소</div></td>
	<td><div align="center">
	<select name="courseRoom" style="width:80px">
	<option value="명신관">명신관</option>
	<option value="순헌관">순헌관</option>
	<option value="진리관">진리관</option>
	<option value="새힘관">새힘관</option>
	<option value="과학관">과학관</option>
	<option value="수련교수회관">수련교수회관</option>
	</select>
	<input type="text" style="width:40px" name="courseRoomNo">호<br><br></div></td>
	</tr>
	<tr>
	<td><div align="center">인원</div></td>
	<td><div align="center"><input type="text" style="width:40px" name="courseMax"><br><br></div></td>
	</tr>
	<tr>
	<td colspan=2><div align="center"><input type="submit" value="추가">  <input type="reset" value="취소"></div></td>
	</tr>
	</form>
	</table>
</body>
</html>
