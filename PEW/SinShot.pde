class SinShot extends Projectile
{
  int xinit, yinit;
  boolean flip = false;
  SinShot(int xpos, int ypos, int dispx, int dispy)
  {
    super(xpos,ypos,0,dispx, dispy);
    xinit = xpos;
    yinit = ypos;
    enemyBullets.add(this);
  }
  void move()
  {
    locY+=ydisp;
    if(flip)
    locX+=xdisp;
    else locX-=xdisp;
    if(locX>xinit+50||locX<xinit-50)
     flip= !flip; 
  if (locY < -100 || locY > displayHeight+100 || locX < -100 || locX > displayWidth+100)
       removeSelf();
   display();
  }
  
  
}
