<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청</title>
<style>
	table {width="75%"}
	
</style>
<%	String courseID = null;
	String courseNo = null;
	String courseName = null;
	String courseCredit = null;
	String p_id= null;
	String profName = null;
	String t_year = null;
	String t_sem = null;
	String t_day = null;
	String t_hour = null;
	String t_room = null;
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1616612";
	String passwd ="2997";
	String mySQL = null;
	Connection myConn = null;
	Statement stmt = null;
	ResultSet myResultSet = null;
%>
</head>
<body>
<%@include file="top.jsp" %>
<pre><%out.println(); out.println(); %></pre>
<pre><%out.println(); out.println(); %></pre>
<% if (stu_mode) { %>
<table id = "courseTable" width="75%" align="center" border>
<form method="post">
<tr>
<td><div align="center">과목 id</div></td>
<td><div align="center">학점</div></td>
<td><div align="center">학기</div></td>
<td><div align="center">과목 이름</div></td>
<td><div align="center">요일 및 시간</div></td>
<td><div align="center">담당 교수</div></td>
<td><div align="center">강의실</div></td>
<td><div align="center">신청</div></td>
</tr>
<%	if (session_id != null){
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
			mySQL = "select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no";
			myResultSet = stmt.executeQuery(mySQL);
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			ResultSet pResultSet = null;
			while(myResultSet.next()) {
				courseID = myResultSet.getString("c_id");
				courseNo = myResultSet.getString("c_no");
				courseName = myResultSet.getString("c_name");
				courseCredit = myResultSet.getString("c_credit");
				profName = myResultSet.getString("p_name");
				t_year = myResultSet.getString("t_year");
				t_sem = myResultSet.getString("t_sem");
				p_id = myResultSet.getString("p_id");
				t_day = myResultSet.getString("t_day");
				t_hour = myResultSet.getString("t_hour");
				t_room = myResultSet.getString("t_room");
				out.println("<tr>");
				out.println("<td><div align=\"center\">" + courseID + "</div></td>");
				out.println("<td><div align=\"center\">" + courseCredit + "</div></td>");
				out.println("<td><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
				out.println("<td><div align=\"center\">" + courseName + " 0" + courseNo +"</div></td>");				
				out.println("<td><div align=\"center\">" + t_day + "/" + t_hour + "</div></td>");
				out.println("<td><div align=\"center\">" + profName + "</div></td>");
				out.println("<td><div align=\"center\">" + t_room + "</div></td>");
%>				<td><div align="center"><a href="insert_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>&c_id=<%=courseID%>&c_no=<%=courseNo%>&e_year=<%=t_year%>&e_sem=<%=t_sem%>">신청</a></div></td>
				</tr>
<%
			}	
			stmt.close();
			myConn.close();
		}
	}
	else {
		%>
		<script>
			alert("로그인 후 이용해주세요.");
			location.href="login.jsp";
		</script>
		<% 
	}
%>
</form>
</table><%
}else { /*professor mode*/
	if (session_id != null) {
	%>
	<table id=newCourseTable align="center" bgcolor="#FFFFFF" border>
	<form method="post" action="insert_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>">
	<tr>
	<td><div align="center">과목 이름</div></td>
	<td><div align="center">요일</div></td>
	<td><div align="center">시간</div></td>
	<td><div align="center">장소</div></td>
	<td><div align="center">인원</div></td>
	<td><div align="center">학점</div></td>
	<td><div align="center">   </div></td>
	</tr>
	<tr>
	<td><div align="center"><input type="text" name="courseName"></div></td>
	<td><div align="center">
	<input type="checkbox" name="courseDay" value="mon">월
	<input type="checkbox" name="courseDay" value="tue">화
	<input type="checkbox" name="courseDay" value="wed">수
	<input type="checkbox" name="courseDay" value="thu">목
	<input type="checkbox" name="courseDay" value="fri">금
	</div></td>
	<td><div align="center">
	<input type="text" style="width:20px" name="startHour" > :
	<input type="text" style="width:30px" name="startMinute"> ~
	<input type="text" style="width:20px" name="endHour"> :
	<input type="text" style="width:30px" name="endMinute"></div></td>
	<td><div align="center">
	<select name="courseRoom" style="width:80px">
	<option value="명신관">명신관</option>
	<option value="순헌관">순헌관</option>
	<option value="진리관">진리관</option>
	<option value="새힘관">새힘관</option>
	<option value="과학관">과학관</option>
	<option value="수련교수회관">수련교수회관</option>
	</select>
	<input type="text" style="width:40px" name="courseRoomNo">호</div></td>
	<td><div align="center"><input type="text" style="width:40px" name="courseMax"></div></td>
	<td><div align="center">
	<select name="courseUnit">
	<option value=3>3</option>
	<option value=2>2</option>
	<option value=1>1</option>
	</select>
	</div></td>
	<td><div align="center"><input type="submit" name="submit" value="추가"></div></td>
	</tr>
	</table>
	<%
	}
	else {
		%>
		<script>
			alert("로그인 후 이용해주세요.");
			location.href="login.jsp";
		</script>
		<% 
	}
} 
%>
</body>
</html>