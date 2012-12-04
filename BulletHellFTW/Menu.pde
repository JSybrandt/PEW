public class Menu {
  
PImage MenuImage;// = loadImage("MainMenu.png");;
float PlayX, PlayY, playSizeY, playSizeX;      // Position of square button
float creditsX,creditsY, creditsSizeX, creditsSizeY;
float scoreX, scoreY, scoreSizeX,scoreSizeY;
float tutX,tutY, tutSizeX, tutSizeY;
float opX, opY, opSizeX, opSizeY;
 
 Menu() 
 {
  playGame = false;
  MenuImage = loadedPics.get(12);
  
  PlayX = displayWidth/13.2;
  PlayY = (displayHeight/1.865);
  playSizeY = displayHeight/7.8;// Diameter of 
  playSizeX = displayWidth/1.201;
  
  
  scoreX = displayWidth*(1/2.0);
  scoreY = displayHeight*(5/7.4);  
  scoreSizeX = displayWidth/2.402;
  scoreSizeY = displayHeight/7.8;
  
   creditsX = displayWidth*(1/2.0);
  creditsY = displayHeight*(6/7.4);  
  creditsSizeX = displayWidth/2.402;
  creditsSizeY = displayHeight/7.8;
  
  
   tutX = displayWidth*(0.07);
   tutY = displayHeight*(5/7.4);
   tutSizeX = displayWidth/2.402;
   tutSizeY = displayHeight/7.8;
   
   opX = displayWidth*(0.07);
   opY = displayHeight*(6/7.4);  
   opSizeX = displayWidth/2.402;
   opSizeY =  displayHeight/7.8;
   
 }
  
  
  void showMenu() {
     
    
    spawning = false;
    playGame = false;
    
    image(MenuImage, displayWidth/2, displayHeight/2, displayWidth, displayHeight);
    

    if(overBox(PlayX, PlayY, playSizeX, playSizeY))
    {
      if(mousePressed == true)
      {
        showMenu = false;
        playGame = true;
      }
    }
     if(overBox(creditsX, creditsY, creditsSizeX, creditsSizeY))
    {
      if(mousePressed == true)
      {
        showCredits = true;
        showMenu = false; 
        
      }
    }
     if(overBox(tutX,tutY, tutSizeX, tutSizeY))
    {
      if(mousePressed == true)
      {
        showInstructions=true;
        showMenu = false;
      }
    }
     if(overBox(opX, opY, opSizeX, opSizeY))
    {
      if(mousePressed == true)
      {
        showOptions = true;
        showMenu = false;
      }
    }
     if(overBox( scoreX, scoreY, scoreSizeX,scoreSizeY))
    {
      if(mousePressed == true)
      {
        showHighScore = true;
        showMenu = false;
      }
    }
   
  }
  boolean overBox(float a, float b, float w, float h)  
{
  return (mouseX >= a && mouseX <= a+w && 
      mouseY >= b && mouseY <= b+h);
}

}
