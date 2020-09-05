public class DragNDrop{
  
  PImage photo, maskImage;
  public int x = 512;
  public int y = 32;
  public int locked = 0;
  public int heldPrev = 0;
  boolean held = false;
  public DragNDrop(){
    
  }
  public void setup() {
    photo = loadImage("DragBlock.png");
    maskImage = loadImage("DragBlockMask.png");
    photo.mask(maskImage);
  }
  
  public void draw() {
    image(photo, x, y);
    textSize(16);
    text("Move Forward",x+8,y+22);
    control();
  }
  
  public void control(){
    if(held){
      x = mouseX - photo.width / 2;
      y = mouseY - photo.height / 2;
      this.heldPrev =1;
    }
    if(held == false){
      if((mouseX > 1000 && mouseX < 1128 && mouseY > 64 && mouseY < 400 && this.locked == 0 && heldPrev == 1)  || this.locked == 1){
        this.locked=1;
        x = 1000;
        y = 72+ 48*(floor((y-64)/48));
        
      
      }else{
        x= 512;
        y = 32;
      }
      heldPrev = 0;
    }
  }
  
  public void heldOn(){
    held = true;
    this.locked=0;
  }
  public void heldOff(){
    held = false;
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
