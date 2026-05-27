```mermaid
flowchart LR
    %% 액터 정의 (사람 모양 대신 직관적인 원형으로 표현)
    Actor((플레이어))

    subgraph GameSystem [게임 시스템]
    %% 유즈케이스 정의 (타원형)
    UC1([캐릭터 생성])
    UC2([몬스터 공격])
    UC3([아이템 획득])
    UC4([길드 가입])
    UC5([플레이어 체크])
    end
    
    %% 액터와 유즈케이스 간의 관계 (기본 연관 관계)
    Actor --> UC1
    Actor --> UC2
    Actor --> UC3
    Actor --> UC4

    %% Include 관계 설정 (점선 화살표와 라벨 사용)
    UC1 -.->|<<include>>| UC5
    UC2 -.->|<<include>>| UC5
    UC3 -.->|<<include>>| UC5
    UC4 -.->|<<include>>| UC5