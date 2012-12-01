class SpreadGunE extends Gun
{
  void shoot(int xpos,int ypos)
  {
    enemyBullets.add( new Bullet(xpos, ypos, false, 0, 0, 5) );
    enemyBullets.add( new Bullet(xpos, ypos, false, 0, 1, 4) );
    enemyBullets.add( new Bullet(xpos, ypos, false, 0, -1, 4) );
    enemyBullets.add( new Bullet(xpos, ypos, false, 0, 2, 3) );
    enemyBullets.add( new Bullet(xpos, ypos, false, 0, -2, 3) );
  }
}
