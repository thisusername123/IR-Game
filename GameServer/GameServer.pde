import processing.net.*;
/**
*  4 named bird Cards worth 2 each
*  bird card worth 2 each
*/
int[][] boardCards = new int[7][7];//which card
boolean[][] boardState = new boolean[7][7];//picked up or not
boolean mouseClicked = false;
boolean mousePressedPrev = false;
int clients = 0;

int scoreTeam1 = 0;
int scoreTeam2 = 0;
int scoreTeam3 = 0;
int scoreTeam4 = 0;

Robot robot1 = new Robot();
Robot robot2 = new Robot();
Robot robot3 = new Robot();
Robot robot4 = new Robot();

Server myServer;

void setup() {
  size(1280, 720);
  myServer = new Server(this, 5204);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      boardState[i][j] = false;
    }
  }  
}

void draw() {
  mouseClicked = mousePressed && !mousePressedPrev;
  background(44, 62, 80);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      switch(whatColor(i, j)){
        case 1: fill(0,255,0); break;
        case 2: fill(255,255,255); break;
        case 3: fill(0,0,255); break;
        case 4: fill(255,255,0); break;
        case 5: fill(255,0,0); break;
      }
      rect(16+i*64,16+j*64,64,64);
      if(tileMouseX()==i && tileMouseY()==j) {
        fill(0x40808080);
        rect(16+i*64,16+j*64,64,64);
        if(mouseClicked) {
          boardState[i][j] = !boardState[i][j];
          myServer.write("0,"+str(i)+","+str(j)+","+(boardState[i][j]?"true":"false"));
        }
      }
    }
  }
  mousePressedPrev = mousePressed;
}

int tileMouseX() {
  return floor((mouseX-16)/64);//94,64
}

int tileMouseY() {
  return floor((mouseY-16)/64);
}

void serverEvent() {
  clients++;
}

void disconnectEvent() {
  clients--;
}

int whatColor(int i, int j){
  int squareColor =0;
  if(i<=3 && j<=3){//green
    squareColor = 1;
  }
  if(i==3 && j==3){//middle
    squareColor = 2;
  }
  if(i>=4 && j<=4){//blue
    squareColor = 3;
  }
  if(i<=2 && j>=3){//yellow
    squareColor = 4;
  }
  if(i>=3 && j>=4){//red
    squareColor= 5;
  }
  return squareColor;
}
