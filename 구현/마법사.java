package Game;

public class 마법사 extends 캐릭터 {
    public 마법사(String 이름, int 레벨) {
        super(이름, 레벨);
        this.hp = 레벨 * 60;     // 설계서 밸런스 패치 반영
        this.공격력 = 레벨 * 25;
    }

    @Override
    public int 스킬발동() {
        return (int)(this.공격력 * 2.0); // 배율 2.0으로 하향
    }

    @Override
    public String 스킬명반환() {
        return "파이어볼";
    }
}