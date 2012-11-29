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
  size(480, 800);
  imageMode(CENTER);
  smooth();
  noStroke();
  fill(255);
  rectMode(CENTER);     //This sets all rectangles to draw from the center point
  player = new PlayerShip("spaceship.png", 200, 200);

frameRate(60);

  f =  createFont("Impact", 24, true);
  textFont(f, 24);
  fill(255);
}


int tick = 1, spawnNum;
Spawner spawner = new Spawner();
boolean spawning = false;
void draw() {

  if (!psychedelicMode)
    background(#000000);


  if (mousePressed)
  {
    player.move();
    if (tick%3==0)
      player.shoot();
  }
  player.display();


  for (int j = 0; j< enemyShips.size();j++)
  {
    enemyShip s = (enemyShip) enemyShips.get(j);
    s.act();
  }


  for (int j = 0; j< enemyBullets.size();j++)
  {
    Projectile p = (Projectile) enemyBullets.get(j);
    p.move();
  }


  for (int j = 0; j< playerBullets.size();j++)
  {
    Projectile p = (Projectile) playerBullets.get(j);
    p.move();
  }
  for (int j = 0; j< items.size();j++)
  {
    Item p = (Item) items.get(j);
    p.move();
  }


  collisionDetection();

  text("Score: " + player.getScore(), 10, 20);
  text("Bullet Count: " + (enemyBullets.size() + playerBullets.size()), 10, 50);
  text("Ship Count: " + enemyShips.size(), 10, 75);
  if (tick ==100)
  {
    ArrayList<Turret> guns = new ArrayList<Turret>();
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    enemyShips.add(new Cruiser(guns));
    spawning = !spawning;
    spawnNum = gen.nextInt(5);
    
  }

 // if (spawning)
 //   spawner.spawn(4);
  tick++;
  if (tick == 100000)
    tick = 0;
}

public class Spawner
{
  boolean flip = false;
  int xLoc = 0, yLoc=0;
  void spawn(int l)//l for level , t for ticks
  {

    if (l==0)
      if (tick %50 ==0)
      {

        if (flip)
          enemyShips.add(new Drone(120, 0, 3, "Drone.png", gen.nextInt(50)+50, 5, 2));
        else
          enemyShips.add(new Drone(360, 0, 3, "Drone.png", gen.nextInt(50)+50, 5, 1));
        flip = !flip;
      }

    if (l==1)
      if (tick %25 ==0)
      {

        if (flip)
          enemyShips.add(new Drone(120, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 2));
        else
          enemyShips.add(new Drone(360, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 1));
        flip = !flip;
      }
    if (l==2)
      if (tick %25 ==0)
      {
          enemyShips.add(new Drone(120, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 8));
          enemyShips.add(new Drone(360, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 7));
      }
    if (l==3)
      if (tick %20 ==0)
      {
          xLoc += 30;
          enemyShips.add(new Drone(xLoc, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 0));
          if (xLoc > 480)
          xLoc =0;
      }
     if(l==4)
     if(tick%40==0)
     {
       yLoc=gen.nextInt(200)+50;
       enemyShips.add(new HelixShip(0,yLoc));
     }
  }
}


void collisionDetection()
{

  for (int i = 0 ; i< playerBullets.size();i++)
  {
    Projectile p = (Projectile) playerBullets.get(i);
    for (int j = 0; j< enemyShips.size();j++)
    {
      Ship s = (Ship) enemyShips.get(j);
      if (p.isTouching(s))
      {
        s.hit();
        p.removeSelf();
      }
      if(s instanceof Cruiser )
      {
        Cruiser t = (Cruiser) s;
        ArrayList<Turret> guns= t.getTurretList();
        for(int k = 0; k < guns.size(); k++ )
        {
           Turret g =  guns.get(k);
            if (p.isTouching(g))
              {
                g.hit();
                p.removeSelf();
              }
        }
      }
    }
  }


  for (int i = 0; i < enemyBullets.size(); i++)
  {
    Projectile p = (Projectile) enemyBullets.get(i);
    p.move();
    if (p.isTouching(player))
    {
      player.hit();
      p.removeSelf();
    }
  }


  for (int i = 0; i < items.size(); i++)
  {
    Item p = (Item) items.get(i);
    p.move();
    if (p.isTouching(player))
    {
      p.act();
    }
  }
  for (int i = 0; i < enemyShips.size(); i++)
  {
    Ship p = (Ship) enemyShips.get(i);
    if (p.isTouching(player))
    {
      player.blowUp();
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
    if (sqrt(pow(locX - b.locX, 2) + pow(locY - b.locY, 2))<(radius+b.radius))
      return true;
    else
      return false;
  }
  void display()
  {
    image(img, locX, locY);
  }
  int getLocX()
  {
    return locX;
  }
    int getLocY()
  {
    return locY;
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
    if (dir)
      locY -=speed;
    else
      locY += speed;

    locX+= horDisp;

    if (locY < -10 || locY > 810 || locX < -10 || locX > 490)
      removeSelf();
    image(img, locX, locY);
  }


  void removeSelf()
  {
    boolean flag = false;
    for (int i = enemyBullets.size()-1 ; i  >= 0;i--)
    {
      Projectile p = (Projectile) enemyBullets.get(i);
      if (p == this)
      {
        enemyBullets.remove(i);
        flag = true;
        break;
      }
    }
    if (!flag)
      for (int i = playerBullets.size()-1 ; i  >= 0;i--)
      {
        Projectile p = (Projectile) playerBullets.get(i);
        if (p == this)
        {
          playerBullets.remove(i);
          break;
        }
      }
  }
}

class Bullet extends Projectile
{
  Bullet(int xpos, int ypos, boolean d, String img, int h, int s)
  {
    super(xpos, ypos, d, img, h, s);
    radius = 7;
  }
  
}
class SinShot extends Projectile
{
  int xinit, yinit;
  boolean flip = false;
  SinShot(int xpos, int ypos)
  {
    super(xpos,ypos,true,"playerbullet.png",0,7);
    xinit = xpos;
    yinit = ypos;
  }
  void move()
  {
    locY-=speed;
    if(flip)
    locX+=speed;
    else locX-=speed;
    if(locX>xinit+50||locX<xinit-50)
     flip= !flip; 
   if (locY < -10 || locY > 810 || locX < -10 || locX > 490)
       removeSelf();
   image(img, locX, locY);
  }
  
  
}
class ArcSinShot extends Projectile
{
  int xinit, yinit;
  boolean flip = true;
  ArcSinShot(int xpos, int ypos)
  {
    super(xpos,ypos,true,"bullet.png",0,7);
    xinit = xpos;
    yinit = ypos;
  }
  void move()
  {
    locY-=speed;
    if(flip)
    locX+=speed;
    else locX-=speed;
    if(locX>xinit+50||locX<xinit-50)
     flip= !flip; 
   if (locY < -10 || locY > 810 || locX < -10 || locX > 490)
       removeSelf();
   image(img, locX, locY);
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
    if (health == 0)
      blowUp();
  }
  void shoot()
  {
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 0, 5) );
  }
  void blowUp()
  {
    println("BOOM");//we can add in animation here
    removeSelf();
  }
  void removeSelf()
  {
    for (int i = enemyShips.size()-1 ; i  >= 0;i--)
    {
      Ship p = (Ship) enemyShips.get(i);
      if (p == this)
      {
        enemyShips.remove(i);
        break;
      }
    }
  }
}
public class Turret extends Actor
{
  int health;
  Gun weapon;
  Turret (Gun g, int h)
  {
    health = h;
    radius = 15;
    weapon = g;
    img = loadImage("Turret.png");
  }
  void increment(int delX, int delY)
  {
    locX += delX;
    locY += delY;
  }
  void moveTo(int newx, int newy)
  {
    locX=newx;
    locY=newy;
  }
  void shoot()
  {
   weapon.shoot();

  }
  int getHealth()
  {
    return health;
  }
  void hit()
  {
    health--;
  }
}

