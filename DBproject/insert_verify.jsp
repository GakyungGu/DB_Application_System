<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<meta charset="UTF-8">
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1616612";
	String passwd ="2997";
	String sSQL = null, pSQL = null;
	Connection myConn = null;
	Statement stmt = null;
	CallableStatement cstmt = null;
	ResultSet myResultSet = null;
	String userID = request.getParameter("id");
	String userMode = request.getParameter("mode");
	boolean isSucceed = false;
	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	}catch(SQLException e){
		e.printStackTrace();
		System.out.print("section 1");
	}
	if (userMode.equals("true")) {
		String s_id = request.getParameter("id");
		String c_id = request.getParameter("c_id");
		String c_no = request.getParameter("c_no");
		String result = " ";
		try {
			cstmt = myConn.prepareCall("{call InsertEnroll(?, ?, ?, ?)}");
			
			PreparedStatement pstmt = myConn.prepareStatement("call InsertEnroll(?, ?, ?, ?)");
			cstmt.setString(1, s_id);
			cstmt.setString(2, c_id);
			cstmt.setInt(3, Integer.parseInt(c_no));
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			isSucceed = cstmt.execute();
			result = cstmt.getString(4);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			if (isSucceed) {
				%>
				<script>
					alert("추가되었습니다.");
					location.href="insert.jsp";
				</script>		
				<%
			}
			else {
			%>
			<script>
				alert("<%=result%>");
				location.href="insert.jsp";
			</script>		
			<%
			}
		}
	}
	else { /*professor mode*/
		String p_id = request.getParameter("id");
		String c_name = request.getParameter("courseName");
		String[] c_day = request.getParameterValues("courseDay");
		String sHour = request.getParameter("startHour");
		String sMinute = request.getParameter("startMinute");
		String eHour = request.getParameter("endHour");
		String eMinute = request.getParameter("endMinute");
		String t_max = request.getParameter("courseMax");
		String c_room = new String(request.getParameter("courseRoom").getBytes("ISO-8859-1"),"UTF-8");		
		String c_room_no = request.getParameter("courseRoomNo");
		String c_id = null;
		String c_no = null;
		String myDay = "";
		String myRoom = "";
		String t_hour;
		int t_year = 0;
		int t_sem = 0;
		for (int i = 0; i < c_day.length; i++) {
			switch(c_day[i]) {
			case "mon":
				myDay += '1';
				break;
			case "tue":
				myDay += '2';
				break;
			case "wed":
				myDay += '3';
				break;
			case "thu":
				myDay += '4';
				break;
			case "fri":
				myDay += '5';
				break;
			}
		}
		System.out.println(myDay);
		myRoom += c_room + " " + c_room_no;
		System.out.println(c_room + " | " + c_room_no + " | " + myRoom);
		if (c_name == null || c_name.equals("")) {
			%>
			<script>
				alert("과목 이름을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		if (c_day == null) {
			%>
			<script>
				alert("요일을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		if (sHour == null || sMinute == null || eHour == null || eMinute == null || sHour.equals("") || sMinute.equals("") || eHour.equals("") || eMinute.equals("")) {
			%>
			<script>
				alert("시간을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		if (c_room_no == null) {
			%>
			<script>
				alert("장소을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		if (t_max == null) {
			%>
			<script>
				alert("정원을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
//		String year_sql = "{? = call DateToEnrollYear(SYSDATE)}";
//		pSQL = "insert into teach values ('" + c_id + "', " + c_no + ", " + t_year + ", " + t_sem + ", " + p_id + ", " + t_hour + ", " + t_day + ", " + t_max + ", " + t_room + ")";
		try {
			cstmt = myConn.prepareCall("{? = call DateToEnrollYear(SYSDATE)}");
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			
//			System.out.println(t_year + " / " + t_sem);
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			
		}
	}
%>
