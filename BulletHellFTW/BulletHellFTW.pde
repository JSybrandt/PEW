import java.util.Random;

Ship player;
Ship enemy;

ArrayList level = new ArrayList<Ship>();

Random gen = new Random();

void setup() {
   size(480,800);
   imageMode(CENTER);
   smooth();
   noStroke();
   fill(255);
   rectMode(CENTER);     //This sets all rectangles to draw from the center point
    player = new PlayerShip("spaceship.png");
    enemy = new Drone("Enemy1.png", 200, 200, 4);
}
 
void draw() {
   background(#000000);
   if(mousePressed)
   {
   player.move();
   }
   player.display();
   enemy.move();
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
  }
}

class Drone extends Ship
  {
    boolean flip = true;
    int speed;
    Drone(String imageName)
    {
      super(imageName);
      speed = 3;
    }
    Drone(String imageName, int xpos, int ypos, int speed)
    {
      super(imageName);
      locX = xpos;
      locY = ypos;
      this.speed = speed;
    }
    void move()
    {
     if (flip)
       locX += speed;
      else
        locX -= speed;
     if(locX > 430 || locX < 50)
     {
       locY += speed*3;
       flip = !flip;
     }
      image(img, locX, locY);
    }
  }
  
  
class PlayerShip extends Ship{
  int points;
  PlayerShip(String imageName)
  {
    super(imageName);
  }
  
    void move()
  {
    image(img, mouseX, mouseY-80);
    locX = mouseX;
    locY = mouseY-80;
  }
}

class Money
{
  int worth;
  Money(int w)
  {
    worth = w;
  }
}


