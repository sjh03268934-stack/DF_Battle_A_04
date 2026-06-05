<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Game.전투" %>
<%@ page import="Game.캐릭터" %>
<%@ page import="Game.아이템" %>
<%
    request.setCharacterEncoding("UTF-8");
    전투 현재전투 = (전투) session.getAttribute("전투시스템");
    if (현재전투 == null) { 현재전투 = new 전투(); session.setAttribute("전투시스템", 현재전투); }

    String resultMessage = "";
    boolean isProcessed = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String inputId = request.getParameter("inputId");
        String itemName = request.getParameter("itemName");
        String type = request.getParameter("type");
        int value = Integer.parseInt(request.getParameter("value"));
        
        resultMessage = 현재전투.아이템획득(inputId, itemName, type, value);
        isProcessed = true;
    }

    // 인벤토리를 화면에 뿌려주기 위해 캐릭터 정보 로드
    캐릭터 로그인캐릭터 = 현재전투.get현재캐릭터();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이템획득 UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; margin: 40px; background: #f5f6fa; }
        .box { max-width: 450px; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .btn { width: 100%; padding: 10px; background: #2ecc71; color: white; border: none; font-weight: bold; cursor: pointer; margin-top: 10px;}
        .msg { margin-top: 15px; padding: 15px; font-weight: bold; text-align: center; background: #e8f8f5; color: #16a085; border-radius: 4px; }
        .fail { background: #fdedec; color: #c0392b; }
        .inventory-box { margin-top: 20px; background: #f8f9fa; padding: 15px; border-radius: 6px; border: 1px solid #e6e9ed; }
        .item-list { list-style-type: none; padding: 0; margin: 10px 0 0 0; }
        .item-list li { background: white; margin-bottom: 5px; padding: 8px; border-radius: 4px; border-left: 4px solid #2ecc71; font-size: 13px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <div class="box">
        <h2>🎒 아이템 획득</h2>
        <form method="POST">
            플레이어 ID: <input type="text" name="inputId" value="hero" required style="width:100%; margin-bottom:10px; box-sizing: border-box; padding: 5px;"><br>
            아이템명: <input type="text" name="itemName" required style="width:100%; margin-bottom:10px; box-sizing: border-box; padding: 5px;"><br>
            아이템타입: 
            <select name="type" required style="width:100%; margin-bottom:10px; padding: 5px;">
                <option value="무기">무기</option>
                <option value="방어구">방어구</option>
                <option value="물약">물약</option>
            </select><br>
            가치(수치): <input type="number" name="value" value="500" required style="width:100%; margin-bottom:10px; box-sizing: border-box; padding: 5px;"><br>
            <p style="font-size:12px; color:gray; margin-top: -5px; margin-bottom: 10px;">* 가치에 따라 등급(전설, 희귀, 일반) 자동 부여</p>
            <button type="submit" class="btn">아이템 획득하기</button>
        </form>

        <% if (isProcessed) { %>
            <div class="msg <%= resultMessage.contains("실패") ? "fail" : "" %>">
                <%= resultMessage %>
            </div>
        <% } %>

        <div class="inventory-box">
            <strong>[💼 내 인벤토리 (최대 10칸)]</strong>
            <% if (로그인캐릭터 != null && !로그인캐릭터.get인벤토리().get아이템리스트().isEmpty()) { 
                int currentSize = 로그인캐릭터.get인벤토리().get아이템리스트().size();
            %>
                <span style="font-size: 12px; color: #7f8c8d; float: right;">(<%= currentSize %> / 10)</span>
                <ul class="item-list">
                <% for(아이템 템 : 로그인캐릭터.get인벤토리().get아이템리스트()) { %>
                    <li>
                        <strong>[<%= 템.get등급() %>]</strong> <%= 템.get아이템명() %> 
                        <span style="color:#7f8c8d;">(<%= 템.get타입() %> / 가치: <%= 템.get가치() %>)</span>
                    </li>
                <% } %>
                </ul>
            <% } else if (로그인캐릭터 == null) { %>
                <p style="color: #e74c3c; font-size: 13px; margin-top: 10px;">캐릭터를 먼저 생성해주세요.</p>
            <% } else { %>
                <p style="color: #7f8c8d; font-size: 13px; margin-top: 10px;">가방이 비어있습니다.</p>
            <% } %>
        </div>
        
        <hr>
        <a href="Create_Character_UI.jsp">1. 캐릭터생성</a> | 
        <a href="Join_Guild_UI.jsp">2. 길드가입</a> | 
        <a href="Attack_Monster_UI.jsp">4. 몬스터공격</a>
    </div>
</body>
</html>