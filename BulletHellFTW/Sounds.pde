AssetManager assetManager = this.getAssets();//needed for sounds, has to be up in rank
SoundPool soundPool = new SoundPool(20, AudioManager.STREAM_MUSIC, 0);
public class Sounds
{
 int pew, sound2, sound3, sound4, sound5;


 
 public void setUp()
 {
 try { //loading these files can throw an exception and therefore you HAVE to have a way to handle those events
  pew = soundPool.load(assetManager.openFd("pew.wav"), 0); //load the files
  sound2 = soundPool.load(assetManager.openFd("samp2.wav"), 0);
  sound3 = soundPool.load(assetManager.openFd("samp3.wav"), 0);
  sound4 = soundPool.load(assetManager.openFd("samp4.wav"), 0);
  sound5 = soundPool.load(assetManager.openFd("samp5.wav"), 0);
  } catch (IOException e) {
   e.printStackTrace(); //you can leave this empty...or use some other way to notify the user/developer something went wrong
  }
 }
 public  void play(int i)
 {
 soundPool.play(i, 1, 1, 0, 0, 1);//no idea why this is to be quite honest
 }
 
}
