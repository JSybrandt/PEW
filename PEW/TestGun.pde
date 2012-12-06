class TestGun extends Gun
{
  void shoot(int xpos,int ypos)
  {
   new Bullet(xpos, ypos,  0, 5) ;
  }
}
