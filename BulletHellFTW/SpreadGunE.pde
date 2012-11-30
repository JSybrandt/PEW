class SpreadGunE extends Gun
{
  void shoot(int xpos,int ypos)
  {
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", 0, 5) );
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", 1, 4) );
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", -1, 4) );
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", 2, 3) );
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", -2, 3) );
  }
}
