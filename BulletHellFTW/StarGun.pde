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
    for(degree=0;degree < 2*PI;degree += PI/12 )
    {
     dispx = (int)(speed*sin(degree));
    dispy= (int)(speed*cos(degree));
    new Bullet(locX,locY,dispx,dispy);
   // print(""+dispx +","+ dispy);
    }
  }
}
