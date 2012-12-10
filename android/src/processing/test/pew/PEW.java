package processing.test.pew;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;

import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PImage;
import android.content.res.AssetManager;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.SoundPool;
import android.content.res.AssetFileDescriptor;
import android.os.Vibrator;
import android.content.Context;

import android.content.Intent;
import android.net.Uri;

public class PEW extends PApplet{

	
	
	boolean canVibrate = false;
	
	
	AssetManager assetManager=null;// needed for sounds, has to be up in rank
	SoundPool soundPool=null;

	PlayerShip player;
	Ship enemy;

	PFont f;

	ArrayList<Ship> enemyShips = new ArrayList<Ship>();// the player is not included
	ArrayList<Projectile> enemyBullets = new ArrayList<Projectile>();
	ArrayList<Projectile> playerBullets = new ArrayList<Projectile>();
	ArrayList<Item> items = new ArrayList<Item>();// misc stuff and items
	ArrayList<PowerUp> activePowerUps = new ArrayList<PowerUp>();
	ArrayList<Animation> animations = new ArrayList<Animation>();

	PFont fontG;
	String highscoreFile = "highscore.txt";
	final String GO = "Game Over";
	PrintWriter output;
	BufferedReader reader;
	int highscoretop, highscoremid, highscorebottom, points;
	Vibrator v;
	Random gen = new Random();

	boolean psychedelicMode = false;
	boolean playGame, showMenu, showCredits, showHighScore, showDeath,
			showInstructions, showOptions;
	boolean musicReady = false, startUp = true;
	boolean alreadyStartedMusic = false;
	boolean playerWantsbgSound = true;
	public Menu menu;

	ArrayList<PImage> loadedPics = new ArrayList<PImage>();
	ArrayList<PImage> loadedShipPics = new ArrayList<PImage>();
	ArrayList<PImage> loadedShipFlashPics = new ArrayList<PImage>();
	ArrayList<PImage> loadedEnemyShipExpPics = new ArrayList<PImage>();
	ArrayList<PImage> loadedPlayerShipExpPics = new ArrayList<PImage>();
	
