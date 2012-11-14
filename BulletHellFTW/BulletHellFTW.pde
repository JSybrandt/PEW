import java.util.Random;

PlayerShip player;
Ship enemy;

PFont f;

ArrayList enemyShips = new ArrayList<Ship>();//the player is not included
ArrayList enemyBullets = new ArrayList<Projectile>();
ArrayList playerBullets = new ArrayList<Projectile>();
ArrayList items = new ArrayList<Item>();//misc stuff and items

Random gen = new Random();

boolean psychedelicMode = false;

void setup() {
   size(480,800);
   imageMode(CENTER);
   smooth();
   noStroke();
   fill(255);
   rectMode(CENTER);     //This sets all rectangles to draw from the center point
    player = new PlayerShip("spaceship.png",200,200);
    enemy = new Drone("Enemy1.png", 200, 200, 4);
    enemyShips.add(enemy);
    
    
    f =  createFont("Impact",24,true);
    textFont(f,24);
    fill(255);
}
 
 
 int tick = 1;
void draw() {
  
  if(!psychedelicMode)
  background(#000000);
  
  
   if(mousePressed)
   {
   player.move();
   if (tick%3==0)
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
        
        
  for(int j = 0; j< enemyBullets.size();j++)
        {
          Projectile p = (Projectile) enemyBullets.get(j);
          p.move();
        }
        
        
     for(int j = 0; j< playerBullets.size();j++)
        {
          Projectile p = (Projectile) playerBullets.get(j);
          p.move();
        }
      for(int j = 0; j< items.size();j++)
        {
          Item p = (Item) items.get(j);
          p.move();
        }
     
       
        collisionDetection();
        
        text("Score: " + player.getScore(),10,20);
        text("Bullet Count: " + (enemyBullets.size() + playerBullets.size()),10,50);
        text("Ship Count: " + enemyShips.size(),10,100);
     
     spawner(1,tick);
   tick++;
   if(tick == 100000)
     tick = 0;
}


void spawner(int l, int t)//l for level , t for ticks
{
  if (l==1)
    if (tick %50 ==0)
      {
        
        enemyShips.add(new Drone("Enemy1.png", gen.nextInt(300)+50, gen.nextInt(300)+50, 4));
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
            s.hit();
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
      player.hit();
      p.removeSelf();
      }
   }
   
   
    for(int i = 0; i < items.size(); i++)
   {
     Item p = (Item) items.get(i);
      p.move();
      if(p.isTouching(player))
      {
         p.act();
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
  Projectile(int xpos, int ypos, boolean d, String img, int h, int s)
  {
    locX=xpos;
    locY=ypos;
    dir = d;
    this.img = loadImage(img);
    speed = s;
    horDisp = h;
    radius = 7;
  }
   
  void move()
  {
    if(dir)
      locY -=speed;
    else
      locY += speed;
      
    locX+= horDisp;
      
    if(locY < -10 || locY > 810 || locX < -10 || locX > 490)
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
  Bullet(int xpos, int ypos, boolean d, String img, int h,int s)
  {
    super(xpos,ypos,d,img,h,s);
    radius = 7;
  }
}

abstract class Ship extends Actor
{
  int health = 1;
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
  void hit()
  {
    health--;
    if(health == 0)
      blowUp();
  }
  void shoot()
  {
   enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",0,5) );
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
      health = 5;
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
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",0,5) );
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",2,4));
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",-2,4) );
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",4,3 ));
    enemyBullets.add( new Bullet(locX, locY, dir , "bullet.png",-4,3 )); 
  }
  
  void blowUp()
  {
   int w = gen.nextInt(20)+1;
   new Money( locX, locY,  w);
   super.blowUp();
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
    speed = 10;
  }
  
    void move()
  {
    boolean flag = true;
    int dX,dY;
    float magnitude;
    dX = mouseX - locX;
    dY = mouseY-80 - locY;
    if(abs(dX) > 5 || abs(dY) > 5)
    {
    magnitude = sqrt(dX*dX+dY*dY);
    locX += int(speed*dX/( magnitude));
    locY += int(speed*dY/( magnitude));
    }
      
    image(img, locX, locY);
    
    
    
    
  }
  boolean left = false;
  void shoot()
  {
    if(left)
    playerBullets.add( new Bullet(locX + 10, locY-10, dir , "playerbullet.png",0,15) );
    else
     playerBullets.add( new Bullet(locX - 10, locY-10, dir , "playerbullet.png",0,15) );
     
    left = !left;
  }
  void blowUp()
  {
    println("THE PLAYER HAS DIED");
    super.blowUp();
  }
  void addMoney(int p)
  {
    points+=p;
  }
  
  int getScore()
  {
    return points;
  }
}


abstract class Item extends Actor
{
  int worth;
  int speed = 1;
  Item(int posx, int posy, String imgName)
  {
    locX = posx;
    locY = posy;
    img = loadImage(imgName);
    items.add(this);
  }
  void move()
  {
    locY += speed;
    if(locY > 800)
      removeSelf();
    image(img, locX, locY);
  }
  
  void removeSelf()
  {
      for(int i = items.size()-1 ; i  >= 0;i--)
   {
     Item p = (Item) items.get(i);
      if(p == this)
        {
          items.remove(i);
          break;
        }
   }
  }
  
  void act()
  {
  }
}
class Money extends Item
{
  Money(int posx, int posy, int w)
  {
    super(posx, posy, "coin.png");
    worth = w;
    radius = 10;
  }
  
  void act()
  {
    this.removeSelf();
    player.addMoney(worth);
    println("+"+worth);
  }
}


void keyPressed() {
  if(key == ' ')
    player.shoot();
    
   if(key=='p')
   psychedelicMode = !psychedelicMode;
}

abstract class Gun
{
  Gun(
}
