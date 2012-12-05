import apwidget.*;
import java.util.Random;



PlayerShip player;
Ship enemy;

PFont f;

ArrayList enemyShips = new ArrayList<Ship>();//the player is not included
ArrayList enemyBullets = new ArrayList<Projectile>();
ArrayList playerBullets = new ArrayList<Projectile>();
ArrayList items = new ArrayList<Item>();//misc stuff and items
ArrayList<PowerUp> activePowerUps = new ArrayList<PowerUp>();

Random gen = new Random();

boolean psychedelicMode = false;
boolean playGame,showMenu,showCredits,showHighScore,showInstructions,showOptions;
public  Menu menu;


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
    loadedPics.add(loadImage("bomb.png"));//#10
    loadedPics.add(loadImage("Drone-hit.png"));//*11
    loadedPics.add( loadImage("MainMenu.png"));//#12
   
  }


BackgroundHandler bghandel = new BackgroundHandler();






void setup() {

  Sounds.setUp();
  
  loadImages();
 menu = new Menu();
 showMenu = true;
 playGame = false;
 bghandel.setBG("spaceBackground.png");
  size(displayWidth, displayHeight);
  imageMode(CENTER);
  smooth();
  noStroke();
  fill(255);
  rectMode(CENTER);     //This sets all rectangles to draw from the center point
  player = new PlayerShip( displayWidth/2, (4*displayHeight)/5);
orientation(PORTRAIT); 
frameRate(30);

  f =  createFont("Impact", 24, true);
  textFont(f, 24);
  fill(255);
}


int tick = 1, spawnNum;
Spawner spawner = new Spawner();
boolean spawning = false;
void draw() 
{

  if (!psychedelicMode)
  {
    background(#000000);
    bghandel.scroll();
  }
  
  if (playGame == false)
  {
    if(showCredits)
      printCredits();
    if(showMenu)
      menu.showMenu();
    if(showInstructions)
      printInstructions();
    if(showHighScore)
      printHighScores(); 
    if(showOptions)
      printOptions();
  } 
  else
     {
     spawning = true;

 

    for (int j = 0; j< playerBullets.size();j++)
    {
      Projectile p = (Projectile) playerBullets.get(j);
      p.move();
    }
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


 
    for (int j = 0; j< items.size();j++)
    {
      Item p = (Item) items.get(j);
      p.move();
    }
    for (int i = activePowerUps.size()-1 ; i  >= 0;i--)
    {
       PowerUp p =  activePowerUps.get(i);
       p.increment();
    }
      
    text("Score: " + player.getScore(), displayWidth/20,displayHeight/20);
 // text("Bullet Count: " + (enemyBullets.size() + playerBullets.size()), 10, 50);
 // text("Ship Count: " + enemyShips.size(), 10, 75);
  

    collisionDetection();

 
  
  if (tick ==100)
  {
    ArrayList<Turret> guns = new ArrayList<Turret>();
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
     guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
     guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
     guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));
    guns.add(new Turret(new TestGun(),50));

   
    enemyShips.add(new Cruiser(guns));
  }
  
     if(tick % 500 == 0)
    {
          //!spawning;
      spawnNum = gen.nextInt(5);
    }

     if (spawning)
      spawner.spawn(spawnNum);
      
     tick++;
     if (tick == 100000)
       tick = 0;
       
       
       if (mousePressed)
    {
      player.move();
      if (tick%3==0)
        player.shoot();
    }
    player.display();
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


void printCredits()
{
  textAlign(CENTER);
   image(loadImage("Back.png"),displayWidth/2,displayHeight/12,displayWidth, displayHeight/6);
  text("Lead Designer: Justin \"Nalta\" Sybrandt", displayWidth/2,displayHeight/5);
  text("Code Monkey: Caelan \"DarkFire16\" Mayberry", displayWidth/2,displayHeight*(2/5.0));
  text("Chill Meister: Mike \"Reason\" Boom", displayWidth/2,displayHeight*(3/5.0));
  text("Art Master: Josh \"Fa1seEcho\" Walton", displayWidth/2,displayHeight*(4/5.0));
  
  //BULD A BACK BUTTON AT TOP OF SCREEN
 if(mousePressed && mouseY<displayHeight/6)
  {
    showCredits= false;
    showMenu = true;
    playGame = false;
  }
}

void printInstructions()
{
  textAlign(CENTER);
   image(loadImage("Back.png"),displayWidth/2,displayHeight/12,displayWidth, displayHeight/6);
  text("SHOOT STUFF", displayWidth/2,displayHeight/3);
   
   
   if(mousePressed && mouseY<displayHeight/6.0)
  { 
    showCredits= false;
    showMenu = true;
    playGame = false;
    showInstructions = false;
  }
}




void printHighScores()
{
  textAlign(CENTER);
   image(loadImage("Back.png"),displayWidth/2,displayHeight/12,displayWidth, displayHeight/6);
  text("YOUR SCORES ARE BAD", displayWidth/2,displayHeight/4);

text("AND YOU SHOULD FEEL BAD", displayWidth/2,displayHeight/3); 
   
   
   if(mousePressed && mouseY<displayHeight/6.0)
  { 
    
    showMenu = true;
    showHighScore = false;
  }
}

void printOptions()
{
  textAlign(CENTER);
  image(loadImage("Back.png"),displayWidth/2,displayHeight/12,displayWidth, displayHeight/6);
  text("YOU AINT SEEN NOTHING YET!", displayWidth/2,displayHeight/4);

text("...seriously, we have yet to code this...", displayWidth/2,displayHeight/3); 
   
   
   if(mousePressed && mouseY<displayHeight/6.0)
  { 
    
    showMenu = true;
    showOptions = false;
  }
}







