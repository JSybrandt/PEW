public class Spawner
{
  boolean flip = false;
  int xLoc = 0, yLoc=0;
  void spawn(int l)//l for level , t for ticks
  {

    if (l==0)
      if (tick %50 ==0)
      {

        if (flip)
          enemyShips.add(new Drone(displayWidth/4, 0, 3, "Drone.png", gen.nextInt(50)+50, 5, 2));
        else
          enemyShips.add(new Drone(3*displayWidth/4, 0, 3, "Drone.png", gen.nextInt(50)+50, 5, 1));
        flip = !flip;
      }

    if (l==1)
      if (tick %25 ==0)
      {

        if (flip)
          enemyShips.add(new Drone(displayWidth/4, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 2));
        else
          enemyShips.add(new Drone(3*displayWidth/4, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 1));
        flip = !flip;
      }
    if (l==2)
      if (tick %25 ==0)
      {
          enemyShips.add(new Drone(displayWidth/4, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 8));
          enemyShips.add(new Drone(3*displayWidth/4, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 7));
      }
    if (l==3)
      if (tick %20 ==0)
      {
          xLoc += 30;
          enemyShips.add(new Drone(xLoc, 0, 5, "Drone.png", gen.nextInt(50)+50, 1, 0));
          if (xLoc > displayWidth)
          xLoc =0;
      }
     if(l==4)//figure this  out its garbage
     if(tick%40==0)
     {
       yLoc=gen.nextInt(200)+50;
       enemyShips.add(new HelixShip(0,yLoc));
     }
  }
}
