abstract class enemyShip extends Ship
{
  int path, count = 0, lifeTime = 500, freq, speed, xinit, yinit;
  boolean flip = false;
  enemyShip(int startx, int starty, int s, int imageIndex, int f, int h, int p)
  {
    super(imageIndex);
    locX = startx;
    locY = starty;
    xinit = startx;
    yinit = starty;
    speed = s;
    freq = f;
    path = p;
    health = h;
    weapon = new DinkyGun();
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
   if (locY < -400 || locY > displayHeight+400 || locX < -400 || locX > displayWidth+400)
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
      if (locY < displayHeight/3)
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
      if (locY < displayHeight/3)
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
      if (locX > 8*displayWidth/9 || locX < displayWidth/9)
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
    new Hallucinate(locX + 20, locY - 20);
    }
    removeSelf();
  }
  void shoot()
  {
    weapon.shoot(locX,locY);
  }
  void setGun(Gun g)
  {
    weapon = g;
  }
}
