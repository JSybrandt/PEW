public class Cruiser extends enemyShip
{
  ArrayList<Turret> guns;
  int count;
  boolean moving;
  int activeGun;
  int destinationX, destinationY;
  Cruiser(ArrayList<Turret> g)
  {
    super(240, -100, 1, "BossBody.png", 1000, 1000, 1000);
    guns = g;
    prepairTurrets();
    count = 0;
    destinationX = locX;
    destinationY = 30;
    moving = true;

  }
  void prepairTurrets()
  {
    double gunRange = 0;
    if(guns.size()>0)
     gunRange = 800/guns.size();
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).moveTo((int)(locX-400+i*gunRange),locY+150);
    }
  }
  void act()
  {
    count++;
    if (count ==1000)
     {
      int selection = gen.nextInt(guns.size());
      destinationX = guns.get(selection).getLocX();
      activeGun = selection;
      print(selection);
       moving = true;
       count = 0;
     }
     if(moving)
     move();
     else
     shoot();
     display();
     displayTurrets();
     checkTurrentHealths();
  }
  void move()
  {
    int delX = 0, delY = 0;
    if(destinationY-locY > 5)
      {
        if(destinationY > locY)
        {
          locY+=speed;
          delY = speed;
        }
         else
         {
            locY-=speed;
          delY = -speed;
         }
      }
      else
      {
        if(destinationX - locX > 5)
        {
         if(destinationX > locX)
        {
          locX+=speed;
          delX = speed;
        }
         else
         {
            locX-=speed;
          delX = -speed;
         }
        }
      }
      moveTurrets(delX,delY);
      if(destinationY-locY > 5 && destinationX-locX > 5)
      moving = false;
  }
  void shoot()
  {
    guns.get(activeGun).shoot();
  }
  void moveTurrets(int delX, int delY)
  {
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).increment(delX,delY);
    }
  }
  void displayTurrets()
  {
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).display();
    }
  }
  void checkTurrentHealths()
  {
    for(int i = guns.size()-1; i >= 0; i--)
    {
      if (guns.get(i).getHealth()<1)
        guns.remove(i);
    }
    if(guns.size()<1)
    {
      super.blowUp();
    }
  }
  ArrayList<Turret> getTurretList()
  {
    return guns;
  }
}
