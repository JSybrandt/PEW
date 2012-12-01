class PlayerShip extends Ship {
  int points;
  PlayerShip(int xpos, int ypos)
  {
    super(7);
    dir = true;
    radius = 25;
    locX = xpos;
    locY = ypos;
    speed = 10;
    weapon = new PlayerBaseGun();
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
  weapon.shoot(locX,locY);
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