public class Cruiser extends enemyShip
{
  ArrayList<Turret> guns;
  int count;
  boolean moving;
  int activeGun;
  int destinationX, destinationY;
  Cruiser(ArrayList<Turret> g)
  {
    super(240, -100, 1, "BossBody.png", 1000, 1000, 1000);
    guns = g;
    prepairTurrets();
    count = 0;
    destinationX = locX;
    destinationY = 30;
    moving = true;

  }
  void prepairTurrets()
  {
    double gunRange = 0;
    if(guns.size()>0)
     gunRange = 800/guns.size();
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).moveTo((int)(locX-400+i*gunRange),locY+150);
    }
  }
  void act()
  {
    count++;
    if (count ==1000)
     {
      int selection = gen.nextInt(guns.size());
      destinationX = guns.get(selection).getLocX();
      activeGun = selection;
      print(selection);
       moving = true;
       count = 0;
     }
     if(moving)
     move();
     else
     shoot();
     display();
     displayTurrets();
     checkTurrentHealths();
  }
  void move()
  {
    int delX = 0, delY = 0;
    if(destinationY-locY > 5)
      {
        if(destinationY > locY)
        {
          locY+=speed;
          delY = speed;
        }
         else
         {
            locY-=speed;
          delY = -speed;
         }
      }
      else
      {
        if(destinationX - locX > 5)
        {
         if(destinationX > locX)
        {
          locX+=speed;
          delX = speed;
        }
         else
         {
            locX-=speed;
          delX = -speed;
         }
        }
      }
      moveTurrets(delX,delY);
      if(destinationY-locY > 5 && destinationX-locX > 5)
      moving = false;
  }
  void shoot()
  {
    guns.get(activeGun).shoot();
  }
  void moveTurrets(int delX, int delY)
  {
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).increment(delX,delY);
    }
  }
  void displayTurrets()
  {
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).display();
    }
  }
  void checkTurrentHealths()
  {
    for(int i = guns.size()-1; i >= 0; i--)
    {
      if (guns.get(i).getHealth()<1)
        guns.remove(i);
    }
    if(guns.size()<1)
    {
      super.blowUp();
    }
  }
  ArrayList<Turret> getTurretList()
  {
    return guns;
  }
}
abstract class enemyShip extends Ship
{
  int path, count = 0, lifeTime = 250, freq, speed, xinit, yinit;
  boolean flip = false;
  enemyShip(int startx, int starty, int s, String imgName, int f, int h, int p)
  {
    super(imgName);
    locX = startx;
    locY = starty;
    xinit = startx;
    yinit = starty;
    speed = s;
    freq = f;
    path = p;
    health = h;
  }

