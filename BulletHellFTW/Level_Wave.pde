public class Wave
{
  Wave(int n, int d)
  {
    tick = 0;
    wavedone = false;
    wavenum = n;
    difficulty = d;
  }
  boolean wavedone;
  int wavenum;
  int difficulty;
  int tick;
  void spawn()
  {

  }
}

public class Level
{
  Level(int n)
  {
    wavedone = false;
    levelnumber = n;
    bgimg = 1+gen.nextInt(6);
    for(int i=0; i < levelnumber%5*2+1; i++)
    {
      waves.add(new Wave(i, levelnumber/5));
    }
    //bghandel.loadNewImage();
  }
  boolean wavedone;
  int levelnumber;
  int bgimg;
  ArrayList waves = new ArrayList<Wave>();
}
