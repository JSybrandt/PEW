
public class Sounds
{
public int pew;


 
 public void setUp()
 {
 try { //loading these files can throw an exception and therefore you HAVE to have a way to handle those events
  pew = soundPool.load(assetManager.openFd("pew.ogg"), 0); //load the files
  } catch (IOException e) {
    print("OOOOPPPPPPPPPPPPPPPPPPPSSSSSSSSSSSSSSSS");
    e.printStackTrace(); //you can leave this empty...or use some other way to notify the user/developer something went wrong
  }
 }
 public  void play(int sound)
 {
 soundPool.play(sound, 1, 1, 0, 0, 1);//no idea why this is to be quite honest
 }
 
}