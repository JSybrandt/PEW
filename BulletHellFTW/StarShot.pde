public class StarShot
{
  
  StarShot(int locX, int locY)
 {
   int speed = 5;
   for(int degree=0;degree < 2*PI;degree += PI/12 )
    {
    int dispx = (int)(speed*sin(degree));
   int dispy= (int)(speed*cos(degree));
    new Bullet(locX,locY,dispx,dispy);
   // print(""+dispx +","+ dispy);
    }
 }
}
