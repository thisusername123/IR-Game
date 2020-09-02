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
  fill(0,0,0);
  switch(this.type){
    case 0: text("Blank", this.x * 64 + 16, this.y * 64 + 32); break;
    case 1: text("Bird", this.x * 64 + 16, this.y * 64 + 32); break;
    case 2: text("Special Bird", this.x * 64 + 16, this.y * 64 + 32); break;
    case 3: text("Null", this.x * 64 + 16, this.y * 64 + 32); break;
    case 4: text("Crash", this.x * 64 + 16, this.y * 64 + 32); break;
    case 5: text("Hello World", this.x * 64 + 16, this.y * 64 + 32); break;
    case 6: text("Nest", this.x * 64 + 16, this.y * 64 + 32); break;
  }
  //text(this.type, this.x * 64 + 16, this.y * 64 + 32);
  }
  
  
  
}
