package Game;

public abstract class 캐릭터 {
    protected String 이름;
    protected int 레벨;
    protected int hp;
    protected int 공격력;
    
    // 복합객체(Composition) 관계: 캐릭터 생성 시 인벤토리도 함께 생성/소멸
    protected 인벤토리 소유인벤토리;

    public 캐릭터(String 이름, int 레벨) {
        this.이름 = 이름;
        this.레벨 = 레벨;
        this.소유인벤토리 = new 인벤토리(); // 생성자에서 인벤토리 강제 결합
    }

    public String get이름() { return 이름; }
    public int get레벨() { return 레벨; }
    public int getHp() { return hp; }
    public int get공격력() { return 공격력; }
    public 인벤토리 get인벤토리() { return 소유인벤토리; }

    public abstract int 스킬발동();
    public abstract String 스킬명반환();
}