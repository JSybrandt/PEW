public class HelixGun extends Gun
{
  HelixGun()
  {
  }
  boolean left = false;
  void shoot(int xpos, int ypos)
  {
    left = !left;
    if(left)
    new SinShot(xpos, ypos-10,5,5);
    else
     new SinShot(xpos, ypos+10,-5,5);
  }
}
