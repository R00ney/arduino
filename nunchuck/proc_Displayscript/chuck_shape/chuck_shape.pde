/*
* Neal O'Hara May 2015
* demo to construct animated drawing of nunchuck
*/

//for second frame
import javax.swing.*; 
SecondApplet s;

void setup()
{
  size(200, 200, P3D);
  colorMode(RGB,1);
  background(1);
  frameRate(30);
  PFrame f = new PFrame(width, height);
  frame.setTitle(" roll pitch yaw");
  f.setTitle(" buttons  joystick");
  frame.setBounds(300, 100, width, height);
}


//angles to rotate
  float ang1 =0;
  float ang2 = 0;
  float ang3 = 0;

// loop drawing function  
void draw()
{
 background(1);
 //handle rotation 
 translate(width/2, height/2, -200);
 rotateY(ang1);
 rotateX(ang2);
 rotateZ(ang3); 
 
  draw_nunchuck();

 // s.setState(true, false, 0, 0);
 
 inc_ang();  //for demoing nunchuck rotate

} //end draw

//======================================================================
// SecondApplet features
public class PFrame extends JFrame {
  public PFrame(int width, int height) {
    setBounds(100, 100, width, height);
    s = new SecondApplet();
    add(s);
    s.init();
    show();
  }
}

public class SecondApplet extends PApplet {
  boolean zPress, cPress;
  int joyX, joyY;
  public void setup() {
    background(0);
    colorMode(RGB,1);
  }

  public void draw() {
    background(1);
    buttC(cPress);
    buttZ(zPress);
    joystick( joyX, joyY);
  }
  
  public void  setState(boolean zPress, boolean cPress,  int joyX, int joyY)
  {
    this.zPress = zPress;
    this.cPress = cPress;
    this.joyX = joyX;
    this.joyY = joyY;
    
  }

  void buttC( boolean pressed)
  {
    int h = 30;
    int w = 40;
    
    strokeWeight(2);
    stroke(0,0,0);
    
    if(pressed)
      fill(1,1,0);
    else
      fill(1,1,1);
    
    ellipse( width/4, height*1/4, w, h);
    
    fill(0, 1, 0.25);
    textSize(20);
    text("C", width/4 -5, height*1/4 +5);
  }
  
  void buttZ( boolean pressed)
  {
    int w = 60;
    int h = 40;
    strokeWeight(2);
    stroke(0,0,0);
    
    if(pressed)
      fill(1,1,0);
    else
      fill(1,1,1);
    
    rect( width/4 - w/2, height*3/4 - h/2, w, h, 6);
    
    fill(0, 1, 0.25);
    textSize(20);
    text("Z", width/4 -5, height*3/4 + 5 );
  }
  
  void joystick(int x, int y)
  {  
    //center point c & y
    int cpx = width*3/4;
    int cpy = height*2/4;
    
    strokeWeight(2);
    stroke(1,0,0); 
    fill( 1,1,1);
    polygon( cpx, cpy, width/5, 8);
    
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

//======================================================================

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

//===============================================================================================


//iteratively increment the angles for the y,x,z axis
void inc_ang()
{
  ang1+=PI/120; //for rotation y
 if(ang1 >= 2*PI){
     ang1 = 2*PI;
     ang2 +=PI/120; //for rotation x
 }
 if(ang2 >= 2*PI){
     ang2 = 2*PI;
     ang3 +=PI/120; //for rotation z
 }
 if(ang3 > 2*PI){
    ang1 = 0; 
    ang2 = 0;
    ang3 = 0;
 } 
}
