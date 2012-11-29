class SinShot extends Projectile
{
  int xinit, yinit;
  boolean flip = false;
  SinShot(int xpos, int ypos)
  {
    super(xpos,ypos,true,"playerbullet.png",0,7);
    xinit = xpos;
    yinit = ypos;
  }
  void move()
  {
    locY-=speed;
    if(flip)
    locX+=speed;
    else locX-=speed;
    if(locX>xinit+50||locX<xinit-50)
     flip= !flip; 
   if (locY < -10 || locY > 810 || locX < -10 || locX > 490)
       removeSelf();
   image(img, locX, locY);
  }
  
  
}
