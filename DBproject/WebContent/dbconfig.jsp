<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	Connection myConn = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1616612";
	String passwd ="2997";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
%>