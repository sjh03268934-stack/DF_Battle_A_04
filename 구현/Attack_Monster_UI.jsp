<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Game.전투" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 현재전투 = (전투) session.getAttribute("전투시스템");
    if (현재전투 == null) { 현재전투 = new 전투(); session.setAttribute("전투시스템", 현재전투); }

    String resultMessage = "";
    boolean isProcessed = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String inputId = request.getParameter("inputId");
        
        resultMessage = 현재전투.몬스터공격(inputId);
        isProcessed = true;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>몬스터공격 UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; margin: 40px; background: #f5f6fa; }
        .box { max-width: 450px; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .btn { width: 100%; padding: 10px; background: #e74c3c; color: white; border: none; font-weight: bold; cursor: pointer; margin-top: 10px;}
        .msg { margin-top: 15px; padding: 15px; font-weight: bold; text-align: center; background: #e8f8f5; color: #16a085; }
        .fail { background: #fdedec; color: #c0392b; }
    </style>
</head>
<body>
    <div class="box">
        <h2>⚔️ 몬스터 공격</h2>
        <form method="POST">
            플레이어 ID: <input type="text" name="inputId" value="hero" required style="width:100%; margin-bottom:10px;"><br>
            <button type="submit" class="btn">💥 공격하기 (스킬발동)</button>
        </form>

        <% if (isProcessed) { %>
            <div class="msg <%= resultMessage.contains("실패") ? "fail" : "" %>">
                <%= resultMessage %>
            </div>
        <% } %>
        
        <hr>
        <a href="Create_Character_UI.jsp">1. 캐릭터생성</a> | 
        <a href="Join_Guild_UI.jsp">2. 길드가입</a> | 
        <a href="Add_Item_UI.jsp">3. 아이템획득</a>
    </div>
</body>
</html>