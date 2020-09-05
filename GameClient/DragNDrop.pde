public class DragNDrop{
  
  PImage photo, maskImage;
  public int x = 512;
  public int y = 32;
  public int locked = 0;
  public int heldPrev = 0;
  public int type = 0;
  boolean held = false;
  int[] returnNum;
  public DragNDrop(int dragType,int XIn, int YIn){
    this.type = dragType;
    this.x = XIn;
    this.y = YIn;
  }
  public void setup() {
    photo = loadImage("DragBlock.png");
    maskImage = loadImage("DragBlockMask.png");
    photo.mask(maskImage);
  }
  
  public void draw() {
    image(photo, x, y);
    textSize(16);
    switch(this.type){
      case 0:text("Move Forward",x+8,y+22);break;
      case 1:text("Move Backward",x+8,y+22);break;
      case 2:text("Turn Left",x+8,y+22);break;
      case 3:text("Turn Right",x+8,y+22);break;
      case 4:text("Pick up Card",x+8,y+22);break;
      case 5:text("Repeat X2",x+8,y+22);break;
      case 6:text("Repeat X3",x+8,y+22);break;
    }
    //control();
    //int[] returnNum = {floor((y-64)/48),this.type};
  }
  
  public int[] control(int[] inCode){
    int[] returnNum = {0,0};
    if(held){
      x = mouseX - photo.width / 2;
      y = mouseY - photo.height / 2;
      this.heldPrev =1;
    }
    if(held == false){
      if((mouseX > 1000 && mouseX < 1128 && mouseY > 64 && mouseY < 400 && this.locked == 0 && heldPrev == 1 && inCode[constrain(floor((y-64)/48),0,5)] == 7)  || this.locked == 1){
        this.locked=1;
        x = 1000;
        y = 72+ 48*(floor((y-64)/48));
        returnNum[0] = constrain(floor((y-64)/48),0,5) + 1;
        returnNum[1] = this.type;
      
      }else{
        x= 512;
        y = 32 + this.type*64;
      }
      heldPrev = 0;
    }
    return(returnNum);
  }
  
  public void heldOn(){
    held = true;
    this.locked=0;
  }
  public void heldOff(){
    held = false;
  }
  public void reset(){
   this.locked = 0;
  }
  
  
  public int[] cordReturn(){
    int[] tempList = {x,y,photo.width,photo.height};
    return tempList;
  }
     
    // ------------------------------------------
  /*   
    void mousePressed(){
    if(mouseX >x && mouseY>y && mouseX < x +photo.width && mouseY < y +photo.height){
      held = true;
    }
  }
  void mouseReleased(){
    held = false;
  }
    */ 
    // ===========================================
}
