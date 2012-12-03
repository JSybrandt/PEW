class SpiralShip extends enemyShip
{
  Gun weapon;
  int count = 0;
  boolean shooting = false;
  boolean flip = true;
  SpiralShip(int startx, int starty, int speed, int imageIndex, int f, int h, int p)
  {
    super( startx, starty, speed, imageIndex, 1, h, p); 
    weapon= new SpiralGun();
  }
  void shoot()
  {
    if(count % 100 == 0)
    shooting = !shooting;
    if(shooting)
    weapon.shoot(locX,locY);
  }
}
