```mermaid
flowchart LR
    Player((플레이어))
    
    subgraph GameSystem [게임 시스템]
        UC1([캐릭터 생성])
        UC2([몬스터 공격])
        UC3([플레이어 체크])
    end
    
    Player --> UC1
    Player --> UC2
    
    UC1 -. "&lt&ltinclude&gt&gt" .-> UC3
    UC2 -. "&lt&ltinclude&gt&gt" .-> UC3

    
    style Player fill:#f9f,stroke:#333,stroke-width:2px
    style UC1 fill:#bbf,stroke:#333,stroke-width:2px
    style UC2 fill:#bbf,stroke:#333,stroke-width:2px
    style UC3 fill:#fbb,stroke:#333,stroke-width:2px