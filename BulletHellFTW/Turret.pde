public class Turret extends Actor
{
  int health;
  Gun weapon;
  Turret (Gun g, int hlth)
  {
    health = hlth;
    radius = 15;
    weapon = g;
    img = loadedPics.get(6);
  }
  void increment(int delX, int delY)
  {
    locX += delX;
    locY += delY;
  }
  void moveTo(int newx, int newy)
  {
    locX=newx;
    locY=newy;
  }
  void shoot()
  {
   weapon.shoot(locX,locY);

  }
  int getHealth()
  {
    return health;
  }
  void hit()
  {
    health--;
  }
}