  void act()
  {
    count++;

    if (count > lifeTime)
      flyAway();
    else
    {
      move();
      if (count % freq == 0)
        shoot();
    }   
    if (locY > 850 || locX < -50 || locX > 550)
      removeSelf();
  } 

  void move()
  {
    if (path == 0)
    {
      locY+= speed;
    }
    if (path == 1)
    {
      if (locY < 300)
      {
        locY+=speed;
      }
      else
      {
        locY += speed/sqrt(2);
        locX -= speed/sqrt(2);
      }
    }
    if (path == 2)
    {
      if (locY < 300)
      {
        locY+=speed;
      }
      else
      {
        locY += speed/sqrt(2);
        locX += speed/sqrt(2);
      }
    }
    if (path == 3)
    {
      if (count %3 == 0)
        locY+=1;
      if (flip)
        locX += speed;
      else
        locX -= speed;
      if (locX > 430 || locX < 50)
      {
        locY += speed*3;
        flip = !flip;
      }
    }
    if (path == 4)
    {
      if (count < 100)
      {
        locX+=speed/2;
        locY+=speed;
      }
      else 
      {
        locX-=speed/2;
        locY+=speed;
      }
    }
    if (path == 5)
    {
      if (count < 50)
      {
        locY+=speed;
        locX-= speed/2;
      }
      else if (count < 125)
      {
        locY+=speed;
        locX+= speed/2;
      }
      else
      {
        locY+=speed/2;
      }
    }
    if (path == 6)
    {
      locY+=speed;
      locX+=sin(count* 3.14/6)*5;
    }
    if (path == 7)
    {
      locY+=speed;
      if (flip)
        locX+=speed;
      else
        locX-=speed;
      if (locX<xinit-200 || locX>xinit+200)
        flip = !flip;
    }
    if (path == 8)
    {
      locY+=speed;
      if (flip)
        locX-=speed;
      else
        locX+=speed;
      if (locX<xinit-200 || locX>xinit+200)
        flip = !flip;
    }
    if(path==9)
    {
      locX+=speed;
    }

    image(img, locX, locY);
  }
  void flyAway()
  {
    locY += speed*2;
    this.display();
  }
  void blowUp()
  {
    int w = gen.nextInt(20)+1;
    new Money( locX, locY, w);
    int randomInt = gen.nextInt(10);
    if(randomInt == 1)
    {
    new PowerUp(locX + 20, locY - 20);
    }
    removeSelf();
  }
}
class Drone extends enemyShip
{
  boolean flip = true;
  Drone(int startx, int starty, int speed, String imgName, int f, int h, int p)
  {
    super( startx, starty, speed, imgName, f, h, p);
  }
  void shoot()
  {
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 0, 5) );
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 2, 4));
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", -2, 4) );
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 4, 3 ));
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", -4, 3 ));
  }
}
class HelixShip extends enemyShip
{
  boolean flip, shooting;
  HelixShip(int startx, int starty)
  {
    super(startx, starty, 3, "HerpADerp.png", 10, 40, 9);
    flip = false;
    shooting = false;
  }
 void act()
  {
    count++;

    if (count > lifeTime)
      flyAway();
    else
    {
      if (count % freq == 0)
         shooting = !shooting;
         
      if(shooting)
      shoot();
      else
      move();
      
      display();
    }   
    if (locY > 850 || locX < -50 || locX > 550)
      removeSelf();
  } 
  void shoot()
  {
    if(flip)
    new SinShot(locX,locY);
    else
    new ArcSinShot(locX,locY);
    flip = !flip;  
  }
}


