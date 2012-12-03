public class PlayerBaseGun extends Gun
{
  boolean flip = false;
  void shoot(int xpos, int ypos)
  {
    if(flip)
    new PlayerBullet(xpos+12, ypos, 0, -20);
    else
    new PlayerBullet(xpos-12, ypos, 0, -20);
    flip = !flip;
  }
}

public class PlayerAwesomeGun extends Gun
{
  
  void shoot(int xpos, int ypos)
  {
    new PlayerBullet(xpos, ypos, 0, -20);
    new PlayerBullet(xpos+12, ypos, 3, -20); 
    new PlayerBullet(xpos-12, ypos, -3, -20);
     new PlayerBullet(xpos+12, ypos, 6, -20); 
    new PlayerBullet(xpos-12, ypos, -6, -20);
    
  }
}
