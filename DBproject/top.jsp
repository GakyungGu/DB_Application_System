<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% String session_id = (String) session.getAttribute("user");
   boolean stu_mode = true;
String log;
String menu = "수업과목";
String session_mode = (String) session.getAttribute("mode");
if (session_id == null)
	log = "<a href=login.jsp>로그인</a>";
else 
	log = "<a href=logout.jsp>로그아웃</a>"; 
if (session_mode == null) 
	stu_mode = false;
if (stu_mode) {
	menu = "수강신청";
}
%>
<table width="75%" align="center" bgcolor="#FFFF99" border>
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
<td align="center"><b><a href="insert.jsp"><%=menu%> 입력</b></td>
<td align="center"><b><a href="delete.jsp"><%=menu%> 삭제</b></td>
<td align="center"><b><a href="select.jsp"><%=menu%> 조회</b></td>
</tr>
</table>
