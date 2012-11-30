class Drone extends enemyShip
{
  Gun weapon;
 
  
  boolean flip = true;
  Drone(int startx, int starty, int speed, String imgName, int f, int h, int p)
  {
    super( startx, starty, speed, imgName, f, h, p); 
    weapon= new SpreadGunE();
  }
  void shoot()
  {
    weapon.shoot(locX,locY);
  }
}
