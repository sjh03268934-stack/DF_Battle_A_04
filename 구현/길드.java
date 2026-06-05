package Game;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    private String 길드명 = "아라드길드";
    private List<캐릭터> 캐릭터리스트 = new ArrayList<>();
    private int 최대인원 = 5;

    public synchronized boolean 캐릭터가입(캐릭터 가입캐릭터) {
        if (캐릭터리스트.size() < 최대인원) {
            캐릭터리스트.add(가입캐릭터);
            return true;
        }
        return false; // 정원 초과
    }
}