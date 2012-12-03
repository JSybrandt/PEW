public class DinkyGun extends Gun
{
  void shoot(int locX, int locY)
  {
    new Bullet(locX, locY);
  }
}
