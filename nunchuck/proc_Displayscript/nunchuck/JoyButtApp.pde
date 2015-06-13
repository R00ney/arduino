//Neal O'Hara May 2015

//for Frame and PApplet
import javax.swing.*; 

//======================================================================
// JoyButtApplet features
public class JoyButtFrame extends JFrame {
  JoyButtApp s;
  
  public  JoyButtFrame( int w, int h) {
    setBounds( displayWidth/4, displayHeight/4, w, h);
    s = new JoyButtApp();
    add(s);
    s.init( );
    show();
    
  }

  public void setChuck(WiiNunchuck nextChuck){
    s.setChuck(nextChuck);
  }
}//end class RPFrame



public class JoyButtApp extends PApplet {
  WiiNunchuck myChuck;
  
  public void setup() {
    background(0);
    colorMode(RGB,1);
    
  }

  public void draw() {
    background(1);
    
    if( myChuck != null ){
      buttC();
      buttZ();
      joystick();
    }
  }
  
  public void setChuck(WiiNunchuck nextChuck){
     myChuck = nextChuck;  
  }
  
//  public void  setState(boolean zPress, boolean cPress,  int joyX, int joyY)
//  {
//    this.zPress = zPress;
//    this.cPress = cPress;
//    this.joyX = joyX;
//    this.joyY = joyY;
//    
//  }

  void buttC()
  {
    int h = 30;
    int w = 40;
    
    strokeWeight(2);
    stroke(0,0,0);
    
    if(myChuck.cPress)
      fill(1,1,0);
    else
      fill(1,1,1);
    
    ellipse( width/4, height*1/4, w, h);
    
    fill(0, 1, 0.25);
    textSize(20);
    text("C", width/4 -5, height*1/4 +5);
  }
  
  void buttZ()
  {
    int w = 60;
    int h = 40;
    strokeWeight(2);
    stroke(0,0,0);
    
    if(myChuck.zPress)
      fill(1,1,0);
    else
      fill(1,1,1);
    
    rect( width/4 - w/2, height*3/4 - h/2, w, h, 6);
    
    fill(0, 1, 0.25);
    textSize(20);
    text("Z", width/4 -5, height*3/4 + 5 );
  }
  
  void joystick()
  { 
    println(myChuck);
    println(myChuck.zeros[5]);
    int x = myChuck.values[5] - myChuck.zeros[5]; 
    int y = myChuck.values[6] - myChuck.zeros[6];
    //center point c & y
    int cpx = width*3/4;
    int cpy = height*2/4;
    
    strokeWeight(2);
    stroke(1,0,0); 
    fill( 1,1,1);
    polygon( cpx, cpy, width/5, 8);
    
    if( x > width/5)
      x = width/5;
    if( x < -width/5)
      x = -width/5;
    if( y > width/5)
      y = width/5;
    if( y < -width/5)
      y = -width/5;
      
    stroke(0,0,0);
    ellipse( x + cpx, y + cpy, 30, 30);
  }
  
  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

