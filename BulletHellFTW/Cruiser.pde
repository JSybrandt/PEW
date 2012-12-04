public class Cruiser extends enemyShip
{
  ArrayList<Turret> guns;
  int[] turretsX = {-600,-530,-470,-420,-376,-340,-296,-150,-90,-30,30,100,220,300,370,450};
  int[] turretsY = {136,136,136,90,18,90,18,162,162,162,162,166,82,82,82,82};
  int count;
  boolean moving,shooting;
  int activeGun;
  Turret activeTurret;
  int destinationX, destinationY;
  
  Cruiser(ArrayList<Turret> g)
  {
    super(displayWidth/2, -100, 3, 5, 7, 1000, 1000);
    guns = g;
    prepairTurrets();
    count = 0;
    destinationX = locX;
    destinationY = displayHeight/4;
    moving = true;
    shooting = false;
   selectNewGun();
    
  }
  void prepairTurrets()
  {
    double gunRange = 0;
    if(guns.size()>0)
     gunRange = 800/guns.size();
    for(int i = 0; i < guns.size(); i++)
    {
      guns.get(i).moveTo(locX+turretsX[i],locY+turretsY[i]);
    }
  }
  void act()
  {
      display();
     displayTurrets();
     checkTurrentHealths();
     if(moving)
     move();
     else if(shooting)
     shoot();
     else if(guns.size()>0)
      selectNewGun();
     else super.blowUp();
    
  
  }
  void selectNewGun()
  {
      int selection = gen.nextInt(guns.size());
      activeTurret =  guns.get(selection);
      destinationX = displayWidth/2-activeTurret.getLocX();
  //    destinationY = activeTurret.getLocY();
      activeGun = selection;
      activeTurret =  guns.get(selection);
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
         if(destinationX > 0)
        {
          locX+=speed;
          delX = speed;
          destinationX -=speed;
        }
         else
         {
            locX-=speed;
          delX = -speed;
          destinationX +=speed;
         }
        
      }
     
      moveTurrets(delX,delY);
      print("%%"+(destinationX - locX));

      if(abs(destinationY-locY) < 10 && abs(destinationX) < 10)
      {
      moving = false;
      shooting = true;
      count = 0;
      print("From Moving to Shooting.");
      }
  }
  void shoot()
  {
   for(int i = 0; i < guns.size(); i++)
    {
      if(guns.get(i).getLocX()>0&&guns.get(i).getLocX()<displayWidth)//aka on screen
      {
        guns.get(i).act();
      }
    }
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
        if(guns.get(i)==activeTurret)
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
  void hit()
  {
    //do nothing;
  }
}
