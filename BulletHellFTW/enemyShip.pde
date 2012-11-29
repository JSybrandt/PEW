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
