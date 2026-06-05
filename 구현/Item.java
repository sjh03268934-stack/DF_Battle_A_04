package Game;

public class Item {
    private String itemName;
    private String type;     // 예: "무기", "방어구", "소비"
    private int value;       // 가치 (가격 또는 능력치 수치)
    private String grade;    // 등급 (예: "노멀", "레어", "에픽")

    public Item(String itemName, String type, int value, String grade) {
        this.itemName = itemName;
        this.type = type;
        this.value = value;
        this.grade = grade;
    }

    // Getters
    public String getItemName() { return itemName; }
    public String getType() { return type; }
    public int getValue() { return value; }
    public String getGrade() { return grade; }
}