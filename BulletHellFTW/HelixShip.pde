class HelixShip extends enemyShip
{
  Gun weapon;
  boolean flip, shooting;
  HelixShip(int startx, int starty)
  {
    super(startx, starty, 3, "HerpADerp.png", 10, 40, 9);
    flip = false;
    shooting = false;
    weapon= new RocketLauncherE();
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
    weapon.shoot(locX+40,locY);
    else
    weapon.shoot(locX-40, locY);
    flip = !flip;  
  }
}

