<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Game.BattleSystem" %>
<%
    // 1. 한글 깨짐 방지를 위한 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 2. 세션에서 BattleSystem(제어 클래스) 인스턴스 가져오기
    // 웹은 요청이 끝나면 데이터가 사라지므로, 사용자별로 고유한 세션 영역에 객체를 저장합니다.
    BattleSystem battleSystem = (BattleSystem) session.getAttribute("battleSystem");
    if (battleSystem == null) {
        battleSystem = new BattleSystem();
        session.setAttribute("battleSystem", battleSystem);
    }

    String resultMessage = "";
    boolean isProcessed = false;

    // 3. 사용자가 [캐릭터 생성하기] 버튼을 눌러 POST 요청을 보냈을 때 처리 (캐릭터정보입력)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String inputId = request.getParameter("inputId");
        String name = request.getParameter("name");
        String job = request.getParameter("job");
        String levelStr = request.getParameter("level");
        
        int level = 1;
        try {
            if (levelStr != null && !levelStr.isEmpty()) {
                level = Integer.parseInt(levelStr);
            }
        } catch (NumberFormatException e) {
            resultMessage = "레벨은 숫자형태로 입력해야 합니다.";
        }

        if (resultMessage.isEmpty()) {
            // 제어 클래스(BattleSystem)의 비즈니스 로직 호출
            resultMessage = battleSystem.createCharacter(inputId, name, job, level);
            isProcessed = true;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캐릭터 생성 UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f5f6fa; margin: 50px; }
        .ui-container { max-width: 450px; margin: auto; background: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #2c3e50; margin-bottom: 25px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #34495e; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccd1d9; border-radius: 6px; box-sizing: border-box; font-size: 14px; }
        .btn-submit { width: 100%; padding: 12px; background-color: #3498db; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 6px; cursor: pointer; transition: background 0.2s; }
        .btn-submit:hover { background-color: #2980b9; }
        .result-box { margin-top: 20px; padding: 15px; border-radius: 6px; font-weight: bold; text-align: center; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .fail { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .next-actions { margin-top: 25px; padding-top: 15px; border-top: 1px solid #e6e9ed; text-align: center; }
        .next-actions a { display: inline-block; margin: 5px 10px; color: #34485e; text-decoration: none; font-size: 14px; background: #e6e9ed; padding: 6px 12px; border-radius: 4px; }
        .next-actions a:hover { background: #ccd1d9; }
    </style>
</head>
<body>

<div class="ui-container">
    <h2>🛡️ 캐릭터 생성 UI</h2>
    
    <%-- 폼 입력 데이터 전송 (Boundary -> Control 호출 매개체) --%>
    <form action="characterCreate.jsp" method="POST">
        <div class="form-group">
            <label for="inputId">플레이어 ID (권한 확인용)</label>
            <input type="text" id="inputId" name="inputId" placeholder="예: hero" required>
        </div>
        
        <div class="form-group">
            <label for="name">캐릭터 이름</label>
            <input type="text" id="name" name="name" placeholder="생성할 이름을 입력하세요" required>
        </div>
        
        <div class="form-group">
            <label for="job">직업 선택</label>
            <select id="job" name="job" required>
                <option value="">-- 직업을 선택하세요 --</option>
                <option value="전사">전사 (Warrior)</option>
                <option value="마법사">마법사 (Mage)</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="level">초기 레벨</label>
            <input type="number" id="level" name="level" value="1" min="1" required>
        </div>
        
        <button type="submit" class="btn-submit">캐릭터 생성하기</button>
    </form>

    <%-- 제어 클래스의 처리 결과 표시 영역 --%>
    <% if (isProcessed) { 
        boolean isSuccess = resultMessage.contains("완료");
        String resultClass = isSuccess ? "success" : "fail";
    %>
        <div class="result-box <%= resultClass %>">
            <%= resultMessage %>
        </div>
    <% } %>
    
    <%-- 다음 UI 경계로 이동할 수 있는 링크 메뉴 --%>
    <div class="next-actions">
        <p style="font-size: 13px; color: #7f8c8d; margin-bottom: 5px;">캐릭터 생성 후 다음 행동 진행:</p>
        <a href="guildJoin.jsp">길드가입 UI</a>
        <a href="itemAdd.jsp">아이템추가 UI</a>
        <a href="monsterAttack.jsp">몬스터공격 UI</a>
    </div>
</div>

</body>
</html>