AssetManager assetManager = this.getAssets();//needed for sounds, has to be up in rank
SoundPool soundPool = new SoundPool(20, AudioManager.STREAM_MUSIC, 0);
public class Sounds
{
 int pew;


 
 public void setUp()
 {
 try { //loading these files can throw an exception and therefore you HAVE to have a way to handle those events
  pew = soundPool.load(assetManager.openFd("\\sounds\\pew.wav"), 0); //load the files
  } catch (IOException e) {
   e.printStackTrace(); //you can leave this empty...or use some other way to notify the user/developer something went wrong
  }
 }
 public  void play(int i)
 {
 soundPool.play(i, 1, 1, 0, 0, 1);//no idea why this is to be quite honest
 }
 
}
