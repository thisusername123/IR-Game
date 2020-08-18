import processing.net.*;

int[] board = new int[49];
boolean[] boardState = new boolean[49];

robot1 = new Robot()

Server myServer;

void setup() {
  size(1920, 1080);
  myServer = new Server(this, 5204);
}

void draw() {
  
}
