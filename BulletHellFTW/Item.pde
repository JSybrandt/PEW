abstract class Item extends Actor
{
  int worth;
  int speed = 1;
  Item(int posx, int posy, String imgName)
  {
    locX = posx;
    locY = posy;
    img = loadImage(imgName);
    items.add(this);
  }
  void move()
  {
    locY += speed;
    if (locY > displayHeight+100)
      removeSelf();
    image(img, locX, locY);
  }

  void removeSelf()
  {
    for (int i = items.size()-1 ; i  >= 0;i--)
    {
      Item p = (Item) items.get(i);
      if (p == this)
      {
        items.remove(i);
        break;
      }
    }
  }

  void act()
  {
  }
}
