void keyPressed() {
  if (key == ' ')
    player.shoot();

  if (key=='p')
    psychedelicMode = !psychedelicMode;
    
  if(key == 's')
    spawning = !spawning;
  if (key == CODED||key=='q')   
 //  if(key == MENU)
   {
      int yLoc = gen.nextInt(displayWidth);
     int xLoc= gen.nextInt(displayWidth);
     enemyShip s = new Drone(xLoc, yLoc, 5, 4, 10, 1, 100);
     s.setGun(new StarGun());
     enemyShips.add(s);
   }
}
