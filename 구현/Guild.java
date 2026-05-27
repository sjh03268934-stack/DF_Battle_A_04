package Game;

import java.util.ArrayList;
import java.util.List;

public class Guild {
	private String Gname = "길드1";
	private List<GameCharacter> Gchar = new ArrayList<GameCharacter>();
	private int member = 0;

	public boolean addchar(GameCharacter Gchar) {
		if(member<5) {
		this.Gchar.add(Gchar);
		member += 1;
		return true;
		}
		else {
			return false;
		}
	}
}
