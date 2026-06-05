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
        String guildName = request.getParameter("guildName");
        
        // JSP는 비활성화 처리 없이 즉시 로직 호출 (검증은 전투.java 몫)
        resultMessage = 현재전투.길드가입(inputId, guildName);
        isProcessed = true;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>길드가입 UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; margin: 40px; background: #f5f6fa; }
        .box { max-width: 450px; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .btn { width: 100%; padding: 10px; background: #f1c40f; color: #333; border: none; font-weight: bold; cursor: pointer; margin-top: 10px;}
        .msg { margin-top: 15px; padding: 15px; font-weight: bold; text-align: center; background: #e8f8f5; color: #16a085; }
        .fail { background: #fdedec; color: #c0392b; }
    </style>
</head>
<body>
    <div class="box">
        <h2>🏰 길드 가입</h2>
        <form method="POST">
            플레이어 ID: <input type="text" name="inputId" value="hero" required style="width:100%; margin-bottom:10px;"><br>
            가입할 길드명: <input type="text" name="guildName" value="아라드길드" required style="width:100%; margin-bottom:10px;"><br>
            <button type="submit" class="btn">길드 가입 신청</button>
        </form>

        <% if (isProcessed) { %>
            <div class="msg <%= resultMessage.contains("실패") ? "fail" : "" %>">
                <%= resultMessage %>
            </div>
        <% } %>
        
        <hr>
        <a href="Create_Character_UI.jsp">1. 캐릭터생성</a> | 
        <a href="Add_Item_UI.jsp">3. 아이템획득</a> | 
        <a href="Attack_Monster_UI.jsp">4. 몬스터공격</a>
    </div>
</body>
</html>