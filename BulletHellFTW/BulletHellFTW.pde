import java.util.Random;

Ship player;
Ship enemy;

ArrayList level = new ArrayList<Ship>();
ArrayList bullets = new ArrayList<Projectile>();

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
 
 
 int tick = 0;
void draw() {
  background(#000000);
   if(mousePressed)
   {
   player.move();
   if (tick%20==0)
     player.shoot();
   }
   player.display();
   enemy.move();
   if (tick%100==0)
     enemy.shoot();
   for(int i = 0 ; i< bullets.size();i++)
   {
     Projectile p = (Projectile) bullets.get(i);
      p.move();
   }
   tick++;
}


abstract class Projectile
{
  int locX, locY, speed, horDisp;
  boolean dir;
  PImage img;
  Projectile(int xpos, int ypos, boolean d, String img)
  {
    locX=xpos;
    locY=ypos;
    dir = d;
    this.img = loadImage(img);
    speed = 4;
    horDisp = 0;
    bullets.add(this);
  }
    Projectile(int xpos, int ypos, boolean d, String img, int h)
  {
    locX=xpos;
    locY=ypos;
    dir = d;
    this.img = loadImage(img);
    speed = 4;
    horDisp = h;
    bullets.add(this);
  }
  
  
  void move()
  {
    if(dir)
      locY -=speed;
    else
      locY += speed;
      
    locX+= horDisp;
      
    if(locY < -10 || locX > 810 || locX < -10 || locX > 490)
      removeSelf();
    image(img, locX, locY);
  }
  void removeSelf()
  {
    for(int i = bullets.size()-1 ; i  >= 0;i--)
   {
     Projectile p = (Projectile) bullets.get(i);
      if(p == this)
        {
          bullets.remove(i);
          break;
        }
   }
  }
}

class Bullet extends Projectile
{
  Bullet(int xpos, int ypos, boolean d, String img)
  {
     super(xpos,ypos,d,img);
  }
  Bullet(int xpos, int ypos, boolean d, String img, int h)
  {
    super(xpos,ypos,d,img,h);
  }
}

abstract class Ship
{
  PImage img;
  int locX, locY;
  color col;
  boolean dir = false; //up cor. to true
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
  void shoot()
  {
    new Bullet(locX, locY, dir , "bullet.png");
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
     void shoot()
  {
    new Bullet(locX, locY, dir , "bullet.png");
    new Bullet(locX, locY, dir , "bullet.png",1);
    new Bullet(locX, locY, dir , "bullet.png",-1);
    new Bullet(locX, locY, dir , "bullet.png",2);
    new Bullet(locX, locY, dir , "bullet.png",-2);
    new Bullet(locX, locY, dir , "bullet.png",3);
    new Bullet(locX, locY, dir , "bullet.png",-3);
  }
  }
  
  
class PlayerShip extends Ship{
  int points;
  PlayerShip(String imageName)
  {
    super(imageName);
    dir = true;
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


void keyPressed() {
  if(key == ' ')
    player.shoot();
}