	public void loadImages() {
		 v = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
		PImage img;
		
		img = loadImage("bullet.png");//#0
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("playerbullet.png");// #1
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("coin.png");// #2
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("RocketE.png");// #3
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("Turret.png");// #4
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("GunUpgrade.png");// #5
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("RocketE.png"); // #6
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("MainMenu.png");// #7
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("PsychedelicPowerUp1.png");// #8
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		
		//change for score multiplyers
		img = loadImage("scorex1.png"); //9
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		img = loadImage("scorex2.png"); //10
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		img = loadImage("scorex3.png"); //11
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		//going to be shield up
		img = loadImage("ShieldUp.png"); //12
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
		
		img = loadImage("Shield.png"); //13
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPics.add(img);
			
		
		
		img = loadImage("spaceship.png");// #0
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipPics.add(img);
		
		img = loadImage("Cruiser.png");// #1
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipPics.add(img);
		
		img = loadImage("Drone1.png");// #2
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipPics.add(img);
		
		img = loadImage("Drone2.png");// #3
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipPics.add(img);
		
		img = loadImage("Drone3.png");// #4
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipPics.add(img);
		
		
		
		img = loadImage("playerFlash.png"); // #0
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipFlashPics.add(img);
		
		img = loadImage("BossBody.png"); // #1
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipFlashPics.add(img);
		
		img = loadImage("Drone1-hit.png"); // #2
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipFlashPics.add(img);
		
		img = loadImage("Drone2-hit.png"); // #3
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipFlashPics.add(img);
		
		img = loadImage("Drone3-hit.png"); // #4
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedShipFlashPics.add(img);
		
		
		
		
	
		
		
		
		img = loadImage("EnemyExplosion1.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion2.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion3.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion4.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion5.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion6.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion7.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedEnemyShipExpPics.add(img);
		
		
		
		img = loadImage("EnemyExplosion1.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
		;
		img = loadImage("EnemyExplosion2.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
		

		
		

		img = loadImage("EnemyExplosion3.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion4.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion5.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion6.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
		
		img = loadImage("EnemyExplosion7.png");
		img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
		loadedPlayerShipExpPics.add(img);
	}

	BackgroundHandler bghandle = new BackgroundHandler();

	Sounds sound = new Sounds();
	MediaPlayer mediaPlayer = null;

	public void onStart()
	{
		//image(loadImage("loadingScreen.png"),displayWidth/2,displayHeight/2,displayWidth,displayHeight);
		super.onStart();
	}
	public void setup() {
	//	Vibrator.hasVibrator();
		if(true)
			canVibrate = true;
		startUp = false;


		sound.setUp();

		fontG = createFont("Constantia", ((int)((displayWidth/480.0)*48)));

		importHighscore();

		loadImages();
		menu = new Menu();
		showMenu = true;
		playGame = false;
		bghandle.setBG("spaceBackground.png");

		imageMode(CENTER);
		smooth();
		noStroke();
		fill(255);
		rectMode(CENTER); // This sets all rectangles to draw from the center
							// point
		player = new PlayerShip(displayWidth / 2, (4 * displayHeight) / 5);
		orientation(PORTRAIT);
		frameRate(30);
		f = createFont("Impact", ((int)((displayWidth/480.0)*24)), true);
		textFont(f, 24);
		fill(255);
	}

	int tick = 1, spawnNum;
	boolean spawning = false;
	Level level = new Level();

	public void draw() {

		if (!psychedelicMode) {
			background(0xff000000);
			bghandle.scroll();
		}
		if (playGame == false) {
			if (showCredits)
				printCredits();
			if (showMenu)
				menu.showMenu();
			if (showInstructions)
				printInstructions();
			if (showHighScore)
				printHighScores();
			if (showOptions)
				printOptions();
			if (showDeath)
				printDeath();
		} else {
			spawning = true;

			
			for (int j = 0; j < enemyShips.size(); j++) {
				enemyShip s = (enemyShip) enemyShips.get(j);
				s.act();
			}
			
			for (int j = 0; j < items.size(); j++) {
				Item p = (Item) items.get(j);
				p.move();
			}
			
			for (int i = 0; i < animations.size(); i++) {
				Animation a = animations.get(i);
				a.animate();
			}

			for (int j = 0; j < enemyBullets.size(); j++) {
				Projectile p = (Projectile) enemyBullets.get(j);
				p.move();
			}
			for (int j = 0; j < playerBullets.size(); j++) {
				Projectile p = (Projectile) playerBullets.get(j);
				p.move();
			}
			
			textAlign(LEFT);
			text("Score: " + player.getScore() +"   X"+player.scoreMultiplyer, displayWidth / 20, displayHeight / 20);

			// text("Bullet Count: " + (enemyBullets.size() +
			// playerBullets.size()), 10, 50);
			// text("Ship Count: " + enemyShips.size(), 10, 75);

			collisionDetection();



			if (spawning)
				level.spawn();

			tick++;
			if (tick == 100000)
				tick = 0;

			if (mousePressed) {
				player.move();
				if (tick % 3 == 0)
					player.shoot();
			}
			player.display();
			
			for (int i = activePowerUps.size()-1; i>=0; i--) {
				PowerUp p = activePowerUps.get(i);
				p.increment();
			}
		}
	}

	public void collisionDetection() {

		for (int i = 0; i < playerBullets.size(); i++) {
			Projectile p = (Projectile) playerBullets.get(i);
			for (int j = 0; j < enemyShips.size(); j++) {
				Ship s = (Ship) enemyShips.get(j);
				if (p.isTouching(s)) {
					s.hit();
					p.removeSelf();
				}
				if (s instanceof Cruiser) {
					Cruiser t = (Cruiser) s;
					ArrayList<Turret> guns = t.getTurretList();
					for (int k = 0; k < guns.size(); k++) {
						Turret g = guns.get(k);
						if (p.isTouching(g)) {
							g.hit();
							p.removeSelf();
						}
					}
				}
			}
		}
		
	
				

		for (int i = 0; i < enemyBullets.size(); i++) {
			Projectile p = (Projectile) enemyBullets.get(i);
			p.move();
			if (p.isTouching(player)) {
				player.hit();
				p.removeSelf();
			}
		}

		for (int i = 0; i < items.size(); i++) {
			Item p = (Item) items.get(i);
			p.move();
			if (p.isTouching(player)) {
				p.act();
			}
		}
		for (int i = 0; i < enemyShips.size(); i++) {
			Ship p = (Ship) enemyShips.get(i);
			if (p.isTouching(player)) {
				p.blowUp();
				player.hit();
			}
		}
	}

	public void printCredits() {
		textAlign(CENTER);
		text("Lead Designer -- \nJustin \"Nalta\" Sybrandt\n\n" +
				"Code Monkey -- \nCaelan \"Darkfire16\" Mayberry\n\n" +
				"Code Alpaca -- \nMike \"reason\" Boom\n\n"+
				"Art Master -- \nJosh \"Fa1seEcho\" Walton\n\n" +
				"Test Phone -- \nGeorge's LG      ",
				displayWidth / 2, displayHeight / 4);
		text("AND SPECIAL THANKS TO\n" +
				"8 BIT WEAPON\n" +
				"(Click album for link)",
				(int)(displayWidth *(2/3.0)),(int)(displayHeight * (5/6.0)));
		PImage art = loadImage("bandart.png");
		art.resize((int)(displayWidth *(1/3.0)),(int)(displayHeight*(1/ 6.0)));
		image(art,(int)(displayWidth *(1/6.0)),(int)(displayHeight*(11/ 12.0)));
		// BULD A BACK BUTTON AT TOP OF SCREEN
		
		image(loadImage("Back.png"), displayWidth / 2, displayHeight / 12,
				displayWidth, displayHeight / 6);
		if (mousePressed && mouseY < displayHeight / 6) {
			showCredits = false;
			showMenu = true;
			playGame = false;
		}
		//go to band link
		if(mousePressed && mouseY > displayHeight *(5/6.0)&& mouseX < displayWidth *(1/3.0))
		{
			makeWebPage();
		}
	}

	public void printInstructions() {
		textAlign(CENTER);
		textSize((int)((displayWidth/480.0)*25));
		text("Instructions\n\nFirst: do not DIE QUICKLY\nPretty self explantory\n\nSecond: Moving\nTouch to move\n\nThird: Shooting\nTouch to shoot\n(did not see that one coming)\n\nFourth: SURVIVE\nFight to the last!\n(When you lose all upgrades)\n\nSo, lets review\nMove\nShoot\nSURVIVE",
				displayWidth / 2, displayHeight / 5);
		
		image(loadImage("Back.png"), displayWidth / 2, displayHeight / 12,
				displayWidth, displayHeight / 6);

		if (mousePressed && mouseY < displayHeight / 6.0f) {
			textSize((int)(displayWidth/480.0)*24);
			showCredits = false;
			showMenu = true;
			playGame = false;
			showInstructions = false;
		}
	}

	public void printHighScores() {
		textAlign(CENTER);
		textSize((int)((displayWidth/480.0)*25));
		image(loadImage("Back.png"), displayWidth / 2, displayHeight / 12,
				displayWidth, displayHeight / 6);
		text("Your Highscore is:\n" + highscoretop, displayWidth / 2, displayHeight / 4);

		text("\nAND YOU SHOULD FEEL BAD\nREALLY BAD\nGET OUT\n(0.0)",
				displayWidth / 2, displayHeight / 3);

		if (mousePressed && mouseY < displayHeight / 6.0f) {
			textSize((int)(displayWidth/480.0)*24);
			showMenu = true;
			showHighScore = false;
		}
	}

	public class ToggleButton
	{
		int locX, locY;
		PImage onImage, offImage;
		boolean on;
		ToggleButton(PImage img,PImage img2 , int locX,int locY)
		{
			img.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
			img2.resize((int)((displayWidth/480.0)*img.width),(int)((displayHeight/800.0)*img.height));
			onImage = img;
			offImage = img2;
			this.locX = locX;
			this.locY = locY;
		}
		public void print()
		{
			if(on)
			image(onImage, locX,locY);
			else
			image(offImage,locX,locY);
		}
		public void checkClick()
		{
			if(mouseY>locY-onImage.height/2&&mouseY<locY+onImage.height/2
					&&mouseX<locX+onImage.width/2&&mouseX>locX-onImage.width/2)
			{
				this.doSomething();
			}
		}
		public void doSomething()
		{
			on = !on;
		}
	}
	public class BackgroundSoundButton extends ToggleButton
	{
		BackgroundSoundButton()
		{
		super(loadImage("backgroundmusicon.png"),loadImage("backgroundmusicon.png") ,
				displayWidth / 2,(int)(displayHeight*(4 / 12.0)));
		}
		public void doSomething()
		{
			playerWantsbgSound = !playerWantsbgSound;
		}
	}
	
	public void printOptions() {
			image(loadImage("Back.png"), displayWidth / 2, displayHeight / 12,
						displayWidth, displayHeight / 6);
		BackgroundSoundButton bgbutton = new BackgroundSoundButton();
		bgbutton.print();
		bgbutton.checkClick();
		
		if (mousePressed && mouseY < displayHeight / 6.0f) {
			
			textSize((int)(displayWidth/480.0)*24);
			showMenu = true;
			showOptions = false;
		}
	}

	public void printDeath() {
		GameOverMessage(GO);
	}


	public void onStop() {
		if (soundPool != null) { // must be checked because or else crash when
			// return from landscape mode
			soundPool.release(); // release the player
			soundPool = null;
		}
			if(musicReady)
			{
			mediaPlayer.stop();
			mediaPlayer.release();
			mediaPlayer=null;
			musicReady=false;
			alreadyStartedMusic = false;
			}
		
		super.onStop();
	}
	
	public void onPause() {
		showMenu = false;
		if (soundPool != null) { // must be checked because or else crash when
			// return from landscape mode
			soundPool.release(); // release the player
			soundPool=null;
		}
			if(musicReady)
			{
			mediaPlayer.stop();
			mediaPlayer.release();
			musicReady=false;
			mediaPlayer=null;
			alreadyStartedMusic = false;
			}
			
			playGame = false;
		
		super.onPause();
	}

	public void onResume()
	{
		showCredits = false;
		playGame = false;
		showHighScore = false;
		showInstructions = false;
		showOptions = false;
		if(!startUp && !musicReady)
		{
		sound.setUp();
		if(mediaPlayer!=null)
		{
		mediaPlayer.start();
		print("THIS DIDNT MAKE ITSELF PROPERLY JERKWAD");
		}
		}
		showMenu = true;
		super.onResume();
	}


	abstract class Actor {
		int locX, locY, radius, speed;
		boolean dir;
		PImage img;

		public void move() {
		}

		public boolean isTouching(Actor b) {
			if (sqrt(pow(locX - b.locX, 2) + pow(locY - b.locY, 2)) < (radius + b.radius))
				return true;
			else
				return false;
		}

		public void display() {
			image(img, locX, locY);
		}

		public int getLocX() {
			return locX;
		}

		public int getLocY() {
			return locY;
		}
	}

	public class BackgroundHandler {
		PImage bgimg, upcomingImg;
		int scrolly, upcomingScrolly;
		boolean needFlip;

		BackgroundHandler() {

		}

		public void setBG(String img) {
			bgimg = loadImage(img);
			bgimg.resize((int)((displayWidth/480.0)*bgimg.width), (int)((displayHeight/800.0)*bgimg.height));

			upcomingImg = bgimg;
			scrolly = displayHeight;
			upcomingScrolly = 0;
		}

		public void scroll() {
			image(bgimg, displayWidth / 2, scrolly - bgimg.height / 2);
			scrolly += 5;
			if (scrolly - bgimg.height >= 0) {
				scrollInNew();
			}
		}

		public void scrollInNew() {
			image(upcomingImg, displayWidth / 2, upcomingScrolly
					- upcomingImg.height / 2);
			upcomingScrolly += 5;
			if (upcomingScrolly >= displayHeight)
				flip();
		}

		public void loadNewImg(String img) {
			upcomingImg = loadImage(img);
			upcomingScrolly = 0;
		}

		public void flip() {
			needFlip = false;
			bgimg = upcomingImg;
			scrolly = upcomingScrolly;
			upcomingScrolly = 0;
		}

	}

	public class Bomb extends Projectile {
		int count;
		int lifeSpan;
		int speed;

		Bomb(int locX, int locY) {
			super(locX, locY, 6, 0, 5);
			count = 0;
			lifeSpan = 75;
			speed = (int)((displayWidth/480.0)*4);
			enemyBullets.add(this);
		}

		Bomb(int locX, int locY, int dispx, int dispy) {
			super(locX, locY, 10, dispx, dispy);
			count = 0;
			lifeSpan = 25;
			speed = (int)((displayWidth/480.0)*5);
			enemyBullets.add(this);
		}

		public void move() {
			super.move();
			count++;
			if (count > lifeSpan) {
				detonate();
				removeSelf();
			}
		}

		public void detonate() {
			for (float degree = 0; degree < 2 * PI; degree += PI / 6) {
				int dispx = (int) (speed * sin(degree));
				int dispy = (int) (speed * cos(degree));
				new Bullet(locX, locY, dispx, dispy);
			}
		}
	}

	public class BombLauncher extends Gun {
		BombLauncher() {
		}

		public void shoot(int locX, int locY) {
			new Bomb(locX, locY);
		}
	}

	class Bullet extends Projectile {
		Bullet(int xpos, int ypos, int h, int s) {
			super(xpos, ypos, 0, h, s);
			enemyBullets.add(this);
			radius = (int)((displayWidth/480.0)*7);
		}

		Bullet(int xpos, int ypos) {
			super(xpos, ypos, 0, 0,6);
			enemyBullets.add(this);
			radius = (int)((displayWidth/480.0)*7);
		}

	}

	public class Cruiser extends enemyShip {
		ArrayList<Turret> guns;
		int[] turretsX = { -600, -530, -470, -420, -376, -340, -296, -150, -90,
				-30, 30, 100, 220, 300, 370, 450 };
		int[] turretsY = { 136, 136, 136, 90, 18, 90, 18, 162, 162, 162, 162,
				166, 82, 82, 82, 82 };
		int count;
		boolean moving, shooting;
		int activeGun;
		Turret activeTurret;
		int destinationX, destinationY;

		Cruiser(ArrayList<Turret> g) {
			super(1, 7, 1000, 2000, 3);
			guns = g;
			prepairTurrets();
			count = 0;
			destinationX = locX;
			destinationY = displayHeight / 4;
			moving = true;
			shooting = false;
			selectNewGun();

		}

		public void prepairTurrets() {
			double ratiox = displayWidth/480.0;
			double ratioy = displayHeight/800.0;
			for(int i = 0 ; i < 16; i++ )
				turretsX[i]=(int)(turretsX[i]*ratiox);
			for(int i = 0 ; i < 16; i++ )
				turretsY[i]=(int)(turretsY[i]*ratioy);
			double gunRange = 0;
			if (guns.size() > 0)
				gunRange = 800 / guns.size();
			for (int i = 0; i < guns.size(); i++) {
				guns.get(i).moveTo(locX + turretsX[i], locY + turretsY[i]);
			}
		}

		public void act() {
			display();
			displayTurrets();
			checkTurrentHealths();
			if (moving)
				move();
			else if (shooting)
				shoot();
			else if (guns.size() > 0)
				selectNewGun();
			else
				blowUp();

		}
		public void blowUp()
		{
			for(int i = 0; i < img.width; i+=20)
			{
				new Money(locX+img.width/2-i,locY, 50);
			}
		}
		public void selectNewGun() {
			int selection = gen.nextInt(guns.size());
			activeTurret = guns.get(selection);
			destinationX = displayWidth / 2 - activeTurret.getLocX();
			// destinationY = activeTurret.getLocY();
			activeGun = selection;
			activeTurret = guns.get(selection);
			print("" + selection + " at desintation " + destinationX + "\n");
			moving = true;
		}

		public void move() {
			int delX = 0, delY = 0;
			if (abs(destinationY - locY) > 5) {
				if (destinationY > locY) {
					locY += speed;
					delY = speed;

				} else {
					locY -= speed;
					delY = -speed;
				}
			} else {
				if (destinationX > 0) {
					locX += speed;
					delX = speed;
					destinationX -= speed;
				} else {
					locX -= speed;
					delX = -speed;
					destinationX += speed;
				}

			}

			moveTurrets(delX, delY);
			print("%%" + (destinationX - locX));

			if (abs(destinationY - locY) < 10 && abs(destinationX) < 10) {
				moving = false;
				shooting = true;
				count = 0;
				print("From Moving to Shooting.");
			}
		}

		public void shoot() {
			for (int i = 0; i < guns.size(); i++) {
				if (guns.get(i).getLocX() > 0
						&& guns.get(i).getLocX() < displayWidth)// aka on screen
				{
					guns.get(i).act();
				}
			}
			count++;
			if (count > 1000) {
				shooting = false;
			}
		}

		public void moveTurrets(int delX, int delY) {
			for (int i = 0; i < guns.size(); i++) {
				guns.get(i).increment(delX, delY);
			}
		}

		public void displayTurrets() {
			for (int i = 0; i < guns.size(); i++) {
				guns.get(i).display();
			}
		}

		public void checkTurrentHealths() {
			for (int i = guns.size() - 1; i >= 0; i--) {
				if (guns.get(i).getHealth() < 1) {
					if (guns.get(i) == activeTurret)
						shooting = false;

					guns.remove(i);

				}
			}
			if (guns.size() < 1) {
				super.blowUp();
			}
		}

		public ArrayList<Turret> getTurretList() {
			return guns;
		}

		public void hit() {
			// do nothing;
		}
	}

	public class DinkyGun extends Gun {
		public void shoot(int locX, int locY) {
			new Bullet(locX, locY);
		}
	}
	public class doubleGun extends Gun {
		public void shoot(int locX, int locY) {
			new Bullet(locX, locY,-1,4);
			new Bullet(locX, locY,1,4);
		}
	}
	public class tripleGun extends Gun {
		public void shoot(int locX, int locY) {
			new Bullet(locX, locY,-1,4);
			new Bullet(locX, locY,1,4);
			new Bullet(locX, locY,0,4);
		}
	}

	class Drone extends enemyShip {
		Gun weapon;

		boolean flip = true;

		Drone(int imageIndex, int f, int h, int p, int s) {
			super(imageIndex, f, h, p, s);
			weapon = new DinkyGun();
		}

	}

	void GameOverMessage(String msg) {
		for(int i = 0; i < activePowerUps.size(); i++)
		{
			activePowerUps.get(i).removeEffect();
		}
		bghandle.scroll();
		
		image(loadImage("Back.png"), displayWidth / 2, displayHeight / 12,
				displayWidth, displayHeight / 6);
		textFont(fontG);
		fill(110, 50, 255);
		textAlign(CENTER);
		text(msg + "\nScore: " + points + "\nHigh Score: " + highscoretop,
				displayWidth / 2, displayHeight / 2);

		if (mousePressed && mouseY < displayHeight / 6) {
			level.reset();
			enemyShips.clear();
			enemyBullets.clear();
			playerBullets.clear();
			items.clear();
			activePowerUps.clear();
			animations.clear();
			textAlign(LEFT);
			textFont(f, 24);
			fill(255);
			showDeath = false;
			showMenu = true;
			playGame = false;
			points = 0;
			tick = 0;
			psychedelicMode = false;
			player = new PlayerShip(displayWidth / 2, (4 * displayHeight) / 5);
			
		}
	}

	abstract class Gun {
		public void shoot(int xpos, int ypos) {
		}
	}

	public class Hallucinate extends PowerUp {
		Hallucinate(int locX, int locY) {
			super(locX, locY,8);

		}
		public void act()
		{
			player.incrementScoreMultiplyer(10);
			super.act();
		}

		public void doEffect() {
			psychedelicMode = true;
		}

		public void removeEffect() {
			psychedelicMode = false;
			player.incrementScoreMultiplyer(-10);
		}

	}

	public class HelixGun extends Gun {
		HelixGun() {
		}

		boolean left = false;

		public void shoot(int xpos, int ypos) {
			left = !left;
			if (left)
				new SinShot(xpos, ypos - 10, 2, 3);
			else
				new SinShot(xpos, ypos + 10, -2, 3);
		}
	}

	public void importHighscore() {
		// Open the file from the createWriter()
		reader = createReader(highscoreFile);
		if (reader == null) {
			highscoretop = 0;
			return;
		}
		String line;
		try {
			line = reader.readLine();
		} catch (IOException e) {
			e.printStackTrace();
			line = null;
		}
		if (line != null) {
			highscoretop = PApplet.parseInt(line);
			println(highscoretop);
		}
		try {
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void updateHighscore() {
		if (highscoretop < points) {
			highscoretop = points;
			// Create a new file in the sketch directory
			output = createWriter(highscoreFile);
			output.println(highscoretop);
			output.close(); // Writes the remaining data to the file & Finishes
							// the file
		}
	}

	abstract class Item extends Actor {
		int worth;
		int speed = (int)((displayWidth/480.0)*3);

		Item(int posx, int posy, int imageIndex) {
			locX = posx;
			locY = posy;
			img = loadedPics.get(imageIndex);
			items.add(this);
		}

		public void move() {
			locY += speed;
			if (locY > displayHeight + 100)
				removeSelf();
			image(img, locX, locY);
		}

		public void removeSelf() {
			for (int i = items.size() - 1; i >= 0; i--) {
				Item p = (Item) items.get(i);
				if (p == this) {
					items.remove(i);
					break;
				}
			}
		}

		public void act() {
		}
	}

	public void keyPressed() {
		if (key == ' ')
			player.shoot();

		if (key == 'c') // Clear highscore
		{
			highscoretop = 0;
			// Create a new file in the sketch directory
			output = createWriter(highscoreFile);
			output.println(highscoretop);
			output.close(); // Writes the remaining data to the file & Finishes
							// the file
		}

		// this gets switched around when porting to android
		// if(key == 'r')
		if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_MENU) {
			playGame = false;
			showMenu = true;
			showCredits = false;
		}

	}

	public class Level {
		int waveNum, count;
		boolean flip, inWave;
		int waveShipsSpawned, waveShipsEnd, waveType;
		int path;
		int spawnFreq, shipFreq, shipHP, shipSpeed, uniqueRarity, shipImage;
		int rando;
		
		Level() {
			count = 0;
			waveNum = 0;
			flip = true;
			inWave = false;
			waveShipsSpawned = 0;
			waveShipsEnd = 0;
			waveType = 0;
			path = 1;
		}
		
		void reset() {
			count = 0;
			waveNum = 0;
			flip = true;
			inWave = false;
			waveShipsSpawned = 0;
			waveShipsEnd = 0;
			waveType = 0;
			path = 1;
		}
		
		void spawn() {
			if (inWave) {
				if (waveNum%8 == 7 && enemyShips.size() == 0) {
					spawnCruiser();
				} else {
					if (count%spawnFreq == 0) {
						if (waveType == 0)
							spawnScissor();
						if (waveType == 1)
							spawnSideToSide();
						if (waveType == 2)
							spawnSidewaysRight();
						if (waveType == 3)
							spawnSidewaysLeft();
						if (waveType == 4)
							spawnWildcard();
					}
				}
				if (waveShipsSpawned >= waveShipsEnd)
					inWave = false;
			} else {
				if (enemyShips.size() == 0) {
					newWave();
				}
			}
			count++;
			if (count == 10000)
				count = 0;
		}
		
		void spawnScissor() {
			if (flip) {
				path = 1;
				flip = !flip;
			} else {
				path = 2;
				flip = !flip;
			}
			spawnShip();
		}
		
		void spawnSideToSide() {
			if (flip) {
				path = 3;
				flip = !flip;
			} else {
				path = 4;
				flip = !flip;
			}
			spawnShip();
		}
		
		void spawnSidewaysRight() {
			path = 5;
			spawnShip();
		}
		
		void spawnSidewaysLeft() {
			path = 6;
			spawnShip();
		}
		
		void spawnWildcard() {
			path = gen.nextInt(7);
			spawnShip();
		}
		
		void spawnCruiser() {
			ArrayList<Turret> guns = new ArrayList<Turret>();
			for (int i=0; i<16; i++) {
				if (gen.nextInt(100) < uniqueRarity) {
					guns.add(new Turret(getRandGun(), 3*shipHP+15));
				} else {
					guns.add(new Turret(new DinkyGun(), 2*shipHP+10));
				}
			}
			enemyShips.add(new Cruiser(guns));
		}
		
		void spawnShip() {
			if (gen.nextInt(100) < uniqueRarity) {
				rando = gen.nextInt(3)+2;
				Drone s = new Drone(rando, shipFreq, 2*shipHP, path, shipSpeed);
				s.setGun(getRandGun());
				enemyShips.add(s);
			} else {
				Drone s = new Drone(shipImage, shipFreq, shipHP, path, shipSpeed);
				enemyShips.add(s);
			}
			waveShipsSpawned++;
		}
		
		void newWave() {
			waveNum++;
			inWave = true;
			waveType = gen.nextInt(5);
			waveShipsSpawned = 0;
			waveShipsEnd = waveNum * 2 + 10;
			spawnFreq = 30 - waveNum / 2;
			shipFreq = 25 - waveNum / 3;
			shipHP = 2 + waveNum;
			shipSpeed = (int)((displayWidth/480.0)*5 + waveNum / 2);
			uniqueRarity =  5 + waveNum;
			shipImage = gen.nextInt(3)+2;
		}
	}

	public class Menu {

		PImage MenuImage;// = loadImage("MainMenu.png");;
		float PlayX, PlayY, playSizeY, playSizeX; // Position of square button
		float creditsX, creditsY, creditsSizeX, creditsSizeY;
		float scoreX, scoreY, scoreSizeX, scoreSizeY;
		float tutX, tutY, tutSizeX, tutSizeY;
		float opX, opY, opSizeX, opSizeY;
		

		Menu() {
			playGame = false;
			MenuImage = loadedPics.get(7);

			PlayX = displayWidth / 13.2f;
			PlayY = (displayHeight / 1.865f);
			playSizeY = displayHeight / 7.8f;// Diameter of
			playSizeX = displayWidth / 1.201f;

			scoreX = displayWidth * (1 / 2.0f);
			scoreY = displayHeight * (5 / 7.4f);
			scoreSizeX = displayWidth / 2.402f;
			scoreSizeY = displayHeight / 7.8f;

			creditsX = displayWidth * (1 / 2.0f);
			creditsY = displayHeight * (6 / 7.4f);
			creditsSizeX = displayWidth / 2.402f;
			creditsSizeY = displayHeight / 7.8f;

			tutX = displayWidth * (0.07f);
			tutY = displayHeight * (5 / 7.4f);
			tutSizeX = displayWidth / 2.402f;
			tutSizeY = displayHeight / 7.8f;

			opX = displayWidth * (0.07f);
			opY = displayHeight * (6 / 7.4f);
			opSizeX = displayWidth / 2.402f;
			opSizeY = displayHeight / 7.8f;

		}

		public void showMenu() {
			if(musicReady && !alreadyStartedMusic)
			{
			mediaPlayer.start();
			alreadyStartedMusic = true;
			}
			else
				sound.buildPlayer();

			spawning = false;
			playGame = false;

			image(MenuImage, displayWidth / 2, displayHeight / 2, displayWidth,
					displayHeight);

			if (overBox(PlayX, PlayY, playSizeX, playSizeY)) {
				if (mousePressed == true) {

					showMenu = false;
					playGame = true;
					
				}
			}
			if (overBox(creditsX, creditsY, creditsSizeX, creditsSizeY)) {
				if (mousePressed == true) {
					showCredits = true;
					showMenu = false;

				}
			}
			if (overBox(tutX, tutY, tutSizeX, tutSizeY)) {
				if (mousePressed == true) {
					showInstructions = true;
					showMenu = false;
				}
			}
			if (overBox(opX, opY, opSizeX, opSizeY)) {
				if (mousePressed == true) {
					showOptions = true;
					showMenu = false;
				}
			}
			if (overBox(scoreX, scoreY, scoreSizeX, scoreSizeY)) {
				if (mousePressed == true) {
					showHighScore = true;
					showMenu = false;
				}
			}

		}

		public boolean overBox(float a, float b, float w, float h) {
			return (mouseX >= a && mouseX <= a + w && mouseY >= b && mouseY <= b
					+ h);
		}

	}

	class Money extends Item {
		Money(int posx, int posy, int w) {
			super(posx, posy, 2);
			worth = w;
			radius = (int)((displayWidth/480.0)*10);
		}

		public void act() {
			this.removeSelf();
			player.addMoney(worth);
			println("+" + worth);
		}
	}

	public class PlayerGunLev1 extends Gun {

		boolean flip = false;

		public void shoot(int xpos, int ypos) {
			sound.play(sound.pew);
			if (flip)
				new PlayerBullet(xpos + 12, ypos, 0, -30);
			else
				new PlayerBullet(xpos - 12, ypos, 0, -30);
			flip = !flip;
		}
	}
	public class PlayerGunLev2 extends Gun {
		public void shoot(int xpos, int ypos) {
			sound.play(sound.pew);
				new PlayerBullet(xpos + 12, ypos, 2, -30);
				new PlayerBullet(xpos , ypos, 0, -30);
				new PlayerBullet(xpos - 12, ypos, -2, -30);
		}
	}
	
	public class PlayerGunLev3 extends Gun {
		public void shoot(int xpos, int ypos) {
			sound.play(sound.pew);
			new PlayerBullet(xpos - 12, ypos, -3, -30);
			new PlayerBullet(xpos + 12, ypos, 3, -30);
			new PlayerBullet(xpos +12, ypos, 0, -30);
			new PlayerBullet(xpos - 12, ypos, 0, -30);
		}
	}

	public class PlayerGunLev4 extends Gun {
		public void shoot(int xpos, int ypos) {
			sound.play(sound.pew);
			new PlayerBullet(xpos, ypos, 0, -30);
			new PlayerBullet(xpos + 12, ypos, 3, -30);
			new PlayerBullet(xpos - 12, ypos, -3, -30);
			new PlayerBullet(xpos + 12, ypos, 6, -30);
			new PlayerBullet(xpos - 12, ypos, -6, -30);
		}
	}
	public class PlayerGunLev5 extends Gun {
		public void shoot(int xpos, int ypos) {
			sound.play(sound.pew);

			new PlayerBullet(xpos, ypos, 2, -30);
			new PlayerBullet(xpos, ypos, -2, -30);
			new PlayerBullet(xpos + 12, ypos, 4, -30);
			new PlayerBullet(xpos - 12, ypos, -4, -30);
			new PlayerBullet(xpos + 12, ypos, 8, -30);
			new PlayerBullet(xpos - 12, ypos, -8, -30);
		}
	}
	

	public class PlayerBullet extends Projectile {
		PlayerBullet(int locX, int locY, int xdisp, int ydisp) {
			super(locX, locY, 1, xdisp, ydisp);
			playerBullets.add(this);
		}

		public void removeSelf() {
			for (int i = playerBullets.size() - 1; i >= 0; i--) {
				Projectile p = (Projectile) playerBullets.get(i);
				if (p == this) {
					playerBullets.remove(i);
					break;
				}
			}
		}
	}

	class PlayerShip extends Ship {
		int gunLev, scoreMultiplyer;
		boolean flashed;

		public PlayerShip(int xpos, int ypos) {
			super(0);
			dir = true;
			radius = (int)((displayWidth/480.0)*25);
			locX = xpos;
			locY = ypos;
			speed = (int)((displayWidth/480.0)*25);
			weapon = new PlayerGunLev1();
			flashed = false;
			gunLev = 1;
			scoreMultiplyer = 1;
		}

		public void move() {
			boolean flag = true;
			int dX, dY;
			float magnitude;
			dX = mouseX - locX;
			dY = (int)(mouseY - ((displayWidth/480.0)*80) - locY);
			if (abs(dX) > 15 || abs(dY) > 15) {
				magnitude = sqrt(dX * dX + dY * dY);
				locX += PApplet.parseInt(speed * dX / (magnitude));
				locY += PApplet.parseInt(speed * dY / (magnitude));
			} else {
				locX += dX;
				locY += dY;
			}
			if (locX < 0)
				locX = 0;
			if (locX > displayWidth)
				locX = displayWidth;
			if (locY < 0)
				locY = 0;
			if (locY > displayHeight)
				locY = displayHeight;

		

			
			image(img, locX, locY);
			if(flashed)
			{
				img = loadedShipPics.get(0);
				flashed = false;
			}
			
		}

		boolean left = false;
		public void hit()
		{
			incrementGunLev(-1);
			img = loadedShipFlashPics.get(0);
			flashed = true;
			scoreMultiplyer=1;
			if(canVibrate)
			v.vibrate(300);
		}
		
		public void incrementGunLev(int i)
		{
			gunLev += i;
			if(gunLev <= 0)
				this.blowUp();
			else if(gunLev==1)
				weapon = new PlayerGunLev1();
			else if(gunLev==2)
				weapon = new PlayerGunLev2();
			else if(gunLev==3)
				weapon = new PlayerGunLev3();
			else if(gunLev==4)
				weapon = new PlayerGunLev4();
			else if(gunLev==5)
				weapon = new PlayerGunLev5();
			else 
				{gunLev -=i;
				incrementScoreMultiplyer(1);
				}
		}
		public void shoot() {	
			weapon.shoot(locX, locY);
		}
		public void incrementScoreMultiplyer(int i)
		{
			scoreMultiplyer+=i;
			if(scoreMultiplyer<1)
				scoreMultiplyer=1;
		}

		public void blowUp() {
			println("THE PLAYER HAS DIED");
			PlayerExplosion ps = new PlayerExplosion(locX, locY);
			animations.add(ps);
			updateHighscore();
		}

		public void addMoney(int p) {
			points += p*scoreMultiplyer;
		}

		public int getScore() {
			return points;
		}
	}

	public class PowerUp extends Item {
		int counter, lifeSpan;
		boolean activated;

		PowerUp(int posx, int posy,int imgIndex) {
			super(posx, posy, imgIndex);
			radius = (int)((displayWidth/480.0)*10);
			counter = 0;
			lifeSpan = 250;

		}

		public void act() {
			this.removeSelf();
			activated = true;
			activePowerUps.add(this);
		}

		public void increment() {
			counter++;
			doEffect();
			if (counter > lifeSpan) {
				for (int i = activePowerUps.size() - 1; i >= 0; i--) {
					PowerUp p = activePowerUps.get(i);
					if (p == this) {
						this.removeEffect();
						activePowerUps.remove(i);
						break;
					}
				}
			}
		}

		public void doEffect() {
		}

		public void removeEffect() {
		}
	}
	public class ShieldUp extends PowerUp
	{
		Shield shield = new Shield();
		ShieldUp(int posx, int posy)
		{
			super(posx,posy,12);
		}
		public void doEffect() {
			shield.move();
			for (int i = 0; i < enemyBullets.size(); i++) {
				Projectile p = (Projectile) enemyBullets.get(i);
				if (p.isTouching(shield)) {
					p.removeSelf();
				}
			}	
		}
		public void removeEffect() {
			shield = null;
		}
		
	}
	public class Shield extends Actor
	{
		public void move()
		{
			radius = (int)(100 * displayWidth/480.0);
			locX = player.locX;
			locY = player.locY;
			image(loadedPics.get(13),player.locX,player.locY);
		}
	}
	public class GunUp extends PowerUp
	{
		GunUp(int posX, int posY)
		{
			super(posX,posY,5);
			lifeSpan = 0;
		}
		public void act()
		{
			player.incrementGunLev(1);
			this.removeSelf();
		}
	}
	public class scoreX1 extends PowerUp
	{
		scoreX1(int posX, int posY)
		{
			super(posX,posY,9);
			lifeSpan = 0;
		}
		public void act()
		{
			player.incrementScoreMultiplyer(1);
			this.removeSelf();
		}
	}
	public class scoreX2 extends PowerUp
	{
		scoreX2(int posX, int posY)
		{
			super(posX,posY,10);
			lifeSpan = 0;
		}
		public void act()
		{
			player.incrementScoreMultiplyer(2);
			this.removeSelf();
		}
	}
	public class scoreX3 extends PowerUp
	{
		scoreX3(int posX, int posY)
		{
			super(posX,posY,11);
			lifeSpan = 0;
		}
		public void act()
		{
			player.incrementScoreMultiplyer(3);
			this.removeSelf();
		}
	}
	//CHANGE THIS LATER
	void makeRandPowerUp(int i, int j)
	{
		int b = gen.nextInt(10);
		if (b == 0)
			new Hallucinate(i,j);
		if (b>=1&&b<=4)
			new GunUp(i,j);
		if(b ==5||b==6)
			new ShieldUp(i,j);
		if(b ==7)
			new scoreX1(i,j);
		if(b ==8)
			new scoreX2(i,j);
		if(b ==9)
			new scoreX3(i,j);
	}
	
	abstract class Projectile extends Actor {
		int xdisp, ydisp;

		Projectile(int xpos, int ypos, int imageIndex, int delx, int dely) {
			locX = xpos;
			locY = ypos;
			this.img = loadedPics.get(imageIndex);
			xdisp = delx;
			ydisp = dely;
			radius = (int)((displayWidth/480.0)*7);
		}

		public void move() {
			locY += (int)((displayWidth/480.0)*ydisp);
			locX += (int)((displayWidth/480.0)*xdisp);

			if (locY < -20 || locY > displayHeight + 20 || locX < -20
					|| locX > displayWidth + 20)
				removeSelf();

			display();
		}

		public void removeSelf() {
			for (int i = enemyBullets.size() - 1; i >= 0; i--) {
				Projectile p = (Projectile) enemyBullets.get(i);
				if (p == this) {
					enemyBullets.remove(i);
					break;
				}
			}

		}
	}

	public class Rocket extends Projectile {

		Rocket(int xpos, int ypos, int h, int s) {
			super(xpos, ypos, 3, h, s);
			enemyBullets.add(this);
		}
	}

	abstract class Ship extends Actor {
		int health = 1;
		boolean dir = false; // up cor. to true
		Gun weapon;

		Ship(int imageIndex) {
			radius = (int)((displayWidth/480.0)*40);
			img = loadedShipPics.get(imageIndex);

		}

		public void display() {
			image(img, locX, locY);
		}

		public void move() {
		}

		public void move(int t)// used to pass the tick count to enemy ships
		{
		}

		public void hit() {
			health--;
			if (health == 0)
				blowUp();
		}

		public void shoot() {
			weapon.shoot(locX, locY);
		}

		public void blowUp() {
			removeSelf();
		}

		public void removeSelf() {
			for (int i = enemyShips.size() - 1; i >= 0; i--) {
				Ship p = (Ship) enemyShips.get(i);
				if (p == this) {
					enemyShips.remove(i);
					break;
				}
			}
		}
	}

	class SinShot extends Projectile {
		int xinit, yinit;
		boolean flip = false;

		SinShot(int xpos, int ypos, int dispx, int dispy) {
			super(xpos, ypos, 0, dispx, dispy);
			xinit = xpos;
			yinit = ypos;
			enemyBullets.add(this);
		}

		public void move() {
			locY += ydisp;
			if (flip)
				locX += xdisp;
			else
				locX -= xdisp;
			if (locX > xinit + 50 || locX < xinit - 50)
				flip = !flip;
			if (locY < -100 || locY > displayHeight + 100 || locX < -100
					|| locX > displayWidth + 100)
				removeSelf();
			display();
		}

	}

	public class Sounds {
		public int pew, boom;

		public void setUp() {
			if(assetManager ==null)
			assetManager = getAssets();// needed for sounds, has to be up in
			// rank
			if(soundPool==null)
				soundPool = new SoundPool(20, AudioManager.STREAM_MUSIC, 0);
			try { // loading these files can throw an exception and therefore
					// you HAVE to have a way to handle those events
				pew = soundPool.load(assetManager.openFd("pew.ogg"), 0); // load
				boom = soundPool.load(assetManager.openFd("boom.ogg"), 1);															// the
																			// files
				
			} catch (IOException e) {
				print("OOOOPPPPPPPPPPPPPPPPPPPSSSSSSSSSSSSSSSS");
				e.printStackTrace(); // you can leave this empty...or use some
										// other way to notify the
										// user/developer something went wrong
				buildPlayer();
			}
		}

		public void play(int sound) {
			soundPool.play(sound, 1, 1, 0, 0, 1);// no idea why this is to be
													// quite honest
		}

		public void buildPlayer() {
			if(mediaPlayer==null)
			{
				mediaPlayer = new MediaPlayer();
			AssetFileDescriptor fd = null;

			try {
				fd = assetManager.openFd("bitswithbyte.ogg");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			try {
				mediaPlayer.setDataSource(fd.getFileDescriptor(),
						fd.getStartOffset(), fd.getLength());
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);

			mediaPlayer.setLooping(true);
			try {
				mediaPlayer.prepare();
				musicReady = true;
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		}

	}

	public class SpiralGun extends Gun {
		float degree = 0;
		int speed = (int)((displayWidth/480.0)*5);
		int dispx, dispy;

		SpiralGun() {
		}

		public void shoot(int locX, int locY) {
			degree += PI / 12;
			dispx = (int) (speed * sin(degree));
			dispy = (int) (speed * cos(degree));
			new Bullet(locX, locY, dispx, dispy);
			// print(""+dispx +","+ dispy);
		}
	}

	class SpiralShip extends enemyShip {
		Gun weapon;
		int count = 0;
		boolean shooting = false;
		boolean flip = true;

		SpiralShip(int startx, int starty, int speed, int imageIndex, int f,
				int h, int p) {
			super(imageIndex, 1, h, p, speed);
			weapon = new SpiralGun();
		}

		public void shoot() {
			if (count % 100 == 0)
				shooting = !shooting;
			if (shooting)
				weapon.shoot(locX, locY);
		}
	}

	class SpreadGunE extends Gun {
		public void shoot(int xpos, int ypos) {
			new Bullet(xpos, ypos, 0, 6);
			new Bullet(xpos, ypos, 1, 5);
			new Bullet(xpos, ypos, -1, 5);
			new Bullet(xpos, ypos, 2, 4);
			new Bullet(xpos, ypos, -2, 4);
			
		}
	}

	public class StarGun extends Gun {
		float degree = 0;
		int speed = (int)((displayWidth/480.0)*4);
		int dispx, dispy;

		StarGun() {
		}

		public void shoot(int locX, int locY) {
			for (degree = 0; degree < 2 * PI; degree += PI / 6) {
				dispx = (int) (speed * sin(degree));
				dispy = (int) (speed * cos(degree));
				new Bullet(locX, locY, dispx, dispy);
				// print(""+dispx +","+ dispy);
			}
		}
	}

	Gun getRandGun()
	{
		int i = gen.nextInt(8);
		if(i == 0)
		return new DinkyGun();
		else if(i == 1)
		return new StarGun();
		else if(i == 2)
		return new SpreadGunE();
		else if(i == 3)
		return new SpiralGun();
		else if(i == 4)
		return new doubleGun();
		else if(i == 5)
		return new tripleGun();
		else if(i == 6)
		return new BombLauncher();
		else if(i == 7)
		return new HelixGun();
		else
		return new DinkyGun();
	}
	class TestGun extends Gun {
		public void shoot(int xpos, int ypos) {
			new Bullet(xpos, ypos, 0, 6);
		}
	}

	public class Turret extends Actor {
		int health, freq, count;
		Gun weapon;

		Turret(Gun g, int hlth) {
			health = hlth;
			radius = (int)((displayWidth/480.0)* 15);
			weapon = g;
			img = loadedPics.get(4);
			freq = gen.nextInt(10) + 10;
			count = 0;
		}

		public void act() {
			count++;
			if (count % freq == 0)
				shoot();
		}

		public void increment(int delX, int delY) {
			locX += delX;
			locY += delY;
		}

		public void moveTo(int newx, int newy) {
			locX = newx;
			locY = newy;
		}

		public void shoot() {
			weapon.shoot(locX, locY);

		}

		public int getHealth() {
			return health;
		}

		public void hit() {
			// s.play(2);
			health--;
		}
	}

	abstract class enemyShip extends Ship {
		int path, count = 0, lifeTime = 500, freq, speed, xinit, yinit,
				imageIndex;
		boolean flip = false, flashing = false;

		enemyShip(int imgIndex, int f, int h, int p, int s) {
			super(imgIndex);
			imageIndex = imgIndex;
			speed = s;
			freq = f;
			path = p;
			health = h;
			weapon = new DinkyGun();
			
			if (path == 0) {
				xinit = locX = gen.nextInt(displayWidth);
				yinit = locY = -100;
			}
			if (path == 1) {
				xinit = locX = displayWidth/4;
				yinit = locY = -100;
			}
			if (path == 2) {
				xinit = locX = 3 * displayWidth/4;
				yinit = locY = -100;
			}
			if (path == 3) {
				xinit = locX = displayWidth/5;
				yinit = locY = -100;
				flip = true;
			}
			if (path == 4) {
				xinit = locX = 4 * displayWidth/5;
				yinit = locY = -100;
				flip = false;
			}
			if (path == 5) {
				xinit = locX = -100;
				yinit = locY = displayHeight/5;
			}
			if (path == 6) {
				xinit = locX = displayWidth + 100;
				yinit = locY = displayHeight/5;
			}
			
			
		}

		public void act() {
			count++;
			display();

			if (count > lifeTime)
				flyAway();
			else {
				move();
				if (count % freq == 0)
					shoot();
			}

			if (flashing) {
				revert();
			}
			if (locY < -400 || locY > displayHeight + 400 || locX < -400
					|| locX > displayWidth + 400)
				removeSelf();
		}

		public void move() {
			if (path == 0) {						// STRAIGHT DOWN LIKE A BALLER
				locY += speed;
			}
			if (path == 1) {						// DOWN A BIT THEN DIAG RIGHT
				if (locY < displayHeight / 4) {
					locY += speed;
				} else {
					locY += speed / sqrt(2);
					locX += speed / sqrt(2);
				}
			}
			if (path == 2) {						// DOWN A BIT THEN DIAG LEFT
				if (locY < displayHeight / 4) {
					locY += speed;
				} else {
					locY += speed / sqrt(2);
					locX -= speed / sqrt(2);
				}
			}
			if (path == 3 || path == 4) {			// SIDE TO SIDE
				locY += speed/2;
				if (flip)
					locX += speed;
				else
					locX -= speed;
				if (locX > 8 * displayWidth / 9 || locX < displayWidth / 9) {
					locY += 3*speed;
					flip = !flip;
				}
			}
			if (path == 5) {						// TO THE RIGHT TO THE RIGHT
				locX += speed;
			}
			if (path == 6) {						// TO THE LEFT TO THE LEFT
				locX -= speed;
			}
			if (path == 9) {						// DOWN LEFT, THEN DOWN RIGHT, THEN DOWN
				if (count < 50) {
					locY += speed;
					locX -= speed / 2;
				} else if (count < 125) {
					locY += speed;
					locX += speed / 2;
				} else {
					locY += speed / 2;
				}
			}
			if (path == 8) {						// SOME WEIRD SINE SHIT
				locY += speed;
				locX += sin(count * 3.14f / 6) * 5;
			}


		}

		public void flyAway() {
			locY += speed * 2;
			this.display();
		}

		public void blowUp() {
			
			int w = gen.nextInt(6) + 20;
			new Money(locX, locY, w);
			int randomInt = gen.nextInt(5);
			if (randomInt == 3) {
				makeRandPowerUp(locX,locY);
			}
			EnemyExplosion s = new EnemyExplosion(locX, locY);
			sound.play(sound.boom);
			animations.add(s);
			removeSelf();
		}

		public void shoot() {
			weapon.shoot(locX, locY);
		}

		public void setGun(Gun g) {
			weapon = g;
		}

		public void hit() {
			flash();
			health--;
			if (health == 0)
				blowUp();
		}

		public void flash() {
			img = loadedShipFlashPics.get(imageIndex);
			flashing = true;
			// s.play(1);
		}

		public void revert() {
			img = loadedShipPics.get(imageIndex);
			flashing = false;
		}
	}
	
	public class Animation {
		int locX, locY, current, count;
		PImage currentImg;
		Animation(int xLoc, int yLoc)
		{
			locX = xLoc;
			locY = yLoc;
		}
		
		public  void animate()
		{

		}
		
		public  void removeSelf()
		{
			for(int i = animations.size()-1; i>=0; i--)
			{
				Animation a = (Animation) animations.get(i);
				if (a == this)
				{
					animations.remove(i);
					break;
				}
			}
		}
	}

	public class EnemyExplosion extends Animation {
		EnemyExplosion(int x,int y) {
			super(x, y);
			current = 0;
			currentImg = loadedEnemyShipExpPics.get(0);
		}
		
		public void animate() {
			image(currentImg, locX, locY);
			current++;
			if(current <= loadedEnemyShipExpPics.size()-1)
			{
				currentImg = loadedEnemyShipExpPics.get(current);
			} else {
				super.removeSelf();
			}
		}
	}
	
	public class PlayerExplosion extends Animation {
		PlayerExplosion(int x, int y) {
			super(x,y);
			current = 0;
			currentImg = loadedPlayerShipExpPics.get(0);
		}
		
		public void animate() {
			image(currentImg, locX, locY);
			current++;
			if(current <= loadedPlayerShipExpPics.size()-1)
			{
				currentImg = loadedPlayerShipExpPics.get(current);
			} else {
				super.removeSelf();
				player.removeSelf();
				playGame = false;
				showDeath = true;
			}
		}
	}


	public int sketchWidth() {
		return displayWidth;
	}

	public int sketchHeight() {
		return displayHeight;
	}

	
	public void makeWebPage()
	{
		String url = "http://www.8bitweapon.com/";
		Intent i = new Intent(Intent.ACTION_VIEW);
		i.setData(Uri.parse(url));
		startActivity(i);
	}
}
