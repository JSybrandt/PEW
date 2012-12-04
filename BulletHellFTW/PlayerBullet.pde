public class PlayerBullet extends Projectile
{
  PlayerBullet(int locX, int locY, int xdisp, int ydisp)
  {
    super(locX, locY, 1, xdisp, ydisp);
    playerBullets.add(this);
  }
  void removeSelf()
  {
      for (int i = playerBullets.size()-1 ; i  >= 0;i--)
      {
        Projectile p = (Projectile) playerBullets.get(i);
        if (p == this)
        {
          playerBullets.remove(i);
          break;
        }
      }
  }
}
