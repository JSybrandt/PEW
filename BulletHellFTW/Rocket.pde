public class Rocket extends Projectile
{
 
   Rocket(int xpos, int ypos, int h, int s)
   {
     super(xpos,ypos, 3, h, s);
     enemyBullets.add(this);
   }
}
