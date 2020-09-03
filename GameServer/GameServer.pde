import processing.net.*;

Randomizer randomizer = new Randomizer();
int[][] boardCards = new int[7][7];//which card
boolean[][] boardState = new boolean[7][7];//picked up or not
boolean mouseClicked = false;
boolean mousePressedPrev = false;
int clients = 0;
boolean fullSend = false;
String dataOut;
String dataIn;
int curRobot = 1;

int scoreTeam1 = 0;
int scoreTeam2 = 0;
int scoreTeam3 = 0;
int scoreTeam4 = 0;

//Assigning the robots valuables and adds them to an array
Robot robot1 = new Robot(1,6,6,0);
Robot robot2 = new Robot(2,6,0,3);
Robot robot3 = new Robot(3,0,0,2);
Robot robot4 = new Robot(4,0,6,1);
Robot[] robotList = {robot1,robot2, robot3, robot4};

Server myServer;

void setup() {
  size(1280, 720);
  myServer = new Server(this, 5204);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      boardState[i][j] = false;
    }
  }
  randomizeCards();
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      print(boardCards[i][j]);
      print("  ");
    }
    println();
  }
  
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      print(boardState[i][j]);
      print("  ");
    }
    println();
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
          myServer.write("3,"+str(i)+","+str(j)+","+(boardCards[i][j]));
          print(boardCards[i][j] + " " + boardState[i][j] + "; ");
        }
      }
    }
  }
  
  //runs the functions to draw the robots
  for(int i = 0;i<robotList.length; i++){
    robotList[i].draw();
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
  int squareColor = 0;
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
void  keyReleased() 
{
  
  //Selects the diferent robots based on the key pressed
  if ((key == '1')) {
    curRobot = 1;
  }else if ((key == '2')) {
    curRobot = 2;
  }else if ((key == '3')) {
    curRobot = 3;
  }else if ((key == '4')) {
    curRobot = 4;
  }
  
  //runs the movement subroutines depends on the key pressed
  if ((key == 'w' || key == 'W')) {
    robotList[curRobot - 1].moveF();
  }
  if ((key == 's' || key == 'S')) {
    robotList[curRobot - 1].moveB();
  }
  if ((key == 'a' || key == 'A')) {
    robotList[curRobot - 1].turnL();
  }
  if ((key == 'd' || key == 'D')) {
    robotList[curRobot - 1].turnR();
  }
  
  //runs the border subroutine
  for(int i = 0;i<robotList.length; i++){
    robotList[i].border();
  }
  
  //Sends the robot info to the client
  myServer.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  
}

void clientEvent(Client myClient) {
  dataIn = myClient.readString();
  if(dataIn != null) {
    println("s"+dataIn);
    interpretData();
  }
}

/*void clientEvent(Server myServer) {
  dataIn = myServer.readString();
  if(dataIn != null) {
    println("c"+dataIn);
    interpretData();
  }
}*/

void interpretData() {
  String[] list = split(dataIn, ',');
  switch(list[0]) {
    case "0":
      //boardState[int(list[1])][int(list[2])] = boolean(list[3]);
      break;
    case "1":
      /*fullSend = true;
      dataOut = "1";
      //myServer.write(dataOut);*/
      break;
    case "2":
      int robotInputNum = int(list[1]) - 1;
      robotList[robotInputNum].x = int(list[2]);
      robotList[robotInputNum].y = int(list[3]);
      robotList[robotInputNum].dir = int(list[4]);
    break;
  }
}

/**
*  card IDs:
*  0 Blank    2 per area
*  1 Bird    4 per area
*  2 Special Bird    1 per area
*  3 Null    2 per area
*  4 Crash    1 per area
*/
void randomizeCards(){
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      if(i<=2 && j<=3){//top left
        boardCards[i][j] = randomizer.next();
        }else if(i>=3 && j<=2){ //bottom left
          boardCards[i][j] = randomizer.next();
        }else if(i<=3 && j>=4){ //top right
          boardCards[i][j] = randomizer.next();
        }else if(i>=3 && j>=3){ //bottom right also controls middle
          boardCards[i][j] = randomizer.next();
        }else{
          //boardCards[i][j] = randomizer.next();
        }
      
    }
  }
}
