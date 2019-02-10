<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ page import = "user.UserDAO" %> <%--클래스 import--%>
 <%@ page import = "java.io.PrintWriter" %>
 <%request.setCharacterEncoding("UTF-8"); %> <%--넘어오는 데이터를 모두 UTF-8로 변환--%>
 <jsp:useBean id = "user" class ="user.User" scope = "page" /> <%--현재 페이지 내에서만 beans가 사용되도록 --%>
 <jsp:setProperty name = "user" property ="userID" /> <%--로그인 페이지의 유저의 ID와 PW를 받아서 한명의 사용자의 유저 아이디에 넣어주는 것 --%>
 <jsp:setProperty name = "user" property ="userPassword" /> 
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>킹콩민 웹사이트 게시판</title>
</head>
<body> 
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); // UserDAO 객체 활용
		
		if(result==1){ // 로그인 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp"); // 메인페이지 이동	 
			script.println("</script>");
		} 
		else if (result==0){ 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')"); 
			script.println("history.back()"); // 이전 페이지로 이동 
			script.println("</script>");
		} 
		else if (result==-1){ 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')"); 
			script.println("history.back()"); // 이전 페이지로 이동
			script.println("</script>");
		} 
		else if (result==-2){ 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')"); 
			script.println("history.back()"); // 이전 페이지로 이동
			script.println("</script>");
		}
	%>
</body>
</html>