import java.util.Collections;
import java.util.List;
import java.util.Arrays;
IntList inputs;

public class C_Randomizer {
  private List<Integer> INPUTS = Arrays.asList(0, 0, 1, 1, 1, 1, 2, 3, 3, 4);
    private Card[][] cards = new Card[7][7];

    //private final List<Integer> list;
    //private int pos = 0;

    public void Randomizer() {
        //list = new ArrayList<Integer>(INPUTS);
        //Collections.shuffle(list);
    }

    /*public int next() {
        if (pos == list.size()) {
        Collections.shuffle(list); //reshuffle
        pos = 0;
    }
    return list.get(pos++);
    }*/
    
    public Card[][] Randomize(){
      inputs = new IntList();
      inputs.append(0);
      resetList();
      Collections.shuffle(INPUTS);
      for(int i=0; i<3; i++) {
        for(int j=0; j<4; j++) {
          if (i == 0 && j == 1){
            Card card = new Card(j,i,5,0,3);
            cards[i][j] = card;
          }else if (i == 0 && j == 2){
            Card card = new Card(j,i,6,0,3);
            cards[i][j] = card;
          }else{
            int val = inputs.get(0);
            inputs.remove(0);
            Card card = new Card(j,i,val,0,0);
            cards[i][j] = card;
            //cards[i][j] = new Card(j,i,val,0,0);
          }
        }
      }
      resetList();
      Collections.shuffle(INPUTS);
      for(int i=3; i<7; i++) {
        for(int j=0; j<3; j++) {
        if (i == 5 && j == 0){
            Card card = new Card(j,i,5,0,4);
            cards[i][j] = card;
          }else if (i == 4 && j == 0){
            Card card = new Card(j,i,6,0,4);
            cards[i][j] = card;
          }else{
            int val = inputs.get(0);
            inputs.remove(0);
            Card card = new Card(j,i,val,0,0);
            cards[i][j] = card;
          }
        }
      }
      resetList();
      Collections.shuffle(INPUTS);
      for(int i=0; i<4; i++) {
        for(int j=4; j<7; j++) {
        if (i == 1 && j == 6){
            Card card = new Card(j,i,5,0,2);
            cards[i][j] = card;
          }else if (i == 2 && j == 6){
            Card card = new Card(j,i,6,0,2);
            cards[i][j] = card;
          }else{
            int val = inputs.get(0);
            inputs.remove(0);
            Card card = new Card(j,i,val,0,0);
            cards[i][j] = card;
          }
        }
      }
      resetList();
      Collections.shuffle(INPUTS);
      for(int i=4; i<7; i++) {
        for(int j=3; j<7; j++) {
        if (i == 6 && j == 5){
            Card card = new Card(j,i,5,0,1);
            cards[i][j] = card;
          }else if (i == 6 && j == 4){
            Card card = new Card(j,i,6,0,1);
            cards[i][j] = card;
          }else{
            int val = inputs.get(0);
            inputs.remove(0);
            Card card = new Card(j,i,val,0,0);
            cards[i][j] = card;
          }
        }
      }
      Card card1 = new Card(3,3,0,0,0);
      cards[3][3] = card1;
      return cards;
    }
    public void resetList (){
      inputs.clear();
      inputs.append(0);
      inputs.append(0);
      inputs.append(1);
      inputs.append(1);
      inputs.append(1);
      inputs.append(1);
      inputs.append(2);
      inputs.append(3);
      inputs.append(3);
      inputs.append(4);
      inputs.shuffle();
    }
}
