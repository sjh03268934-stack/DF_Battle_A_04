<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="bs" class="Game.BattleSystem"></jsp:useBean>

	<%
		out.print(bs.createCharacter("hero", "홍길동", "전사", 1));
		out.print(bs.attackMonster("hero"));
	%>
</body>
</html>