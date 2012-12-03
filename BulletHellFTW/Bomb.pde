public class Bomb extends Projectile
{
  int count;
  int lifeSpan;
  int speed;
  Bomb(int locX, int locY)
  {
    super(locX,locY,10,0,5);
    count = 0;
    lifeSpan = 0;
    speed = 5;
    enemyBullets.add(this);
  }
  void move()
  {
    super.move();
    count++;
    if(count > lifeSpan)
    {
    detonate();
    removeSelf();
    }
  }
  void detonate()
  {
    for(float degree=0;degree < 2*PI;degree += PI/12 )
    {
     int dispx = (int)(speed*sin(degree));
    int dispy= (int)(speed*cos(degree));
    new Bullet(locX,locY,dispx,dispy);
   // print(""+dispx +","+ dispy);
    }
  }
}
