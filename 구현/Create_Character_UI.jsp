<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Game.전투" %>
<%@ page import="Game.캐릭터" %>
<%
    request.setCharacterEncoding("UTF-8");

    전투 현재전투 = (전투) session.getAttribute("전투시스템");
    if (현재전투 == null) {
        현재전투 = new 전투();
        session.setAttribute("전투시스템", 현재전투);
    }

    String resultMessage = "";
    boolean isProcessed = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String inputId = request.getParameter("inputId");
        String name = request.getParameter("name");
        String job = request.getParameter("job");
        int level = Integer.parseInt(request.getParameter("level"));
        
        resultMessage = 현재전투.캐릭터생성(inputId, name, job, level);
        isProcessed = true;
    }

    // 화면 출력을 위해 현재 세션의 캐릭터 정보 가져오기
    캐릭터 로그인캐릭터 = 현재전투.get현재캐릭터();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캐릭터생성 UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; margin: 40px; background: #f5f6fa; }
        .box { max-width: 450px; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .char-info { background: #eaf2f8; padding: 15px; border-radius: 6px; margin-bottom: 20px; border-left: 4px solid #3498db; }
        .char-info p { margin: 5px 0; font-size: 14px; color: #2c3e50; }
        .btn { width: 100%; padding: 10px; background: #3498db; color: white; border: none; font-weight: bold; cursor: pointer; margin-top: 10px;}
        .msg { margin-top: 15px; padding: 15px; font-weight: bold; text-align: center; background: #e8f8f5; color: #16a085; }
        .fail { background: #fdedec; color: #c0392b; }
    </style>
</head>
<body>
    <div class="box">
        <h2>🛡️ 캐릭터 생성</h2>

        <div class="char-info">
            <strong>[현재 생성된 캐릭터]</strong>
            <% if (로그인캐릭터 != null) { %>
                <p>이름: <strong><%= 로그인캐릭터.get이름() %></strong> (<%= 로그인캐릭터.getClass().getSimpleName() %>)</p>
                <p>레벨: <%= 로그인캐릭터.get레벨() %> | HP: <%= 로그인캐릭터.getHp() %> | 공격력: <%= 로그인캐릭터.get공격력() %></p>
            <% } else { %>
                <p style="color: #e74c3c; margin-top: 10px;">아직 생성된 캐릭터가 없습니다.</p>
            <% } %>
        </div>

        <form method="POST">
            플레이어 ID: <input type="text" name="inputId" value="hero" required style="width:100%; margin-bottom:10px; box-sizing: border-box; padding: 5px;"><br>
            캐릭터 이름: <input type="text" name="name" required style="width:100%; margin-bottom:10px; box-sizing: border-box; padding: 5px;"><br>
            직업 선택: 
            <select name="job" required style="width:100%; margin-bottom:10px; padding: 5px;">
                <option value="전사">전사 (HP:100배수, 공격력:15배수)</option>
                <option value="마법사">마법사 (HP:60배수, 공격력:25배수)</option>
            </select><br>
            초기 레벨: <input type="number" name="level" value="1" min="1" required style="width:100%; margin-bottom:10px; box-sizing: border-box; padding: 5px;"><br>
            <button type="submit" class="btn">캐릭터 생성/변경하기</button>
        </form>

        <% if (isProcessed) { %>
            <div class="msg <%= resultMessage.contains("실패") ? "fail" : "" %>">
                <%= resultMessage %>
            </div>
        <% } %>
        
        <hr>
        <a href="Join_Guild_UI.jsp">2. 길드가입</a> | 
        <a href="Add_Item_UI.jsp">3. 아이템획득</a> | 
        <a href="Attack_Monster_UI.jsp">4. 몬스터공격</a>
    </div>
</body>
</html>