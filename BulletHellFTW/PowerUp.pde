public class PowerUp extends Item
{
  PowerUp(int posx, int posy)
  {
    super(posx, posy, 8);
    radius = 10;
  }

  void act()
  {
    this.removeSelf();
  }
}

