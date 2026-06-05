``` mermaid
sequenceDiagram
    autonumber
    actor User as 사용자
    participant UI as 아이템추가_UI
    participant Control as 전투
    participant Player as 플레이어
    participant Char as 캐릭터
    participant Inv as 인벤토리
    participant Item as 아이템

    User->>UI: 플레이어ID, 아이템명, 타입, 가치 입력
    activate UI

    UI->>Control: 아이템획득(playerId, itemName, type, value)
    activate Control

    %% 플레이어 검증
    Control->>Player: 플레이어체크(playerId)
    activate Player
    Player-->>Control: true / false
    deactivate Player

    alt 플레이어 검증 실패
        Control-->>UI: 획득 실패 (권한 없음)

    else 플레이어 검증 성공

        alt 현재캐릭터 == null
            Control-->>UI: 획득 실패 (캐릭터 없음)

        else 현재캐릭터 존재

            Control->>Item: new 아이템(name, type, value)
            activate Item
            Note over Item: 가치 기반 등급 자동 결정<br/>1000↑ 전설 / 500↑ 희귀 / 미만 일반
            Item-->>Control: 아이템 객체
            deactivate Item

            Control->>Char: get인벤토리()
            activate Char
            Char-->>Control: 인벤토리 참조
            deactivate Char

            Control->>Inv: 아이템추가(item)
            activate Inv

            alt 현재 아이템 수 < 10
                Inv->>Inv: 아이템리스트.add(item)
                Inv-->>Control: true
                Control-->>UI: 아이템 획득 성공
            else 현재 아이템 수 >= 10
                Inv-->>Control: false
                Control-->>UI: 획득 실패 (인벤토리 가득 참)
            end

            deactivate Inv

        end

    end

    UI->>UI: 결과 메시지 출력
    UI-->>User: 아이템 획득 결과 표시

    deactivate Control
    deactivate UI
