abstract class Actor
{
  int locX, locY, radius, speed;
  boolean dir;
  PImage img;

  void move()
  {
  }
  boolean isTouching(Actor b)
  {
    if (sqrt(pow(locX - b.locX, 2) + pow(locY - b.locY, 2))<(radius+b.radius))
      return true;
    else
      return false;
  }
  void display()
  {
    image(img, locX, locY);
  }
  int getLocX()
  {
    return locX;
  }
    int getLocY()
  {
    return locY;
  }
}
