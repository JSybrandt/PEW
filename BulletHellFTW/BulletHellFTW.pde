import java.util.Random;

Ship player;
Ship enemy;

ArrayList enemyShips = new ArrayList<Ship>();//the player is not included
ArrayList enemyBullets = new ArrayList<Projectile>();
ArrayList playerBullets = new ArrayList<Projectile>();

Random gen = new Random();

boolean psychedelicMode = false;

void setup() {
   size(480,800);
   imageMode(CENTER);
   smooth();
   noStroke();
   fill(255);
   rectMode(CENTER);     //This sets all rectangles to draw from the center point
    player = new PlayerShip("spaceship.png",600,240);
    enemy = new Drone("Enemy1.png", 200, 200, 4);
    enemyShips.add(enemy);
}
 
 
 int tick = 1;
void draw() {
  
  if(!psychedelicMode)
  background(#000000);
   if(mousePressed)
   {
   player.move();
   if (tick%20==0)
     player.shoot();
   }
   player.display();
   
   
   for(int j = 0; j< enemyShips.size();j++)
        {
          Ship s = (Ship) enemyShips.get(j);
          s.move();
           if (tick%100==0)
            s.shoot();
        }
        
        
  for(int j = 1; j< enemyBullets.size();j++)
        {
          Projectile p = (Projectile) enemyBullets.get(j);
          p.move();
        }
        
        
     for(int j = 1; j< playerBullets.size();j++)
        {
          Projectile p = (Projectile) playerBullets.get(j);
          p.move();
        }
        
        
        collisionDetection();
        
     
     spawner(1,tick);
  
   
   tick++;
   if(tick == 100000)
     tick = 0;
}


void spawner(int l, int t)//l for level , t for ticks
{
  if (l==1)
    if (tick %500 ==0)
      {
        enemyShips.add(new Drone("Enemy1.png", 200, 200, 4));
      }
}
 void collisionDetection()
{
 
   for(int i = 0 ; i< playerBullets.size();i++)
   {
     Projectile p = (Projectile) playerBullets.get(i);
      for(int j = 0; j< enemyShips.size();j++)
        {
          Ship s = (Ship) enemyShips.get(j);
          if (p.isTouching(s))
          {
            s.blowUp();
            p.removeSelf();
          }
        }
   }
   
   
   for(int i = 0; i < enemyBullets.size(); i++)
   {
     Projectile p = (Projectile) enemyBullets.get(i);
      p.move();
      if(p.isTouching(player))
      {
      player.blowUp();
      p.removeSelf();
      }
   }
}

abstract class Actor
{
  int locX, locY, radius, speed;
  boolean dir;
  PImage img;
  void move()
  {
  }
 boolean isTouching(Actor b)
  {
    if(sqrt(pow(locX - b.locX,2) + pow(locY - b.locY,2))<(radius+b.radius))
      return true;
     else
       return false;
  }
  void display()
  {
    image(img, locX, locY);
  }
}


abstract class Projectile extends Actor
{
  int horDisp;
  Projectile(int xpos, int ypos, boolean d, String img)
  {
    locX=xpos;
    locY=ypos;
    dir = d;
    this.img = loadImage(img);
    speed = 4;
    horDisp = 0;
    radius = 7;
  }
    Projectile(int xpos, int ypos, boolean d, String img, int h)
  {
    locX=xpos;
    locY=ypos;
    dir = d;
    radius = 7;
    this.img = loadImage(img);
    speed = 4;
    horDisp = h;
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
    boolean flag = false;
    for(int i = enemyBullets.size()-1 ; i  >= 0;i--)
   {
     Projectile p = (Projectile) enemyBullets.get(i);
      if(p == this)
        {
          enemyBullets.remove(i);
          flag = true;
          break;
        }
   }
   if(!flag)
   for(int i = playerBullets.size()-1 ; i  >= 0;i--)
   {
     Projectile p = (Projectile) playerBullets.get(i);
      if(p == this)
        {
          playerBullets.remove(i);
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

abstract class Ship extends Actor
{
  boolean dir = false; //up cor. to true
  Ship(String imageName)
  {
    radius = 25;
    img = loadImage(imageName);
  }
  void display()
  {
     image(img, locX, locY);
  }
  void move()
  {
  }
  void move(int t)//used to pass the tick count to enemy ships
  {
  }
  void shoot()
  {
   enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png") );
  }
  void blowUp()
  {
    println("BOOM");//we can add in animation here
    removeSelf();
  }
  void removeSelf()
  {
    for(int i = enemyShips.size()-1 ; i  >= 0;i--)
   {
     Ship p = (Ship) enemyShips.get(i);
      if(p == this)
        {
          enemyShips.remove(i);
          break;
        }
   }
  }
}

class Drone extends Ship
  {
    boolean flip = true;
    int speed;
    Drone(String imageName)
    {
      super(imageName);
      speed = 4;
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
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png") );
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",2));
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",-2) );
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",4 ));
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",-4 )); 
  }
  }
  
  
class PlayerShip extends Ship{
  int points;
  PlayerShip(String imageName,int xpos, int ypos)
  {
    super(imageName);
    dir = true;
    radius = 25;
    locX = xpos;
    locY = ypos;
  }
  
    void move()
  {
    image(img, mouseX, mouseY-80);
    locX = mouseX;
    locY = mouseY-80;
  }
  void shoot()
  {
     playerBullets.add( new Bullet(locX, locY, dir , "bullet.png") );
  }
  void blowUp()
  {
    println("THE PLAYER HAS DIED");
    super.blowUp();
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
    
   if(key=='p')
   psychedelicMode = !psychedelicMode;
}


