//Neal O'Hara May 2015

//for Frame and PApplet
import javax.swing.*; 

//======================================================================
// RPApplet features
public class RPFrame extends JFrame {
  RollPanApp s;
  
  public  RPFrame( int w, int h) {
    setBounds( displayWidth/4, displayHeight/4, w, h);
    s = new RollPanApp();
    add(s);
    s.init( );
    show();
    
  }

}//end class RPFrame



public class RollPanApp extends PApplet {
  
  public void setup()
  {
    size(width, height, P3D);
    colorMode(RGB,1);
    background(1);
    frameRate(30);  
    
  }
  
  public void draw()
  {
    translate(width/2, height/2, -200);
   draw_nunchuck();
   
  }
  
  //=========================================================================
  
void draw_nunchuck(){
 float ang;
 float r = 30;
 int div = 70;
 
 fill(0.4);
 
  // front top
 beginShape();
 for (int i=0; i<=div; i++){
   ang= i*PI/div;
   float  px = r*cos(ang);
   float  py = 1.2*r*sin(ang);
   float  pz = 0;
   vertex(px, py, pz);
 }
 endShape();
 
   //front bottom
 beginShape();

 for (int i=0; i<=div; i++){
   ang= i*PI/div;
   float  px = 0.7*r*cos(ang);
   float  py = 1.0*r*sin(ang);
   float  pz =  -0.7*r - 0.4*r*sin(ang);
   vertex(px, py, pz);
 }
 endShape();
 
 //front sides
 beginShape(QUAD_STRIP);
 for (int i=0; i<=div; i++){
   ang= i*PI/div;
   float  px = r*cos(ang);
   float  py = 1.2*r*sin(ang);
   float  pz = 0;
   vertex(px, py, pz);
     px = 0.7*r*cos(ang);
     py = 1.0*r*sin(ang);
     pz =  -0.7*r - 0.4*r*sin(ang);
   vertex(px, py, pz);
 }
 endShape();
 

  // back top
 beginShape();
 for (int i=0; i<=div; i++){
   ang= i*PI/div;
   float  px = r*cos(ang);
   float  py = -4*r*sin(ang);
   float  pz = - 2*r*sin(ang);
   vertex(px, py, pz);
 }
 endShape();

  // back bottom
 beginShape();
 for (int i=0; i<=div; i++){
   ang= i*PI/div;
   float  px = 0.7*r*cos(ang);
   float  py = -3*r*sin(ang);
   float  pz = -0.7*r - 2*r*sin(ang);
   vertex(px, py, pz);
 }
 endShape(); 
  
  
    // back side
 beginShape(QUAD_STRIP);
 for (int i=0; i<=div; i++){
   ang= i*PI/div;
   float  px = r*cos(ang);
   float  py = -4*r*sin(ang);
   float  pz = - 2*r*sin(ang);
   vertex(px, py, pz);
     px = 0.7*r*cos(ang);
     py = -3*r*sin(ang);
     pz = -0.7*r - 2*r*sin(ang);
   vertex(px, py, pz);
 }
 endShape(); 
 
}
  
}//end RollPanApp


//======================================================================


