public class BackgroundHandler
{
  PImage bgimg;
  int scrolly;
  BackgroundHandler()
  {
    
  }
  void setBG(String img)
  {
    bgimg = loadImage(img);
    scrolly = displayHeight;
  }
  void scroll()
  {
    image(bgimg, displayWidth/2,scrolly-bgimg.height/2);
    scrolly++;
    if(scrolly-displayHeight-bgimg.height==0)
    scrolly=0;
  }
 
}
