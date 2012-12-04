public class Menu {
  
  /*
 
PImage MenuImage;// = loadImage("MainMenu.png");;
int PlayX, PlayY, playSizeY, playSizeX;      // Position of square button

Menu()
{
  playgame = false;
  MenuImage = loadImage("MainMenu.png");
  PlayX = displayWidth/2;
  PlayY = displayHeight/2;
  playSizeY = displayHeight/2;// Diameter of 
  playSizeX = displayWidth/2;
}
*/

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
}
