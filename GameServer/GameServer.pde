import processing.net.*;

int[][] boardCards = new int[7][7];
boolean[][] boardState = new boolean[7][7];
boolean mouseClicked = false;
boolean mousePressedPrev = false;
int clients = 0;

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
      fill(boardState[i][j]?255:0);
      rect(16+i*64,16+j*64,64,64);
      if(tileMouseX()==i && tileMouseY()==j) {
        fill(0x40808080);
        rect(16+i*64,16+j*64,64,64);
        //println(str(i) + str(j));
        if(mouseClicked) {
          boardState[i][j] = !boardState[i][j];
          myServer.write("0,"+str(i)+","+str(j)+","+(boardState[i][j]?"true":"false"));
          //print("0,"+str(i)+","+str(j)+","+(boardState[i][j]?"true":"false"));
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
