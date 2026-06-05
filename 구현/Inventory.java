package Game;

import java.util.ArrayList;
import java.util.List;

public class Inventory {
    private List<Item> itemList;
    private int maxCapacity;

    public Inventory(int maxCapacity) {
        this.itemList = new ArrayList<>();
        this.maxCapacity = maxCapacity;
    }

    // 아이템 추가 메서드 (용량 체크 포함)
    public boolean addItem(Item item) {
        if (itemList.size() < maxCapacity) {
            itemList.add(item);
            return true; // 추가 성공
        } else {
            return false; // 가방 가득 참
        }
    }

    public List<Item> getItemList() {
        return itemList;
    }
}