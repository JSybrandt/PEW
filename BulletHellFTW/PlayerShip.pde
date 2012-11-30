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
    if(locX > displayWidth)
      locX = displayWidth;
    if(locY < 0)
      locY = 0;
    if(locY > displayHeight)
      locY = displayHeight;

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

