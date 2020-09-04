import processing.net.*; 

Client myClient; 
Card[][] boardCards = new Card[7][7];//which card
boolean mousePressedPrev = false;
boolean mouseClicked = false;
String dataIn;
int curRobot = 1;
 
int scoreTeam1 = 0;
int scoreTeam2 = 0;
int scoreTeam3 = 0;
int scoreTeam4 = 0;
int[] scores = {scoreTeam1,scoreTeam2,scoreTeam3,scoreTeam4};
 
Robot robot1 = new Robot(1,5,6,0);
Robot robot2 = new Robot(2,6,1,3);
Robot robot3 = new Robot(3,1,0,2);
Robot robot4 = new Robot(4,0,5,1);
C_Randomizer c_Randomizer = new C_Randomizer();
Robot[] robotList = {robot1,robot2, robot3, robot4};

void setup() { 
  size(1280, 720); 
  myClient = new Client(this, /*"172.12.152.42"*/"10.0.0.21", 5204);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      //boardState[i][j] = false;
    }
  }
  boardCards = c_Randomizer.Randomize();
} 
 
void draw() {
  mouseClicked = mousePressed && !mousePressedPrev;
  background(44, 62, 80);
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      boardCards[i][j].draw();
    }
  }
  for(int i=0; i<7; i++) {
    for(int j=0; j<7; j++) {
      boardCards[i][j].show();
      //print(boardCards[i][j].type);
      //print("  ");
    }
    //println();
  }
  for (int i = 0; i < scores.length;i++){
    switch(i){
      case 0: fill(255,0,0);break;
      case 1: fill(0,0,255);break;
      case 2: fill(0,255,0);break;
      case 3: fill(255,255,0);break;
    }
    textSize(32);
    text(scores[i], 464, i * 32 + 32);
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

/*int whatColor(int i, int j){
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
}*/

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
    myClient.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  
  }
  if ((key == 's' || key == 'S')) {
    robotList[curRobot - 1].moveB();
    myClient.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  
  }
  if ((key == 'a' || key == 'A')) {
    robotList[curRobot - 1].turnL();
    myClient.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  
  }
  if ((key == 'd' || key == 'D')) {
    robotList[curRobot - 1].turnR();
    myClient.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  
  }
  
  //interact with cards
  if (key == ' ') {
    myClient.write("4");
//    if(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].state == 0){
//        switch(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].type){
//          case 0: /*println("blank");*/ break;
//          case 1: if(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].team == 0){boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].state = 1; boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].team = curRobot; println("Bird");} break;
//          case 2: if(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].team == 0){boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].state = 1; boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].team = curRobot; println("Special Bird");} break;
//          case 3: switch(curRobot){
//            case 1: robotList[curRobot - 1].y = 6; robotList[curRobot - 1].x = 5; break;
//            case 2: robotList[curRobot - 1].y = 2; robotList[curRobot - 1].x = 6; break;
//            case 3: robotList[curRobot - 1].y = 1; robotList[curRobot - 1].x = 2; break;
//            case 4: robotList[curRobot - 1].y = 5; robotList[curRobot - 1].x = 1; break;   
//          }
//          for(int i=0; i<7; i++) {
//            for(int j=0; j<7; j++) {
//              boardCards[i][j].deCarry(curRobot);
//              robotList[curRobot-1].dir = 0;
//              //print(boardCards[i][j].type);
//              //print("  ");
//            }
//            //println();
//          }
//          println("Null");
//          break;
//          case 4: switch(curRobot){
//            case 1: robotList[curRobot - 1].y = 6; robotList[curRobot - 1].x = 5; break;
//            case 2: robotList[curRobot - 1].y = 2; robotList[curRobot - 1].x = 6; break;
//            case 3: robotList[curRobot - 1].y = 1; robotList[curRobot - 1].x = 2; break;
//            case 4: robotList[curRobot - 1].y = 5; robotList[curRobot - 1].x = 1; break;  
//          }
//          for(int i=0; i<7; i++) {
//            for(int j=0; j<7; j++) {
//              boardCards[i][j].deCarry(curRobot);
//              robotList[curRobot-1].dir = 0;
//              //print(boardCards[i][j].type);
//              //print("  ");
//            }
//            //println();
//          }
//          println("Crash");
//          break;
//          case 5: println("Hello World"); break;
//          case 6: 
//          if(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].team == curRobot){
//            for(int i=0; i<7; i++) {
//              for(int j=0; j<7; j++) {
//                if(boardCards[i][j].state == 1 && boardCards[i][j].team == curRobot){
//                  boardCards[i][j].state = 2;
//                  switch(boardCards[i][j].type){
//                    case 1: scores[curRobot - 1]++; break;
//                    case 2: scores[curRobot - 1] = scores[curRobot - 1] + 2; break;
//                  }
//                }
//              }
//            }
//            println("Cards Secured");
//          }
//          break;
//        }
//      }
      //myClient.write("3,"+str(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].x)+","+str(robotList[curRobot - 1].x)+","+str(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].y)+","+str(boardCards[robotList[curRobot - 1].y][robotList[curRobot - 1].x].state));
    }
  
  //runs the border subroutine
  for(int i = 0;i<robotList.length; i++){
    robotList[i].border();
  }
  
  
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
    case "3":
      boardCards[int(list[2])][int(list[1])].type = int(list[3]);
      boardCards[int(list[2])][int(list[1])].state = int(list[4]);
      boardCards[int(list[2])][int(list[1])].team = int(list[5]);
      //robotList[int(list[1]) - 1].y = int(list[3]);
      //robotList[int(list[1]) - 1].dir = int(list[4]);
    break;
    case "5":
      scores[int(list[2])] = int(list[1]);
    break;
  }
}
