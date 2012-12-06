
public static class Sounds
{
  static SoundPool soundPool;
  static AssetManager assetManager;
  static int PEW;

  public static void setUp()
  {
    soundPool = new SoundPool(20, AudioManager.STREAM_MUSIC, 0); //(max #of streams, stream type, source quality) - see the android reference for details
    assetManager = this.getAssets();
    try
    {
      pew = soundPool.load(assetManager.openFd("\\sounds\\pew.mp3"), 0); //load the files
    }
    catch (IOException e) {
      print("Opps..");
      e.printStackTrace(); //you can leave this empty...or use some other way to notify the user/developer something went wrong
    }
  }
  public static void play(int i)
  {
    soundPool.play(i, 1, 1, 0, 0, 1);//no idea why this is to be quite honest
  }

  public static endAll() {//needed to close sound stuff right

    if (soundPool!=null) { //must be checked because or else crash when return from landscape mode
      soundPool.release(); //release the player
    }
  }
}

