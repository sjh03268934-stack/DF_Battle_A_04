package Game;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트;
    private int 최대용량 = 10; // 설계서 기준 10칸으로 하향

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
    }

    public boolean 아이템추가(아이템 새아이템) {
        if (아이템리스트.size() < 최대용량) {
            아이템리스트.add(새아이템);
            return true; // 획득 성공
        }
        return false; // 가방 가득 참
    }

    public List<아이템> get아이템리스트() {
        return 아이템리스트;
    }
}