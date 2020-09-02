public class Card{
  
  public int x;
  public int y;
  public int type;
  public int state;
  public int team;
  
  public Card(int cardX, int cardY, int cardType, int cardState, int cardTeam){
    this.x = cardX;
    this.y = cardY;
    this.type = cardType;
    this.state = cardState;
    this.team = cardTeam;
  }
  
  public void show(){
  text(this.type, this.x, this.y);
  }
  
  
  
}
