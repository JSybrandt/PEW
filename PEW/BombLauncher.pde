public class BombLauncher extends Gun
{
  BombLauncher()
  {
  }
  void shoot(int locX, int locY)
  {
    new Bomb(locX,locY);
  }
}
