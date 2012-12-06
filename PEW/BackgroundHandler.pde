public class BackgroundHandler
{
  PImage bgimg,upcomingImg;
  int scrolly, upcomingScrolly;
  boolean needFlip;
  BackgroundHandler()
  {
    
  }
  void setBG(String img)
  {
    bgimg = loadImage(img);
    upcomingImg = bgimg;
    scrolly = displayHeight;
    upcomingScrolly=0;
  }
  void scroll()
  {
    image(bgimg, displayWidth/2,scrolly-bgimg.height/2);
    scrolly+=5;
    if(scrolly-bgimg.height>=0)
    {
    scrollInNew();
    }
  }
  void scrollInNew()
  {
    image(upcomingImg, displayWidth/2,upcomingScrolly-upcomingImg.height/2);
    upcomingScrolly+=5;
    if(upcomingScrolly>=displayHeight)
    flip();
  }
  void loadNewImg(String img)
  {
    upcomingImg = loadImage(img);
    upcomingScrolly=0;
  }
  void flip()
  {
    needFlip = false;
    bgimg = upcomingImg;
    scrolly = upcomingScrolly;
    upcomingScrolly=0;
  }
 
}
