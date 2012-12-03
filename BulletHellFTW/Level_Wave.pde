public class Wave
{
  Wave(int d)
  {
    tick = 0;
    difficulty = d;
    pattern = gen.nextint(10);
  }
  int difficulty;
  int pattern;
  int tick;
  void spawnship()
  {
    
  }
  void spawn()
  {
    if(pattern == 0)
    {
      
    }
    if(pattern == 1)
    {
      
    }
  }
}

public class Level
{
  Level(int n)
  {
    levelnumber = n;
    bgimg = gen.nextint(6);
    for(int i=0; i < levelnumber%5*2+1; i++)
    {
      waves.add(new Wave(levelnumber/5));
    }
  }
  int levelnumber;
  int bgimg;
  ArrayList waves = new ArrayList<Wave>();
}
