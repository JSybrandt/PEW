public static class Sounds
{
 // static AudioOutput out = minim.getLineOut();;
  static float volumeLevel=0.5;
  //static SoundPool noises = new SoundPool(10, AudioManager.STREAM_MUSIC,0);
  
  public static void setUp()
  {
   adjustVolume(0);
 //  out = minim.getLineOut();
  //  noises.put(1, soundPool.load(this, data.sounds.pew, 1));
  // noises.add(minim.loadSample("\\sounds\\tchhhh.mp3"));
 //  noises.add(minim.loadSample("\\sounds\\tch.mp3"));
   
   
  }
  public static void mute()
  {
    //out.mute();
  }
   public static void unMute()
  {
   // out.unmute();
  }
  public static void adjustVolume(float delV)
  {
   // volumeLevel+=delV;
  // if ( out.hasControl(Controller.VOLUME) )
  // out.setVolume(volumeLevel);
  //  if ( out.hasControl(Controller.GAIN) )
  //  out.setGain(volumeLevel);
  }
  public static void play(int i)
  {
  //  if(i < noises.size())
  //  noises.get(i).trigger();
  }
  
    void stop()
   {
    //out.close();
   // minim.stop();
    }
}
