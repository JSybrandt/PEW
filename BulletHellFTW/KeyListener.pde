void keyPressed() {
  if (key == ' ')
    player.shoot();

  if (key=='p')
    psychedelicMode = !psychedelicMode;
    
  if(key == 's')
    spawning = !spawning;
  if (key=='q'||key=='b')   
 //  if(key == MENU)
   {
      int yLoc = gen.nextInt(displayWidth);
     int xLoc= gen.nextInt(displayWidth);
     enemyShip s = new Drone(xLoc, yLoc, 5, 4, 10, 1, 100);
    // if(key=='q')
    // s.setGun(new StarGun());
    // if(key=='b')
     s.setGun(new BombLauncher());
     enemyShips.add(s);
   }
     
     if(key == 'r')
      // if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_MENU) 
     if (playGame == true)
  {
  
    {
       playGame = false;
       showMenu = true;
       showCredits = false;
    }
  }
}
