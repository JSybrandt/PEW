public class Menu {
  
PImage MenuImage;// = loadImage("MainMenu.png");;
float PlayX, PlayY, playSizeY, playSizeX;      // Position of square button


 
 Menu() 
 {
  playgame = false;
  MenuImage = loadedPics.get(12);
  PlayX = displayWidth/13.2;
  PlayY = (displayHeight/1.865);
  playSizeY = displayHeight/7.8;// Diameter of 
  playSizeX = displayWidth/1.201;
  
 }
  
  void ScreenTest() {
    spawning = 
    false;
    image(MenuImage, displayWidth/2, displayHeight/2, displayWidth, displayHeight);
    if(overBox(PlayX, PlayY, playSizeX, playSizeY) == true)
    {
      if(mousePressed == true)
      {
        playgame = !playgame;
      }
    }
  }
  boolean overBox(float x, float y, float width, float height)  
{
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) 
  {
    return true;
  } 
  else 
  {
    return false;
  }
}

}
