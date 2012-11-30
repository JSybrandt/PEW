public class Cruiser extends enemyShip
{
  ArrayList<Turret> guns;
  int count;
  boolean moving,shooting;
  int activeGun;
  int destinationX, destinationY;
  Cruiser(ArrayList<Turret> g)
  {
    super(screenWidth/2, -100, 0, "Cruiser.png", 7, 1000, 1000);
    guns = g;
    prepairTurrets();
    count = 0;
    destinationX = locX;
    destinationY = screenHeight/6;
    moving = true;
    shooting = false;
    activeGun = (int)(guns.size()/2);
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
     if(moving)
     move();
     else if(shooting)
     shoot();
     else
      selectNewGun();
     display();
     displayTurrets();
     checkTurrentHealths();
  }
  void selectNewGun()
  {
      int selection = gen.nextInt(guns.size());
      destinationX = -(guns.get(selection).getLocX());
      activeGun = selection;
      print(""+selection+" at desintation " + destinationX+"\n");
       moving = true;
  }
  void move()
  {
    int delX = 0, delY = 0;
    if( abs(destinationY-locY) > 5)
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
        if( abs(destinationX - locX )> 5)
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

      if(abs(destinationY-locY) < 10 && abs(destinationX-locX) < 10)
      {
      moving = false;
      shooting = true;
      count = 0;
      print("From Moving to Shooting.");
      }
  }
  void shoot()
  {
    if(count % freq == 0)
    guns.get(activeGun).shoot();
    count++;
    if(count > 1000)
    {
      shooting = false;
    }
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
      {
        if(i == activeGun)
        shooting = false;
        
        guns.remove(i);
       
      }
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
