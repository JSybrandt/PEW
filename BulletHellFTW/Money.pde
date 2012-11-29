class Money extends Item
{
  Money(int posx, int posy, int w)
  {
    super(posx, posy, "coin.png");
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
