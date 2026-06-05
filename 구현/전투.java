package Game;

public class 전투 {
    // 플레이어 객체를 생성하여 권한 검증에 사용 ("hero"만 통과)
    private 플레이어 인증플레이어 = new 플레이어("hero");
    
    // 현재 세션에서 유지될 캐릭터 상태
    private 캐릭터 현재캐릭터;
    
    // 서버에서 관리되는 길드 객체 (Aggregation)
    private 길드 서버길드 = new 길드(); 

    /**
     * 1. 캐릭터 생성 로직
     */
    public String 캐릭터생성(String 플레이어id, String 이름, String 직업, int 레벨) {
        // ★ 권한 검증 실행
        if (!인증플레이어.플레이어체크(플레이어id)) {
            return "생성 실패: 플레이어 권한 없음 (ID 불일치)";
        }

        if ("전사".equals(직업)) {
            현재캐릭터 = new 전사(이름, 레벨);
        } else if ("마법사".equals(직업)) {
            현재캐릭터 = new 마법사(이름, 레벨);
        } else {
            return "생성 실패: 알 수 없는 직업";
        }
        
        return "캐릭터 생성 완료 [" + 직업 + " " + 이름 + "]";
    }

    /**
     * 2. 몬스터 공격 로직
     */
    public String 몬스터공격(String 플레이어id) {
        // ★ 권한 검증 실행
        if (!인증플레이어.플레이어체크(플레이어id)) {
            return "공격 실패: 플레이어 권한 없음 (ID 불일치)";
        }
        if (현재캐릭터 == null) {
            return "공격 실패: 먼저 캐릭터를 생성해야 합니다.";
        }

        int 데미지 = 현재캐릭터.스킬발동();
        String 스킬명 = 현재캐릭터.스킬명반환();
        String 등급;

        // 설계서 Phase 2 기준에 맞춘 등급 부여
        if (데미지 >= 200) {
            등급 = "S급";
        } else if (데미지 >= 100) {
            등급 = "A급";
        } else {
            등급 = "B급";
        }

        return String.format("공격 결과 - 스킬: [%s] | 데미지: %d | 등급: %s", 스킬명, 데미지, 등급);
    }

    /**
     * 3. 아이템 획득 로직
     */
    public String 아이템획득(String 플레이어id, String 아이템명, String 타입, int 가치) {
        // ★ 권한 검증 실행
        if (!인증플레이어.플레이어체크(플레이어id)) {
            return "획득 실패: 플레이어 권한 없음 (ID 불일치)";
        }
        if (현재캐릭터 == null) {
            return "획득 실패: 먼저 캐릭터를 생성해야 합니다.";
        }

        아이템 획득아이템 = new 아이템(아이템명, 타입, 가치);
        
        // Composition 객체(인벤토리)에 아이템 추가 시도
        if (현재캐릭터.get인벤토리().아이템추가(획득아이템)) {
            return String.format("아이템 획득 성공! [%s] %s", 획득아이템.get등급(), 아이템명);
        } else {
            return "아이템 획득 실패: 인벤토리 가방이 가득 찼습니다 (최대 10개)";
        }
    }

    /**
     * 4. 길드 가입 로직
     */
    public String 길드가입(String 플레이어id, String 길드명) {
        // ★ 권한 검증 실행
        if (!인증플레이어.플레이어체크(플레이어id)) {
            return "가입 실패: 플레이어 권한 없음 (ID 불일치)";
        }
        if (현재캐릭터 == null) {
            return "가입 실패: 먼저 캐릭터를 생성해야 합니다.";
        }

        // Aggregation 객체(길드)에 캐릭터 추가 시도
        if (서버길드.캐릭터가입(현재캐릭터)) {
            return "길드 [" + 길드명 + "] 가입 성공!";
        } else {
            return "가입 실패: 길드 정원 초과 (최대 5명)";
        }
    }

    /**
     * JSP(UI) 화면 표시를 위한 Getter
     */
    public 캐릭터 get현재캐릭터() {
        return 현재캐릭터;
    }
}