class HelixShip extends enemyShip
{
  boolean flip, shooting;
  HelixShip(int startx, int starty)
  {
    super(startx, starty, 3, 9, 10, 40, 9);
    flip = false;

    
    weapon = new HelixGun();
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

