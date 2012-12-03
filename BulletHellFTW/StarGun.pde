public class StarGun extends Gun
{
  float degree = 0;
 int speed = 5;
  int dispx, dispy;
  StarGun()
  {
  }
  void shoot(int locX, int locY)
  {
   new StarShot(locX,locY);
  }
}
