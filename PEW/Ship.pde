abstract class Ship extends Actor
{
  int health = 1;
  boolean dir = false; //up cor. to true
  Gun weapon;
  Ship(int imageIndex)
  {
    radius = 25;
    img = loadedPics.get(imageIndex);
  }
  void display()
  {
    image(img, locX, locY);
  }
  void move()
  {
  }
  void move(int t)//used to pass the tick count to enemy ships
  {
  }
  void hit()
  {
    health--;
    if (health == 0)
      blowUp();
  }
  void shoot()
  {
    weapon.shoot(locX,locY);
  }
  void blowUp()
  {
    println("BOOM");//we can add in animation here
    removeSelf();
  }
  void removeSelf()
  {
    for (int i = enemyShips.size()-1 ; i  >= 0;i--)
    {
      Ship p = (Ship) enemyShips.get(i);
      if (p == this)
      {
        enemyShips.remove(i);
        break;
      }
    }
  }
}
