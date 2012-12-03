public class Hallucinate extends PowerUp
{
  Hallucinate(int locX, int locY)
  {
    super(locX,locY);
    
  }
   void doEffect()
 {
   psychedelicMode=true;
 }
 void removeEffect()
 {
   psychedelicMode=false;
 }
  
}
