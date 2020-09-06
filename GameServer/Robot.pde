public class Robot{
  
  public int robotNum;
  public int x;
  public int y;
  public int dir;
  PImage sample, mask;
  
  //Sets up the robots atributes
  public Robot(int robotName, int robotX,int robotY, int robotDir){
    this.robotNum = robotName;
    this.x = robotX;
    this.y = robotY;
    this.dir = robotDir;
  }
  
  //Turns the robot Left
  public void turnL(){
    this.dir = this.dir - 1;
    if (this.dir <= -1){
    this.dir = 3;
    }
  }
  
  //Turns the robot Right
  public void turnR(){
    this.dir = this.dir + 1;
    if (this.dir >= 4){
    this.dir = 0;
    }
  }
  
  //Moves the robot forward depending on the orintation
  public void moveF(){
    switch(this.dir){
        case 0: this.y = this.y - 1; break;
        case 1: this.x = this.x + 1; break;
        case 2: this.y = this.y + 1; break;
        case 3: this.x = this.x - 1; break;
        
      }
  }
  
  //Moves the robot back depending on the oreintation
  public void moveB(){
    switch(this.dir){
        case 0: this.y = this.y + 1; break;
        case 1: this.x = this.x - 1; break;
        case 2: this.y = this.y - 1; break;
        case 3: this.x = this.x + 1; break;
        
      }
  }
  
  //Draws the robots depending on color and oreintation
  public void draw(){
    switch(this.robotNum){
        case 1: fill(100,0,0); break;
        case 2: fill(0,0,100); break;
        case 3: fill(0,100,0); break;
        case 4: fill(100,100,0); break;
        
    }
    pushMatrix();
    sample = loadImage("RobotSprite.png");
    sample.resize(64, 0);
    mask = loadImage("Mask.png");
    sample.mask(mask);
    translate(this.x*64+48,this.y*64+48);
    switch(this.dir){
      case 0:rotate(0);break;
      case 1:rotate(PI/2);break;
      case 2:rotate(PI*1);break;
      case 3:rotate(PI*1.5);break;
    }
    image(sample, -32, -32);
    rect(-16,-16,32,32);
    popMatrix();
  }
  
  //Stops the robots form moving off the side of the board
  public void border(){
    if (this.x > 6){
    this.x = 6;
    }else if (this.x < 0){
    this.x = 0;
    }
    if (this.y > 6){
    this.y = 6;
    }else if (this.y < 0){
    this.y = 0;
    }
  }
}
