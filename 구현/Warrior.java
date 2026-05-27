package Game;

public class Warrior extends GameCharacter {
    
    public Warrior(String name, int level) {
        super(name, level);
        // 전사에 맞는 기본 능력치 설정
        this.hp = level * 120;
        this.attackPower = level * 15;
    }

    @Override
    public int useSkill() {
        // 검 휘두르기: 공격력의 1.5배 데미지 (직업별 스킬 계수 적용)
        return (int)(this.attackPower * 1.5);
    }

    @Override
    public String getSkillName() {
        return "검 휘두르기";
    }
}