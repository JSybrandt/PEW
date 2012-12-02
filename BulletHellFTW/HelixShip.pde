class HelixShip extends enemyShip
{
  boolean flip, shooting;
  HelixShip(int startx, int starty)
  {
    super(startx, starty, 3, 9, 10, 40, 9);
    flip = false;

    
    weapon = new HelixGun();
  }
 void act()
  {
    count++;

    if (count > lifeTime)
      flyAway();
    else
    {
      if (count % 400 == 0)
         shooting = !shooting;
         
      
      if(count % freq  ==0)
      shoot();
  
      move();
      
      display();
    }   
    if (locY > displayHeight+100 || locX < -100 || locX > displayWidth+100)
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

