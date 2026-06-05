package Game;

public class 아이템 {
    private String 아이템명;
    private String 타입; // 무기, 방어구, 물약
    private int 가치;
    private String 등급;

    public 아이템(String 아이템명, String 타입, int 가치) {
        this.아이템명 = 아이템명;
        this.타입 = 타입;
        this.가치 = 가치;
        
        // 아이템 가치에 따른 등급 자동 부여 로직 (설계서 반영)
        if (this.가치 >= 1000) {
            this.등급 = "전설";
        } else if (this.가치 >= 500) {
            this.등급 = "희귀";
        } else {
            this.등급 = "일반";
        }
    }

    public String get아이템명() { return 아이템명; }
    public String get타입() { return 타입; }
    public int get가치() { return 가치; }
    public String get등급() { return 등급; }
}