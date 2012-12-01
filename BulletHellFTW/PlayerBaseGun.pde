public class PlayerBaseGun extends Gun
{
  void shoot(int xpos, int ypos)
  {
    new PlayerBullet(xpos, ypos, 0, -10);
  }
}
