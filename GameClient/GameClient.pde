import processing.net.*; 

Client myClient; 
boolean[][] boardState = new boolean[7][7];
boolean mousePressedPrev = false;
boolean mouseClicked = false;
String dataIn;
int curRobot = 1;
 
int scoreTeam1 = 0;
int scoreTeam2 = 0;
int scoreTeam3 = 0;
int scoreTeam4 = 0;
 
Robot robot1 = new Robot(1,384,384,0);
Robot robot2 = new Robot(2,384,0,3);
Robot robot3 = new Robot(3,0,0,2);
Robot robot4 = new Robot(4,0,384,1);
Robot[] robotList = {robot1,robot2, robot3, robot4};

void setup() { 
  size(1280, 720); 
  myClient = new Client(this, /*"172.12.152.42"*/"10.0.0.21", 5204);
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
          //myClient.write("0,"+str(i)+","+str(j)+","+(boardState[i][j]?"true":"false"));
        }
      }
    }
  }
  
  for(int i = 0;i<robotList.length; i++){
    robotList[i].draw();
  }
  //Sends the robot info to the server
  mousePressedPrev = mousePressed;
}

int tileMouseX() {
  return floor((mouseX-16)/64);
}

int tileMouseY() {
  return floor((mouseY-16)/64);
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
  
  myClient.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  
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
      //boardState[int(list[1])][int(list[2])] = boolean(list[3]);
      break;
    case "1":
      /*for(int i=0; i<49; i++) {
        boardState[i/7][i%7] = boolean(list[i+1]);
      }*/
      break;
    case "2":
      robotList[int(list[1]) - 1].x = int(list[2]);
      robotList[int(list[1]) - 1].y = int(list[3]);
      robotList[int(list[1]) - 1].dir = int(list[4]);
    break;
  }
}