class PlayerShip extends Ship {
  int points;
  PlayerShip(String imageName, int xpos, int ypos)
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
    int dX, dY;
    float magnitude;
    dX = mouseX - locX;
    dY = mouseY-80 - locY;
    if (abs(dX) > 5 || abs(dY) > 5)
    {
      magnitude = sqrt(dX*dX+dY*dY);
      locX += int(speed*dX/( magnitude));
      locY += int(speed*dY/( magnitude));
    }
    if(locX < 0)
      locX = 0;
    if(locX > 480)
      locX = 480;
    if(locY < 0)
      locY = 0;
    if(locY > 800)
      locY = 800;

    image(img, locX, locY);
  }
  boolean left = false;
  void shoot()
  {
   /* if (left)
      playerBullets.add( new Bullet(locX + 10, locY-10, dir, "playerbullet.png", 0, 15) );
    else
      playerBullets.add( new Bullet(locX - 10, locY-10, dir, "playerbullet.png", 0, 15) );
  */
    left = !left;
    if(left)
    playerBullets.add( new SinShot(locX, locY-10));
    else
    playerBullets.add( new ArcSinShot(locX, locY-10));
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
    if (locY > 800)
      removeSelf();
    image(img, locX, locY);
  }

  void removeSelf()
  {
    for (int i = items.size()-1 ; i  >= 0;i--)
    {
      Item p = (Item) items.get(i);
      if (p == this)
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
public class PowerUp extends Item
{
  PowerUp(int posx, int posy)
  {
    super(posx, posy, "PowerUp.png");
    radius = 10;
  }

  void act()
  {
    this.removeSelf();
  }
}

void keyPressed() {
  if (key == ' ')
    player.shoot();

  if (key=='p')
    psychedelicMode = !psychedelicMode;
}


abstract class Gun
{
  void shoot()
  {
  }
}

class TestGun extends Gun
{
  void shoot(int xpos,int ypos)
  {
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", 0, 5) );
  }
}
