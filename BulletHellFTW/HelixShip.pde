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

