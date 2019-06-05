<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8">
<title>데이터베이스를 활용한 수강신청 시스템입니다.</title>
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
<%@include file="top.jsp"%>
<table width="75%" align="center" height="100%">
<% if (session_id != null) { %>
<tr> <td align="center"><%=session_id%>님의 방문을 환영합니다.</td> </tr>
<% } else { %>
<tr> <td align="center">로그인한 후 사용하세요.</td> </tr>
<% } %>
</table> </body> </html>