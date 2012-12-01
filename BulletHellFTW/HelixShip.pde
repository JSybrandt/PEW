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
    if (locY > displayHeight+100 || locX < -100 || locX > displayWidth+100)
      removeSelf();
  } 
  void shoot()
  {
    if(flip)
<<<<<<< HEAD
    weapon.shoot(locX+40,locY);
    else
    weapon.shoot(locX-40, locY);
=======
    new SinShot(locX,locY);
    else
    new ArcSinShot(locX,locY);
>>>>>>> parent of 0d70db6... More Images and a upgrade to the HelixShip
    flip = !flip;  
  }
}

