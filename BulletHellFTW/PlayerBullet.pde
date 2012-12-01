public class PlayerBullet extends Projectile
{
  PlayerBullet(int locX, int locY, int xdisp, int ydisp)
  {
    super(locX, locY, 1, xdisp, ydisp);
    playerBullets.add(this);
  }
}
