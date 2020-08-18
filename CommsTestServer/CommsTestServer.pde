import processing.net.*;

Server myServer;
boolean[][] board = new boolean[7][7];
boolean mousePressedPrev = false;
boolean mouseClicked = false;
boolean fullSend = false;
String dataIn;
String dataOut;
int clients = 0;

void setup() {
  size(640, 480);
  myServer = new Server(this, 5204);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      board[i][j] = false;
    }
  }
}

void draw() {
  mouseClicked = mousePressed && !mousePressedPrev;
  background(128);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      fill(board[i][j]?255:0);
      rect(96+i*64,16+j*64,64,64);
      if(tileMouseX()==i && tileMouseY()==j) {
        fill(0x40808080);
        rect(96+i*64,16+j*64,64,64);
        if(mouseClicked) {
          board[i][j] = !board[i][j];
          myServer.write("0,"+str(i)+","+str(j)+","+(board[i][j]?"true":"false"));
        }
      }
    }
  }
  mousePressedPrev = mousePressed;
}

void clientEvent(Client myClient) {
  dataIn = myClient.readString();
  if(dataIn != null) {
    println("s"+dataIn);
    interpretData();
  }
}

void serverEvent(Server myServer, Client myClient) {
  clients++;
}

void disconnectEvent(Client myClient) {
  clients--;
}

void interpretData() {
  String[] list = split(dataIn, ',');
  switch(list[0]) {
    case "0":
      board[int(list[1])][int(list[2])] = boolean(list[3]);
      myServer.write(dataIn);
      break;
    case "1":
      fullSend = true;
      dataOut = "1";
      for(int i=0; i<7; i++) {
        for(int j=0; j<7; j++) {
          dataOut += "," + (board[i][j]?"true":"false");
        }
      }
      myServer.write(dataOut);
      break;
  }
}

int tileMouseX() {
  return floor((mouseX-96)/64);
}

int tileMouseY() {
  return floor((mouseY-16)/64);
}
