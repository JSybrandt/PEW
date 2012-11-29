class TestGun extends Gun
{
  void shoot(int xpos,int ypos)
  {
    enemyBullets.add( new Bullet(xpos, ypos, false, "bullet.png", 0, 5) );
  }
}
