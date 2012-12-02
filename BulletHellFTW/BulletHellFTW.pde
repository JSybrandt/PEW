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



 ArrayList<PImage> loadedPics = new ArrayList<PImage>();
  
  
   void loadImages()
  {
    loadedPics.add(loadImage("bullet.png"));//#0
    loadedPics.add(loadImage("playerbullet.png"));//#1
    loadedPics.add(loadImage("coin.png"));//#2
    loadedPics.add(loadImage("RocketE.png"));//#3
    loadedPics.add(loadImage("Drone.png"));//#4
    loadedPics.add(loadImage("Cruiser.png"));//#5
    loadedPics.add(loadImage("Turret.png"));//#6
    loadedPics.add(loadImage("spaceship.png"));//#7
    loadedPics.add(loadImage("PowerUp.png"));//#8
    loadedPics.add(loadImage("HerpADerp.png"));//#9
  }


void setup() {
  
  loadImages();
  size(displayWidth, displayHeight);
  imageMode(CENTER);
  smooth();
  noStroke();
  fill(255);
  rectMode(CENTER);     //This sets all rectangles to draw from the center point
  player = new PlayerShip( displayWidth/2, (4*displayHeight)/5);

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
  /*
  if (tick ==100)
  {
    ArrayList<Turret> guns = new ArrayList<Turret>();
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    enemyShips.add(new Cruiser(guns));
  }*/
  
  if(tick % 500 == 0)
  {
    spawning = true;//!spawning;
    spawnNum = gen.nextInt(5);
  }
  spawning = true;

  if (spawning)
    spawner.spawn(spawnNum);
  tick++;
  if (tick == 100000)
    tick = 0;
    
    
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


