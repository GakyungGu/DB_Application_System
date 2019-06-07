<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"  import="java.net.URLDecoder" %>
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
		request.setCharacterEncoding("UTF-8");
		String p_id = request.getParameter("id");
		String add = request.getParameter("add");
		System.out.println(add);
		String c_name = null;
		if (add.equals("true")) {
			c_name = request.getParameter("courseName");
			System.out.println(c_name);
			c_name = URLDecoder.decode(c_name, "UTF-8");
		}
		else {
			c_name = new String(request.getParameter("courseName"));
		}
		String[] c_day = request.getParameterValues("courseDay");
		String sHour = request.getParameter("startHour");
		String sMinute = request.getParameter("startMinute");
		String eHour = request.getParameter("endHour");
		String eMinute = request.getParameter("endMinute");
		String t_max = request.getParameter("courseMax");
		String c_room = new String(request.getParameter("courseRoom").getBytes("ISO-8859-1"),"UTF-8");		
		String c_room_no = request.getParameter("courseRoomNo");
		String c_credit = request.getParameter("courseUnit");
		String c_id = null;
		String c_no = request.getParameter("courseNo");
		String myDay = "";
		String myRoom = "";
		String t_hour;
		int t_year = 0;
		int t_sem = 0;
		
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
		}else {
			for (int i = 0; i < c_day.length; i++) {
				switch(c_day[i]) {
				case "mon":
					myDay += '0';
					break;
				case "tue":
					myDay += '1';
					break;
				case "wed":
					myDay += '2';
					break;
				case "thu":
					myDay += '3';
					break;
				case "fri":
					myDay += '4';
					break;
				}
			}
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
		else {
			myRoom += c_room + " " + c_room_no;
		}
		if (t_max == null) {
			%>
			<script>
				alert("정원을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		String result = "";
		try {
			cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?,?,?)}");
			cstmt.setString(1, c_name);
			cstmt.setString(2, c_no);
			cstmt.setString(3, c_credit);
			cstmt.setString(4, p_id);
			cstmt.setInt(5, Integer.parseInt(sHour));
			cstmt.setInt(6, Integer.parseInt(sMinute));
			cstmt.setInt(7, Integer.parseInt(eHour));
			cstmt.setInt(8, Integer.parseInt(eMinute));
			cstmt.setString(9, myDay);
			cstmt.setString(10, t_max);
			cstmt.setString(11, myRoom);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			isSucceed = cstmt.execute();
			result = cstmt.getString(12);			
			System.out.println(result);
		}catch(SQLException e){
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
%>
