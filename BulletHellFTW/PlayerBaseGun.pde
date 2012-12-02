public class PlayerBaseGun extends Gun
{
  boolean flip = false;
  void shoot(int xpos, int ypos)
  {
    if(flip)
    new PlayerBullet(xpos+12, ypos, 0, -10);
    else
    new PlayerBullet(xpos-12, ypos, 0, -10);
    flip = !flip;
  }
}
