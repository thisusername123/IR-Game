public class Robot{
  
  public int robotNum;
  public int x;
  public int y;
  public int dir;
  
  //Sets up the robots atributes
  public Robot(int robotName, int robotX,int robotY, int robotDir){
    this.robotNum = robotName;
    this.x = robotX * 64 + 16;
    this.y = robotY * 64 + 16;
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
        case 0: this.y = this.y - 64; break;
        case 1: this.x = this.x + 64; break;
        case 2: this.y = this.y + 64; break;
        case 3: this.x = this.x - 64; break;
        
      }
  }
  
  //Moves the robot back depending on the oreintation
  public void moveB(){
    switch(this.dir){
        case 0: this.y = this.y + 64; break;
        case 1: this.x = this.x - 64; break;
        case 2: this.y = this.y - 64; break;
        case 3: this.x = this.x + 64; break;
        
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
    rect(this.x, this.y,64,64);
    fill(0,0,0);
    switch(this.dir){
      case 0:rect(this.x + 24, this.y,16,16); break;
      case 1:rect(this.x + 48, this.y + 24,16,16); break;
      case 2:rect(this.x + 24, this.y + 48,16,16); break;
      case 3:rect(this.x, this.y + 24,16,16); break;
    }
  }
  
  //Stops the robots form moving off the side of the board
  public void border(){
    if (this.x > 400){
    this.x = 400;
    }else if (this.x < 16){
    this.x = 16;
    }
    if (this.y > 400){
    this.y = 400;
    }else if (this.y < 16){
    this.y = 16;
    }
  }
}
