import processing.net.*; 

Client myClient; 
boolean[][] boardState = new boolean[7][7];
boolean mousePressedPrev = false;
boolean mouseClicked = false;
String dataIn;
 
void setup() { 
  size(1280, 720); 
  myClient = new Client(this, "172.12.152.42", 5204);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      boardState[i][j] = false;
    }
  }
  myClient.write("1");
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
        if(mouseClicked) {
          boardState[i][j] = !boardState[i][j];
          myClient.write("0,"+str(i)+","+str(j)+","+(boardState[i][j]?"true":"false"));
        }
      }
    }
  }
  mousePressedPrev = mousePressed;
}

int tileMouseX() {
  return floor((mouseX-16)/64);
}

int tileMouseY() {
  return floor((mouseY-16)/64);
}

void clientEvent(Client myClient) {
  dataIn = myClient.readString();
  if(dataIn != null) {
    println("c"+dataIn);
    interpretData();
  }
}

void interpretData() {
  String[] list = split(dataIn, ',');
  switch(list[0]) {
    case "0":
      boardState[int(list[1])][int(list[2])] = boolean(list[3]);
      break;
    case "1":
      for(int i=0; i<49; i++) {
        boardState[i/7][i%7] = boolean(list[i+1]);
      }
      break;
  }
}
