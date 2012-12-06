public class SpiralGun extends Gun
{
  float degree = 0;
 int speed = 5;
  int dispx, dispy;
  SpiralGun()
  {
  }
  void shoot(int locX, int locY)
  {
    degree += PI/12 ;
    dispx = (int)(speed*sin(degree));
    dispy= (int)(speed*cos(degree));
    new Bullet(locX,locY,dispx,dispy);
   // print(""+dispx +","+ dispy);
  }
}
