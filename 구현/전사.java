package Game;

public class 전사 extends 캐릭터 {
    public 전사(String 이름, int 레벨) {
        super(이름, 레벨);
        this.hp = 레벨 * 100;    // 설계서 밸런스 패치 반영
        this.공격력 = 레벨 * 15;
    }

    @Override
    public int 스킬발동() {
        return (int)(this.공격력 * 1.5);
    }

    @Override
    public String 스킬명반환() {
        return "검 휘두르기";
    }
}