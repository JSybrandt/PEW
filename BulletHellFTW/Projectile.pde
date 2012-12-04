abstract class Projectile extends Actor
{
  int xdisp, ydisp;
  Projectile(int xpos, int ypos, int imageIndex, int delx, int dely)
  {
    locX=xpos;
    locY=ypos;
    this.img = loadedPics.get(imageIndex);
    xdisp = delx;
    ydisp = dely;
    radius = 7;
  }

  void move()
  {
    locY+= ydisp;
    locX+= xdisp;

    if (locY < -100 || locY > displayHeight+100 || locX < -100 || locX > displayWidth+100)
       removeSelf();
       
    display();
  }


  void removeSelf()
  {
    for (int i = enemyBullets.size()-1 ; i  >= 0;i--)
    {
      Projectile p = (Projectile) enemyBullets.get(i);
      if (p == this)
      {
        enemyBullets.remove(i);
        break;
      }
    }
   
  }
}
