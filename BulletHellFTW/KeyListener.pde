void keyPressed() {
  if (key == ' ')
    player.shoot();

  if (key=='p')
    psychedelicMode = !psychedelicMode;
    
  if(key == 's')
    spawning = !spawning;
  if (key == CODED||key=='q'||key=='b')   
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
     if (playgame == true)
  {
    if (key == 'r' || key == 'R') 
    {
       playgame = false;
    }
  }
}
