abstract class Projectile extends Actor
{
  int horDisp;
  Projectile(int xpos, int ypos, boolean d, String img, int h, int s)
  {
    locX=xpos;
    locY=ypos;
    dir = d;
    this.img = loadImage(img);
    speed = s;
    horDisp = h;
    radius = 7;
  }

  void move()
  {
    if (dir)
      locY -=speed;
    else
      locY += speed;

    locX+= horDisp;

    if (locY < -100 || locY > displayHeight+100 || locX < -100 || locX > displayWidth+100)
       removeSelf();
    image(img, locX, locY);
  }


  void removeSelf()
  {
    boolean flag = false;
    for (int i = enemyBullets.size()-1 ; i  >= 0;i--)
    {
      Projectile p = (Projectile) enemyBullets.get(i);
      if (p == this)
      {
        enemyBullets.remove(i);
        flag = true;
        break;
      }
    }
    if (!flag)
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
