<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
<%
/*학기 별로 검색 추가*/
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1616612";
	String passwd ="2997";
	String mySQL = null;
	Connection myConn = null;
	Statement stmt = null;
	CallableStatement cstmt = null, cstmt2 = null;
%>
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">	
<style type="text/css">
	body{
		font-family: 'Jua', sans-serif;
	}
	.insert {
		border-radius: 10px;
		border: 1px solid #000000;
		bgcolor: #cdcdcd;	
	}
	table {
		border-collapse:collapse;
	}
	td {
		border: 1px solid #cdcdcd;
	}
</style>	
</head>
<body>
<%@include file="top.jsp" %>
<pre><%out.println();%></pre>
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
		String t_shour = null, t_ehour = null;
		String t_room = null;
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		}catch(SQLException e1) {
			System.out.println("section 1 error");
			e1.printStackTrace();
		}
		if (stu_mode) {
			%>
			<table id = "s_select" width="75%" align="center" bgcolor="#FFFFFF" border>
			<tr>
			<td><div align="center">과목 id</div></td>
			<td><div align="center">분반</div></td>
			<td><div align="center">학기</div></td>
			<td><div align="center">과목 이름</div></td>
			<td><div align="center">요일 및 시간</div></td>
			<td><div align="center">담당 교수</div></td>
			<td><div align="center">강의실</div></td>
			</tr>			
			<%
			try {
				mySQL = "select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id ="+session_id+")";
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
					out.println("</tr>");
				}	
				%>
				<%//시간표 생성 %>
				<table width="75%" height="100%" align="center" style="margin-top:10px" border>
				<colgroup width="10px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<tr>
				<th>시간</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				</tr>

				<%
				int table_day = 0;
				int s_time = 0, e_time = 0;
				int rowspan = 0;
				String table_time = null;
				String table_cname = null;
				String table_room = null;
				String str = null;
				String[][] table_data= new String[10][5];
				int [] time = {9, 10, 11, 12, 1, 2, 3, 4, 5, 6};
				boolean[][] isRowSpanned = new boolean[10][5];
				try {
					mySQL = "select c.c_name, t.t_shour, t.t_ehour, t.t_day, t.t_room from course c, teach t where c.c_id=t.c_id and c.c_no=t.c_no and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id='" + session_id +"') ";
					myResultSet = stmt.executeQuery(mySQL);
				}catch(SQLException e3){
					e3.printStackTrace();
				}
				finally {
					int row = 0, column = 0;
					while(myResultSet.next()) {						
						table_day = Integer.parseInt(myResultSet.getString("t_day"));
						s_time = Integer.parseInt(myResultSet.getString("t_shour"));
						e_time = Integer.parseInt(myResultSet.getString("t_ehour"));
						table_cname = myResultSet.getString("c_name");
						table_room = myResultSet.getString("t_room");
						str = table_cname + "<br>" + table_room;
						s_time = s_time / 100; e_time = e_time / 100;
						row = s_time - 9; rowspan = e_time - s_time;
						switch(table_day) {
						case 0 : 
							column = 0;
							table_data[row][0] = str; break;
						case 1:
							column = 1;
							table_data[row][1] = str; break;
						case 2:
							column = 2;
							table_data[row][2] = str; break;
						case 3:
							column = 3;
							table_data[row][3] =str; break;
						case 4:
							column = 4;
							table_data[row][4] = str; break;
						case 5:
							column = 0;
							table_data[row][0] = str;
							table_data[row][2] = str;
							break;
						case 6:
							column = 1;
							table_data[row][1] = str;
							table_data[row][3] = str;
							break;
						case 7:
							column = 2;
							table_data[row][2] = str;
							table_data[row][4] = str;
							break;
						}
						for (int i = 1, r = row+1; i < rowspan; r++, i++) {
							isRowSpanned[r][column] = true;
							if (table_day >= 5) {
								isRowSpanned[r][column+2] = true;
							}
						}
					}
				}
				rowspan = 1;
				String bgcolor="#FFFFFF";
				int pass = 0;
				for (int i = 0; i < 10; i++) {
					out.println("<tr height=\"50px\">");
					out.println("<td><div align=\"center\">" + time[i] +"</div></td>");
					for (int j = 0; j < 5; j++) {
						if (table_data[i][j] != null) {
							bgcolor = "#B0C4DE"; 
							for (int k = i+1; k < 10; k++){
								if (isRowSpanned[k][j])
									rowspan++;
								else
									break;
							}
						}
						else {
							table_data[i][j] = "";
						}
						if (!isRowSpanned[i][j]) {
							out.print("<td bgcolor=\" " +bgcolor+ " \" rowspan=\" " + rowspan + "\"><div align=\"center\">");
							out.print(table_data[i][j] + "</div></td>");
						}
						bgcolor = "#FFFFFF";
						rowspan = 1;						
					}
					out.println("</tr>");					
				}
				%>

				</table>
				<%
				cstmt.close();
				cstmt2.close();
				stmt.close();
				myConn.close();
			}
		}
		else { /*professor mode*/
			String t_max = null;
			%>
			<table id="p_select" width="75%" align="center" bgcolor="#FFFFFF" border>
			<tr>
			<td><div align="center">과목 id</div></td>
			<td><div align="center">분반</div></td>
			<td><div align="center">학기</div></td>
			<td><div align="center">과목 이름</div></td>
			<td><div align="center">요일 및 시간</div></td>
			<td><div align="center">강의실</div></td>
			<td><div align="center">정원</div></td>
			</tr>			
			<%
			try {
				mySQL = "select * from teach t, course c where t.p_id=" + session_id + " and t.c_id=c.c_id and t.c_no=c.c_no";
				myResultSet = stmt.executeQuery(mySQL);
				cstmt = myConn.prepareCall("{? = call getStrDay(?)}");
				cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
			}catch (SQLException ex1) {
				ex1.printStackTrace();
			}finally {
				while(myResultSet.next()) {
					courseID = myResultSet.getString("c_id");
					courseNo = myResultSet.getString("c_no");
					courseName = myResultSet.getString("c_name");
					t_year = myResultSet.getString("t_year");
					t_sem = myResultSet.getString("t_sem");
					t_day = myResultSet.getString("t_day");
					t_shour = myResultSet.getString("t_shour");
					t_ehour = myResultSet.getString("t_ehour");
					t_room = myResultSet.getString("t_room");
					t_max = myResultSet.getString("t_max");
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
					out.println("<td><div align=\"center\">" + t_room + "</div></td>");
					out.println("<td><div align=\"center\">" + t_max + "</div></td>");
					out.println("</tr>");
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