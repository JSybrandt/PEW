class RocketLauncherE extends Gun
{
  void shoot(int xpos,int ypos)
  {
    enemyBullets.add( new Bullet(xpos, ypos, false, "RocketE.png", 0, 7) );
  }
}
