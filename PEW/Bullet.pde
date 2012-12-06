class Bullet extends Projectile
{
  Bullet(int xpos, int ypos, int h, int s)
  {
    super(xpos, ypos, 0, h, s);
    enemyBullets.add(this);
    radius = 7;
  }
  Bullet(int xpos, int ypos)
  {
    super(xpos, ypos, 0, 0, 4);
    enemyBullets.add(this);
    radius = 7;
  }
  
}

