package Game;

public class BattleSystem {
    // 임시로 DB 대신 시스템 메모리에 현재 플레이어와 캐릭터 상태를 저장
    private Player player = new Player("hero"); 
    private GameCharacter currentCharacter;
    private Guild guild = new Guild();
    /**
     * 캐릭터 생성 로직
     */
    public String createCharacter(String inputId, String name, String job, int level) {
        // 1. 플레이어 체크
        if (!player.checkPlayer(inputId)) {
            return "생성 실패 (권한 없음)";
        }

        // 2. 객체 생성 및 기본 능력치 설정
        if ("전사".equals(job)) {
            currentCharacter = new Warrior(name, level);
        } else if ("마법사".equals(job)) {
            currentCharacter = new Mage(name, level);
        } else {
            return "생성 실패 (알 수 없는 직업)";
        }

        // 3. 완료 메시지 반환
        return "캐릭터 생성 완료 [이름: " + name + ", 직업: " + job + ", 레벨: " + level + "]";
    }

    /**
     * 몬스터 공격 로직
     */
    public String attackMonster(String inputId) {
        // 1. 플레이어 체크
        if (!player.checkPlayer(inputId)) {
            return "공격 실패 (권한 없음)";
        }

        if (currentCharacter == null) {
            return "공격 실패 (생성된 캐릭터가 없습니다)";
        }

        // 2. 스킬 발동 요청 및 데미지 반환
        int finalDamage = currentCharacter.useSkill();
        String skillName = currentCharacter.getSkillName();

        // 3. 데미지 등급 판정
        String grade = assignGrade(finalDamage);

        // 4. 공격 결과 문자열 조합하여 반환
        return String.format("공격 결과 - 스킬: [%s] | 데미지: %d | 등급: %s", skillName, finalDamage, grade);
    }
    
    public String joinGuild(String inputId, String Guild){
    	String a;
    	if(guild.addchar(currentCharacter)) {
    		a = "길드가입성공";
    		return a;}
    	else{a = "길드가입실패";
		return a;}
    }

    /**
     * 내부 메서드: 등급 부여 (private)
     */
    private String assignGrade(int damage) {
        if (damage >= 100) {
            return "S";
        } else if (damage >= 50) {
            return "A";
        } else {
            return "B";
        }
    }
}