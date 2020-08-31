import java.util.*;

class Randomizer {
    private final List<Integer> INPUTS = Collections.unmodifiableList(Arrays.asList(0, 0, 0, 0, 1, 1, 1, 1, 2, 3, 3, 4));
    

    private final List<Integer> list;
    private int pos = 0;

    public Randomizer() {
        list = new ArrayList<Integer>(INPUTS);
        Collections.shuffle(list);
    }

    public int next() {
        if (pos == list.size()) {
        Collections.shuffle(list); // reshuffle
        pos = 0;
    }
    return list.get(pos++);
    }
}
