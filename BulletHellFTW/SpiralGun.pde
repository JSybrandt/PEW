public class SpiralGun extends Gun
{
  int degree = 0, speed = 5;
  SpiralGun()
  {
  }
  void shoot(int locX, int locY)
  {
    degree += 1 ;
    int dispx = (int)(speed*sin(degree));
    int dispy= (int)(speed*cos(degree));
    new Bullet(locX,locY,dispx,dispy);
    print(""+dispx +","+ dispy);
  }
}
