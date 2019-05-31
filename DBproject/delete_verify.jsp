<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
 
<%
	String c_id = request.getParameter("c_id");
	String s_id = request.getParameter("id");
	String e_year = request.getParameter("e_year");
	String e_sem = request.getParameter("e_sem");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1616612";
	String passwd ="2997";
	String mySQL = null;
	Connection myConn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet myResultSet = null;
	int change = 0;

	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		mySQL = "delete from enroll where c_id=? and e_year=? and e_sem=? and s_id=?";
		pstmt = myConn.prepareStatement(mySQL);
		pstmt.setString(1, c_id);
		pstmt.setString(2, e_year);
		pstmt.setString(3, e_sem);
		pstmt.setString(4, s_id);
		change = pstmt.executeUpdate();
	}catch(SQLException e) {
		e.printStackTrace();
	}finally {
		if (change == 0) {
			%>
			<script>
				alert("삭제에 실패하였습니다.");
				location.href="delete.jsp";
			</script>
			<%
		}
		else {
			%>
			<script>
				alert("삭제되었습니다.");
				location.href="delete.jsp";
			</script>
			<%
		}
	}

%>