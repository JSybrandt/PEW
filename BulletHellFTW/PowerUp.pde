public class PowerUp extends Item
{
  int counter, lifeSpan;
  PowerUp(int posx, int posy)
  {
    super(posx, posy, 8);
    radius = 10;
    activePowerUps.add(this);
    counter = 0; 
    lifeSpan = 500;
    
    
  }

  void act()
  {
    this.removeSelf();
    doEffect();
  }
 void increment()
 {
   counter++;
   if(counter > lifeSpan)
   {
      for (int i = activePowerUps.size()-1 ; i  >= 0;i--)
      {
        PowerUp p =  activePowerUps.get(i);
        if (p == this)
        {
          activePowerUps.remove(i);
           removeEffect();
          break;
        }
      }
   }
 }  
 void doEffect()
 {
 }
 void removeEffect()
 {
 }
}

