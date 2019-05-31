<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
<%
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616612";
String passwd ="2997";
String mySQL = null;
Connection myConn = null;
Statement stmt = null;

%>
</head>
<body>
<%@include file="top.jsp" %>
<table width="100%" align="center" bgcolor="#FFFFFF" border>
<tr>
<td><div align="center">과목 id</div></td>
<td><div align="center">과목 번호</div></td>
<td><div align="center">학기</div></td>
<td><div align="center">과목 이름</div></td>
<td><div align="center">요일 및 시간</div></td>
<td><div align="center">담당 교수</div></td>
<td><div align="center">강의실</div></td>
<td><div align="center">신청</div></td>
</tr>
<%	ResultSet myResultSet = null;
	PreparedStatement pstmt = null;
	if(session_id == null) {
		%>
		<script>
			alert("로그인 후 이용해주세요.");
			location.href="login.jsp";
		</script>
		<%
	}
	else {
		String courseID = null;
		String courseNo = null;
		String courseName = null;
		String p_id= null;
		String profName = null;
		String t_year = null;
		String t_sem = null;
		String t_day = null;
		String t_hour = null;
		String t_room = null;
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
//			pstmt = myConn.prepareStatement(arg0);
			mySQL = "select * from professor p, teach t where p.p_id = t.p_id and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id ="+session_id+")";
			myResultSet = stmt.executeQuery(mySQL);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			while(myResultSet.next()) {
				courseID = myResultSet.getString("c_id");
				courseNo = myResultSet.getString("c_no");
//				courseName = myResultSet.getString("c_name");
				profName = myResultSet.getString("p_name");
				t_year = myResultSet.getString("t_year");
				t_sem = myResultSet.getString("t_sem");
				p_id = myResultSet.getString("p_id");
				t_day = myResultSet.getString("t_day");
				t_hour = myResultSet.getString("t_hour");
				t_room = myResultSet.getString("t_room");
				out.println("<tr>");
				out.println("<td><div align=\"center\">" + courseID + "</div></td>");
				out.println("<td><div align=\"center\">" + courseNo + "</div></td>");
				out.println("<td><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
				out.println("<td><div align=\"center\">Unknown</div></td>");				
				out.println("<td><div align=\"center\">" + t_day + "/" + t_hour + "</div></td>");
				out.println("<td><div align=\"center\">" + profName + "</div></td>");
				out.println("<td><div align=\"center\">" + t_room + "</div></td>");
				out.println("</tr>");
			}	
			stmt.close();
			myConn.close();

		}
		
	}
%>

</table>
</body>
</html>