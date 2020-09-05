import processing.net.*; 

Client myClient; 
Card[][] boardCards = new Card[7][7];//which card
boolean mousePressedPrev = false;
boolean mouseClicked = false;
String dataIn;
int curRobot = 1;
int repeatTimes2 = 1;
int repeatTimes3 = 1;
int timer = 6000;
 
int scoreTeam1 = 0;
int scoreTeam2 = 0;
int scoreTeam3 = 0;
int scoreTeam4 = 0;
int[] scores = {scoreTeam1,scoreTeam2,scoreTeam3,scoreTeam4};
int[] programList = {7,7,7,7,7,7};
int codeNum = 0;
int runningCode = 0;
int[] blockTypes = {0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,6};
 
Robot robot1 = new Robot(1,5,6,0);
Robot robot2 = new Robot(2,6,1,3);
Robot robot3 = new Robot(3,1,0,2);
Robot robot4 = new Robot(4,0,5,1);
C_Randomizer c_Randomizer = new C_Randomizer();
Robot[] robotList = {robot1,robot2, robot3, robot4};
DragNDrop[] codeBlocks = new DragNDrop[blockTypes.length];

void setup() { 
  size(1280, 720); 
  myClient = new Client(this, /*"172.12.152.42"*/"10.0.0.21", 5204);
  boardCards = c_Randomizer.Randomize();
  for(int i = 0; i < blockTypes.length;i++){
    DragNDrop dragNDrop = new DragNDrop(blockTypes[i],512,32 + blockTypes[i]*64);
    codeBlocks[i] = dragNDrop;
  }
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
  for(int i = 0;i<programList.length;i++){
    fill(100,100,100);
    rect(1000,64+ i*48,128,48);
    //print(programList[i]);
  }
  println();
  for(int i= 0;i<codeBlocks.length;i++){
    codeBlocks[i].setup();
    codeBlocks[i].draw();
    int[] tempReturn = codeBlocks[i].control(programList);
    if(tempReturn[0] != 0){
    programList[tempReturn[0]-1] = tempReturn[1];
    }
  mousePressedPrev = mousePressed;
}
if(timer <= 0){
    runCode();
  }
  textSize(32);
  fill(255,255,255);
  text(constrain(floor(timer/100),0,60), 1200, 64);
  textSize(12);
}

public void runCode(){
  runningCode = 1;
  //int forceOut = 0;
  //for(int j = 0;j < 1;j++){
    //for(int i = 0;i < programList.length && forceOut == 0;i++){
  switch(programList[codeNum]){
    case 0: robotList[curRobot - 1].moveF(); break;
    case 1: robotList[curRobot - 1].moveB(); break;
    case 2: robotList[curRobot - 1].turnL(); break;
    case 3: robotList[curRobot - 1].turnR(); break;
    case 4: pickUpCard(); break;
    case 5: if(repeatTimes2 < 2){
      repeatTimes2++;
      codeNum = -1;
      //forceOut = 1;
    }
    break;
    
    case 6: if(repeatTimes3 < 3){
      repeatTimes3++;
      codeNum = -1;
      //forceOut = 0;
    }
    break;
    
  }
  if(codeNum == 5){
    runningCode = 0;
    codeNum = -1;
    repeatTimes2 = 1;
    repeatTimes3 = 1;
    timer = 6000;
    for(int i = 0;i < codeBlocks.length;i++){
      codeBlocks[i].reset();
    }
    for(int i = 0;i < programList.length;i++){
      programList[i] = 7;
    }
  }
  codeNum++;
  for(int i = 0;i<robotList.length; i++){
    robotList[i].border();
  }
  myClient.write("7,"+runningCode);
  myClient.write("2,"+str(robotList[curRobot - 1].robotNum)+","+str(robotList[curRobot - 1].x)+","+str(robotList[curRobot - 1].y)+","+str(robotList[curRobot - 1].dir));
  delay(500);
    ///}
    //forceOut = 0;
  //}
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

public void pickUpCard(){
myClient.write("4");
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
}

void mousePressed(){
  for(int i= 0;i<codeBlocks.length;i++){
    int[] tempList = codeBlocks[i].cordReturn();
    if(mouseX > tempList[0]&& mouseY>tempList[1] && mouseX < tempList[0] +tempList[2] && mouseY < tempList[1] +tempList[3]){
     codeBlocks[i].heldOn();
     i = codeBlocks.length;
    }
  }
  if(mouseX > 1000 && mouseX < 1128 && mouseY > 64 && mouseY < 400){
    programList[constrain(floor((mouseY-64)/48),0,5)] = 7;
  }
}
void mouseReleased(){
  for(int i= 0;i<codeBlocks.length;i++){
    codeBlocks[i].heldOff();
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
    case "6":
      timer = int(list[1]);
    break;
  }
}
