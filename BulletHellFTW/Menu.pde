  void Menu() {
    image(Menu, displayWidth/2, displayHeight/2);
    if(overRect(rectX, rectY, rectSize, rectSize) == true)
    {
      if(mousePressed == true)
      {
        playgame = !playgame;
      }
    }
  }
