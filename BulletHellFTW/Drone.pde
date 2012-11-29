class Drone extends enemyShip
{
  boolean flip = true;
  Drone(int startx, int starty, int speed, String imgName, int f, int h, int p)
  {
    super( startx, starty, speed, imgName, f, h, p);
  }
  void shoot()
  {
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 0, 5) );
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 2, 4));
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", -2, 4) );
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", 4, 3 ));
    enemyBullets.add( new Bullet(locX, locY, dir, "bullet.png", -4, 3 ));
  }
}
