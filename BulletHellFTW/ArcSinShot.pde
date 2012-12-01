class ArcSinShot extends Projectile
{
  int xinit, yinit;
  boolean flip = true;
  ArcSinShot(int xpos, int ypos)
  {
    super(xpos,ypos,true,1,0,7);
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
   if (locY < -100 || locY > displayHeight+100 || locX < -100 || locX > displayWidth+100)
       removeSelf();
   image(img, locX, locY);
  }
  
  
}
