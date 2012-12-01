public class Turret extends Actor
{
  int health;
  Gun weapon;
  Turret (Gun g, int h)
  {
    health = h;
    radius = 15;
    weapon = g;
    img = loadImage("Turret.png");
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
   weapon.shoot(locX,locY+50);

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
