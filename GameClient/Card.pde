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
    /*fill(0,0,0);
    textSize(12);
    if(this.state == 0){
      switch(this.type){
        //case 0: text("Blank", this.x * 64 + 16, this.y * 64 + 32); break;
        //case 1: text("Bird", this.x * 64 + 16, this.y * 64 + 32); break;
        //case 2: text("Special Bird", this.x * 64 + 16, this.y * 64 + 32); break;
        //case 3: text("Null", this.x * 64 + 16, this.y * 64 + 32); break;
        //case 4: text("Crash", this.x * 64 + 16, this.y * 64 + 32); break;
        //case 5: text("Hello World", this.x * 64 + 16, this.y * 64 + 32); break;
        //case 6: text("Nest", this.x * 64 + 16, this.y * 64 + 32); break;
      //}
    //}*/
  //text(this.type, this.x * 64 + 16, this.y * 64 + 32);
  }
  
  public void deCarry(int robotNum){
    if(this.state == 1 && this.team == robotNum){
      this.state = 0;
      this.team = 0;
    }
    
  }
  
  public void draw(){
    int squareColor = 0;
    if(this.y==3 && this.x==3 || this.state != 0){//White
      squareColor = 2;
    }else if(this.y<=2 && this.x<=3){//green
      squareColor = 1;
    }else if(this.y<=3 && this.x>=4){//blue
      squareColor = 3;
    }else if(this.y>=3 && this.x<=2){//yellow
      squareColor = 4;
    }else if(this.y>=4 && this.x>=3){//red
      squareColor= 5;
    }
    switch(squareColor){
      case 1: fill(0,255,0); break;
      case 2: fill(255,255,255); break;
      case 3: fill(0,0,255); break;
      case 4: fill(255,255,0); break;
      case 5: fill(255,0,0); break;
    }
    rect(16+this.x*64,16+this.y*64,64,64);
  }
  
}
