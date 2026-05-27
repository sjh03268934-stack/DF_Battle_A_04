package Game;

public class Mage extends GameCharacter {

    public Mage(String name, int level) {
        super(name, level);
        // 마법사에 맞는 기본 능력치 설정
        this.hp = level * 70;
        this.attackPower = level * 25;
    }

    @Override
    public int useSkill() {
        // 파이어볼: 공격력의 2.2배 데미지 (직업별 스킬 계수 적용)
        return (int)(this.attackPower * 2.2);
    }

    @Override
    public String getSkillName() {
        return "파이어볼";
    }
}