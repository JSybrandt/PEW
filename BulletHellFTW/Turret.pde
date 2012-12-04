public class Turret extends Actor
{
  int health, freq,count;
  Gun weapon;
  Turret (Gun g, int hlth)
  {
    health = hlth;
    radius = 15;
    weapon = g;
    img = loadedPics.get(6);
    freq = gen.nextInt(10)+10;
    count = 0;
  }
  void act()
  {
    count++;
    if(count % freq == 0)
    shoot();
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
    Sounds.play(2);
    health--;
  }
}
