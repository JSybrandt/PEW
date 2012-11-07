
Ship player;

void setup() {
   size(480,800);
 
   smooth();
   noStroke();
   fill(255);
   rectMode(CENTER);     //This sets all rectangles to draw from the center point
    player = new PlayerShip("spaceship.png");
}
 
void draw() {
   background(#000000);
   if(mousePressed)
   {
   player.move();
   }
   player.display();
}
abstract class Gun
{
}
abstract class Ship
{
  PImage img;
  float locX, locY;
  color col;
  Ship(String imageName)
  {
    img = loadImage(imageName);
  }
  void display()
  {
     image(img, locX, locY);
  }
  void move()
  {
    image(img, mouseX-30, mouseY-80);
    locX = mouseX-30;
    locY = mouseY-80;
  }
}

class PlayerShip extends Ship{
  PlayerShip(String imageName)
  {
    super(imageName);
  }
}
