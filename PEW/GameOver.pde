void GameOverMessage(String msg)
{
  textFont(fontG);
  fill(110, 50, 255);
    textAlign(CENTER);
  text(msg+ "\nScore: " + points + "\nHigh Score: " + highscore, displayWidth / 2, displayHeight / 2);
} 
