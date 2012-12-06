class SpreadGunE extends Gun
{
  void shoot(int xpos,int ypos)
  {
    new Bullet(xpos, ypos,  0, 5) ;
    new Bullet(xpos, ypos,  1, 4) ;
    new Bullet(xpos, ypos,  -1, 4) ;
    new Bullet(xpos, ypos,  2, 3) ;
    new Bullet(xpos, ypos,  -2, 3);
  }
}
