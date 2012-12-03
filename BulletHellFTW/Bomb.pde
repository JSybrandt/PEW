public class Bomb extends Projectile
{
  int count, fuse;
  Bomb(int locX, int locY)
  {
    super(locX,locY,10,0,4);
    count = 0;
    fuse = 100;
  }
  void move()
  {
    super.move();
    count++;
    if(count > fuse)
    detonate();
    removeSelf();
  }
  void detonate()
  {
    new StarShot(locX,locY);
  }
}
