<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강 신청 삭제</title>
<%
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616612";
String passwd ="2997";
String mySQL = null;
Connection myConn = null;
Statement stmt = null;
CallableStatement cstmt2 = null;
%>
</head>
<body>
<%@include file="top.jsp" %>
<pre><%out.println();%></pre>
<%	ResultSet myResultSet = null;
	CallableStatement cstmt = null;
	System.out.println(stu_mode);
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
		String t_shour = null, t_ehour = null;
		String t_hour = null;
		String t_room = null;
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		}catch(SQLException e1) {
			e1.printStackTrace();
		}
		if (stu_mode) {
			%>
			<table width="75%" align="center" bgcolor="#FFFFFF" border>
			<tr>
			<td><div align="center">과목 id</div></td>
			<td><div align="center">분반</div></td>
			<td><div align="center">학기</div></td>
			<td><div align="center">과목 이름</div></td>
			<td><div align="center">요일 및 시간</div></td>
			<td><div align="center">담당 교수</div></td>
			<td><div align="center">강의실</div></td>
			<td><div align="center">신청</div></td>
			</tr>			
			<%
			try {
				mySQL = "select * from professor p, teach t, course c where p.p_id = t.p_id and t.c_id = c.c_id and t.c_no = c.c_no and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id ="+session_id+")";
				myResultSet = stmt.executeQuery(mySQL);
				cstmt = myConn.prepareCall("{? = call getStrDay(?)}");				
				cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				while(myResultSet.next()) {
					courseID = myResultSet.getString("c_id");
					courseNo = myResultSet.getString("c_no");
					courseName = myResultSet.getString("c_name");
					profName = myResultSet.getString("p_name");
					t_year = myResultSet.getString("t_year");
					t_sem = myResultSet.getString("t_sem");
					p_id = myResultSet.getString("p_id");
					t_day = myResultSet.getString("t_day");
					t_shour = myResultSet.getString("t_shour");
					t_ehour = myResultSet.getString("t_ehour");
					t_room = myResultSet.getString("t_room");
					try {
						cstmt.setInt(2, Integer.parseInt(t_day));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt.execute();
						t_day = cstmt.getString(1);
						cstmt2.setInt(2, Integer.parseInt(t_shour));
						cstmt2.setInt(3, Integer.parseInt(t_ehour));
						cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt2.execute();
						t_hour = cstmt2.getString(1);
					}catch(SQLException e2) {
						e2.printStackTrace();
					}
					out.println("<tr>");
					out.println("<td><div align=\"center\">" + courseID + "</div></td>");
					out.println("<td><div align=\"center\">" + courseNo + "</div></td>");
					out.println("<td><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
					out.println("<td><div align=\"center\">" + courseName + "</div></td>");				
					out.println("<td><div align=\"center\">" + t_day + " " + t_hour + "</div></td>");
					out.println("<td><div align=\"center\">" + profName + "</div></td>");
					out.println("<td><div align=\"center\">" + t_room + "</div></td>");
					%>
					<td><div align="center"><a href="delete_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>&c_id=<%=courseID%>&e_year=<%=t_year%>&e_sem=<%=t_sem%>">삭제</a></div></td>
					</tr>
					<%
				}	
				cstmt.close();
				cstmt2.close();
				stmt.close();
				myConn.close();	
			}
		}
		else { /*professor mode*/
			String t_max = null;
			%>
			<table width="75%" align="center" bgcolor="#FFFFFF" border>
			<tr>
			<td><div align="center">과목 id</div></td>
			<td><div align="center">분반</div></td>
			<td><div align="center">학기</div></td>
			<td><div align="center">과목 이름</div></td>
			<td><div align="center">요일 및 시간</div></td>
			<td><div align="center">강의실</div></td>
			<td><div align="center">정원</div></td>
			<td><div align="center">삭제</div></td>
			</tr>			
			<%
			try {
				mySQL = "select * from teach t, course c where t.c_id=c.c_id and t.c_no=c.c_no and t.p_id='" + session_id + "'";
				myResultSet = stmt.executeQuery(mySQL);
				cstmt = myConn.prepareCall("{? = call getStrDay(?)}");
				cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
			}catch (SQLException ex1) {
				ex1.printStackTrace();
				System.out.println("error 1");
			}finally {
				while(myResultSet.next()) {
					courseID = myResultSet.getString("c_id");
					System.out.println(courseID);
					courseNo = myResultSet.getString("c_no");
					courseName = myResultSet.getString("c_name");
					t_year = myResultSet.getString("t_year");
					t_sem = myResultSet.getString("t_sem");
					t_day = myResultSet.getString("t_day");
					t_shour = myResultSet.getString("t_shour");
					t_ehour = myResultSet.getString("t_ehour");
					t_room = myResultSet.getString("t_room");
					t_max = myResultSet.getString("t_max");
					System.out.println(courseID + courseNo + courseName);
					try {
						cstmt.setInt(2, Integer.parseInt(t_day));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt.execute();
						t_day = cstmt.getString(1);
						cstmt2.setInt(2, Integer.parseInt(t_shour));
						cstmt2.setInt(3, Integer.parseInt(t_ehour));
						cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt2.execute();
						t_hour = cstmt2.getString(1);
						System.out.println(t_hour);
					}catch(SQLException e2) {
						e2.printStackTrace();
					}
					out.println("<tr>");
					out.println("<td><div align=\"center\">" + courseID + "</div></td>");
					out.println("<td><div align=\"center\">" + courseNo + "</div></td>");
					out.println("<td><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
					out.println("<td><div align=\"center\">" + courseName + "</div></td>");				
					out.println("<td><div align=\"center\">" + t_day + " " + t_hour + "</div></td>");
					out.println("<td><div align=\"center\">" + t_room + "</div></td>");
					out.println("<td><div align=\"center\">" + t_max + "</div></td>");
					%>
					<td><div align="center"><a href="delete_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>&c_id=<%=courseID%>&c_no=<%=courseNo%>&t_year=<%=t_year%>&t_sem=<%=t_sem%>">삭제</a></div></td>
					</tr>
					<%
				}	
				cstmt.close();
				cstmt2.close();
				stmt.close();
				myConn.close();
			}

		}
	}
%>

</table>
</body>
</html>