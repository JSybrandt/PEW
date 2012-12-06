void GameOverMessage(String msg)
{
  image(loadImage("Back.png"),displayWidth/2,displayHeight/12,displayWidth, displayHeight/6);
  textFont(fontG);
  fill(110, 50, 255);
    textAlign(CENTER);
  text(msg+ "\nScore: " + points + "\nHigh Score: " + highscore, displayWidth / 2, displayHeight / 2);
  
   if(mousePressed && mouseY<displayHeight/6)
  {
    textAlign(LEFT);
    textFont(f, 24);
    fill(255);
    showDeath = false;
    showMenu = true;
    playGame = false;
  }
}
