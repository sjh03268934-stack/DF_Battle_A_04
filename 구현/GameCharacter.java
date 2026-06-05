package Game;

public abstract class GameCharacter {
    protected String name;
    protected int level;
    protected int hp;
    protected int attackPower;
    protected Inventory inventory; 

    public GameCharacter(String name, int level) {
        this.name = name;
        this.level = level;
        // 캐릭터 생성 시 기본 인벤토리(예: 20칸) 함께 생성
        this.inventory = new Inventory(20); 
    }

    public String getName() { return name; }
    public int getLevel() { return level; }
    public int getHp() { return hp; }
    public int getAttackPower() { return attackPower; }
    public Inventory getInventory() { return inventory; }

    // 스킬 발동 (직업별로 다르게 구현되며 최종 데미지를 반환)
    public abstract int useSkill();
    
    // UI 출력을 위한 스킬명 반환용 메서드 (추가 편의성)
    public abstract String getSkillName();
    
    
}