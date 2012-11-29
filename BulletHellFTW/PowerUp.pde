public class PowerUp extends Item
{
  PowerUp(int posx, int posy)
  {
    super(posx, posy, "PowerUp.png");
    radius = 10;
  }

  void act()
  {
    this.removeSelf();
  }
}

