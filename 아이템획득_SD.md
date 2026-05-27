``` mermaid
sequenceDiagram
    actor User as 사용자
    participant UI as 아이템추가_UI
    participant Control as 전투
    participant Player as 플레이어
    participant Char as 캐릭터
    participant Inv as 인벤토리
    participant Item as 아이템

    %% 사용자의 UI 조작
    User->>UI: 아이템 정보 입력
    activate UI
    
    %% 제어 클래스로 요청 (클래스 다이어그램의 메서드 매핑)
    UI->>Control: 아이템획득()
    activate Control

    %% 1. 플레이어 검증 단계
    Control->>Player: 플레이어체크(플레이어id)
    activate Player
    Player-->>Control: 검증 결과 반환 (true/false)
    deactivate Player

    alt 검증 성공 (true)
        %% 2. 아이템 가치 평가 및 객체 생성
        Note over Control, Item: 가치에 따른 등급(전설/희귀/일반) 부여
        Control->>Item: 객체 생성(아이템명, 타입, 가치, 등급)
        activate Item
        Item-->>Control: 아이템 객체 반환
        deactivate Item

        %% 3. 캐릭터의 인벤토리 속성(멤버) 접근
        Control->>Char: 인벤토리멤버 접근
        activate Char
        Char-->>Control: 인벤토리 객체 참조 반환
        deactivate Char

        %% 4. 인벤토리에 아이템 추가 및 용량 검증
        Control->>Inv: 아이템추가(item)
        activate Inv
        
        Note over Inv: 인벤토리 최대용량 확인
        
        alt 아이템리스트 크기 < 최대용량
            Inv->>Inv: 아이템리스트에 item 추가
            Inv-->>Control: 추가 성공 (true)
            Control-->>UI: 획득 성공 응답
        else 아이템리스트 크기 >= 최대용량
            Inv-->>Control: 추가 실패 (false)
            Control-->>UI: 획득 실패 (공간 부족) 응답
        end
        deactivate Inv
        
    else 검증 실패 (false)
        Control-->>UI: 획득 실패 (권한 없음) 응답
    end

    %% 5. 결과 화면 출력 (클래스 다이어그램의 메서드 매핑)
    UI->>UI: 화면표시()
    UI-->>User: 아이템 획득 최종 결과 출력
    deactivate Control
    deactivate UI