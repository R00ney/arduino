//Neal O'Hara   May 2015
// wii nunchuck code
// nunchuck class
// demonstrates the roll and pitch in one window
// and the z, c, and joystick in another
// and the x, y, z accell in another




//for second frame
import javax.swing.*; 
SecondApplet s;


//for serial stuff
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
int sensorCount = 9;                     // number of values to expect (roll, pitch, aX, aY, aZ, jX, jY, then Z, C)

import controlP5.*;    // see https://github.com/sojamo/controlp5 for more info
    ControlP5 cp5;     //The startup GUI for choosing correct serial port
    DropdownList d1;
    boolean serialOpen = false;
    
import processing.serial.*;
Serial myPort;                // The serial port

int BAUDRATE = 115200; 
char DELIM = ','; // the delimeter for parsing incoming data

WiiNunchuck chuck;


void setup()
{
  size(200, 200, P3D);
  colorMode(RGB,1);
  background(1);
  frameRate(30);
  
  chuck = new WiiNunchuck();
  
  PFrame f = new PFrame(width, height);
  frame.setTitle(" roll pitch yaw");
  f.setTitle(" buttons  joystick");
  frame.setBounds(300, 100, width, height);
  
    //bring up GUI for user to choose Serial port
  cp5 = new ControlP5(this);
  d1 = cp5.addDropdownList("SerialPorts").setPosition(20,20);
  customize(d1);
  
}


//angles to rotate
  float ang1 =0;
  float ang2 = 0;
  float ang3 = 0;

// loop drawing function  
void draw()
{
 background(1);
 if(serialOpen){
   boolean cPress, zPress;
   int xPos, yPos;
     
   //handle rotation 
   translate(width/2, height/2, -200);
   rotateY(ang1);
   rotateX(ang2);
   rotateZ(ang3); 
   
    draw_nunchuck();
  
    if(sensorValues[7] > 0.0)
      zPress = true;
    else
      zPress = false;
    
    if(sensorValues[8] > 0.0)
      cPress = true;
    else
      cPress = false;
    
    println(int(sensorValues[5] )- int(zeroJoyX));
    xPos = int(sensorValues[5] - zeroJoyX);
    yPos = int(-(sensorValues[6] - zeroJoyY));
    
    s.setState(zPress, cPress, xPos, yPos);
   
   inc_ang();  //for demoing nunchuck rotate
 }
 
} //end draw


//======================================================================
float zeroJoyX, zeroJoyY;
float zeroRoll, zeroTilt;
//if mousePressed, reset current zero settings of Nunchuck to calibrate
void mousePressed() {
  set_zeros();
}

void set_zeros()
{
  zeroRoll = sensorValues[0];
  zeroTilt = sensorValues[1];
  zeroJoyX = sensorValues[5];
  zeroJoyY = sensorValues[6];  
}

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


//=======================================================================================
//setup dropdown, open serial functions
float x, z;

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  int len = Serial.list().length;
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("Serial");
  for (int i=0;i<len;i++) {
    String next = Serial.list()[i];
    if( next.indexOf("USB") > 0 )   //only list availible USB ports
      ddl.addItem(next , i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}


void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("Chose Serial : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
    
      //Open Serial port
    //myPort = new Serial(this,Serial.list()[32], BAUDRATE);
    myPort = new Serial(this,Serial.list()[(int)theEvent.getGroup().getValue()], BAUDRATE);
    // clear the serial buffer:
    myPort.clear();
    serialOpen = true;
    println("Serial open");
    
    d1.hide(); //cp5.close(); //remove();
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}


//=======================================================================================
//parse nunchuck serial string 

float[] sensorValues = new float[sensorCount];  // array to hold the incoming values

boolean debug = false;
boolean first = true;  //first time, set zeros

void serialEvent(Serial myPort) {
  //if(debug) println("Reading Serial String");
  // read incoming data until you get a newline:
  String serialString = myPort.readStringUntil('\n');
  // if the read data is a real string, parse it:

  if (serialString != null) {
    //println(serialString);
    //println(serialString.charAt(serialString.length()-3));
    // println(serialString.charAt(serialString.length()-2));
    // split it into substrings on the DELIM character:
    String[] numbers = split(serialString, DELIM);
    // convert each subastring into an int
    if(debug) println("Parsing numbers of string");
    if(debug) println("num length " + numbers.length);
    if (numbers.length == sensorCount) {
      for (int i = 0; i < numbers.length; i++) {
        // make sure you're only reading as many numbers as
        // you can fit in the array:
        if (i < sensorCount-2) { //don't try to convert Z and C
          // trim off any whitespace from the substring:
          numbers[i] = trim(numbers[i]);
          sensorValues[i] =  float(numbers[i]);
        }
        else if( i == sensorCount -2){
          if(trim(numbers[i]).equals("Z")){ //Z
            sensorValues[i] = 1.0;
          }
          else {
            sensorValues[i] = 0.0;
          }       
        }
        else if( i == sensorCount - 1){
          if(trim(numbers[i]).equals("C")){ //C
            sensorValues[i] = 1.0;
          }
          else {
            sensorValues[i] = 0.0;
          }          
        }
        if(debug) print(" " +sensorValues[i]); 
        
      }//end for
        if(debug) println(" ");
      // Things we don't handle in particular can get output to the text window
//        print(serialString);
    
      if(first)
      {
        set_zeros();
        first = false;
      }  
    }//end if lenth equal num sensors
  }
}




//======================================================================================
// Nunchuck Class

public class  WiiNunchuck {
   int num_sensors = 9;
   int [] values;
   int [] zeros;
  public void init()
  {
   for(int i = 0; i < num_sensors; i++){
     values[i] = 0;
     zeros[i] = 0;  
   } 
   
  }//end init 
  
  public void setZeros()
  {
   for(int i = 0; i < num_sensors; i++){
     zeros[i] = values[i];  
   } 
  }
  
  public void sensorValue(int val, int i){
    values[i] = val;
  }
}



