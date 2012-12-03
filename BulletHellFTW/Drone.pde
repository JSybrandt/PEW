class Drone extends enemyShip
{
  Gun weapon;
  
  boolean flip = true;
  Drone(int startx, int starty, int speed, int imageIndex, int f, int h, int p)
  {
    super( startx, starty, speed, imageIndex, f, h, p); 
    weapon= new DinkyGun();
  }

}
