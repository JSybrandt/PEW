class Money extends Item
{
  Money(int posx, int posy, int w)
  {
    super(posx, posy, 2);
    worth = w;
    radius = 10;
  }

  void act()
  {
    this.removeSelf();
    player.addMoney(worth);
    println("+"+worth);
  }
}
