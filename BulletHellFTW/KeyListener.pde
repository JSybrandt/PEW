void keyPressed() {
  if (key == ' ')
    player.shoot();

  if (key=='p')
    psychedelicMode = !psychedelicMode;
    
  if(key == 's')
    spawning = !spawning;
  if (key == CODED)   
 //  if(key == MENU)
   {
      int yLoc = gen.nextInt(displayWidth);
     int xLoc= gen.nextInt(displayWidth);
     enemyShips.add(new Drone(xLoc, yLoc, 5, 4, 1, 1, 100));
   }
}
