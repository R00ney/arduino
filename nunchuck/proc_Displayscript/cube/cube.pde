/*
*  Based on example code from http://playground.arduino.cc/Main/WiiChuckClass
*  modified by Neal O'Hara  May 2015
*/
/**
 * wii controlled
 * RGB Cube.
 * 
 * The three primary colors of the additive color model are red, green, and blue.
 * This RGB color cube displays smooth transitions between these colors. 
 */

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


void setup() 
{ 
  
  size(200, 400, P3D); 
  noStroke(); 
  colorMode(RGB, 1); 
  
  //bring up GUI for user to choose Serial port
  cp5 = new ControlP5(this);
  d1 = cp5.addDropdownList("SerialPorts").setPosition(20,20);
  customize(d1);
  

} 


void draw() 
{ 
  
  if(serialOpen){
    background(0.5, 0.5, 0.45);
  
    animate_nunchuck();
    
    buttC(false);
    buttZ(true);
    joystick( 0, 0);
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
    ddl.addItem(Serial.list()[i], i);
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

boolean debug = true;

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
        print(serialString);
    }
  }
}

//====================================================================================
// functions for nunchuck draw features


void animate_nunchuck()
{
  pushMatrix(); 
  
    translate(width/2, height/4, -30); 
  
//    newXmag = mouseX/float(width) * TWO_PI;
//    newYmag = mouseY/float(height) * TWO_PI;
//  
//    float diff = xmag-newXmag;
//    if (abs(diff) >  0.01) { 
//      xmag -= diff/4.0; 
//    }
//  
//    diff = ymag-newYmag;
//    if (abs(diff) >  0.01) { 
//      ymag -= diff/4.0; 
//    }
  
  
  //  if ((sensorValues[1] > 15) && (sensorValues[1] < 165)) {
      z = sensorValues[0] / 180 * PI ;
      x = sensorValues[1] / 180 * PI;
   // }
  
     rotateZ(z); 
     rotateX(x); 
    scale(50);
    beginShape(QUADS);
  
    fill(0, 1, 1); 
    vertex(-1,  1,  1);
    fill(1, 1, 1); 
    vertex( 1,  1,  1);
    fill(1, 0, 1); 
    vertex( 1, -1,  1);
    fill(0, 0, 1); 
    vertex(-1, -1,  1);
  
    fill(1, 1, 1); 
    vertex( 1,  1,  1);
    fill(1, 1, 0); 
    vertex( 1,  1, -1);
    fill(1, 0, 0); 
    vertex( 1, -1, -1);
    fill(1, 0, 1); 
    vertex( 1, -1,  1);
  
    fill(1, 1, 0); 
    vertex( 1,  1, -1);
    fill(0, 1, 0); 
    vertex(-1,  1, -1);
    fill(0, 0, 0); 
    vertex(-1, -1, -1);
    fill(1, 0, 0); 
    vertex( 1, -1, -1);
  
    fill(0, 1, 0); 
    vertex(-1,  1, -1);
    fill(0, 1, 1); 
    vertex(-1,  1,  1);
    fill(0, 0, 1); 
    vertex(-1, -1,  1);
    fill(0, 0, 0); 
    vertex(-1, -1, -1);
  
    fill(0, 1, 0); 
    vertex(-1,  1, -1);
    fill(1, 1, 0); 
    vertex( 1,  1, -1);
    fill(1, 1, 1); 
    vertex( 1,  1,  1);
    fill(0, 1, 1); 
    vertex(-1,  1,  1);
  
    fill(0, 0, 0); 
    vertex(-1, -1, -1);
    fill(1, 0, 0); 
    vertex( 1, -1, -1);
    fill(1, 0, 1); 
    vertex( 1, -1,  1);
    fill(0, 0, 1); 
    vertex(-1, -1,  1);
  
    endShape();
  
    popMatrix();  
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
  
  ellipse( width/4, height*3/4, w, h);
  
  fill(0, 1, 0.25);
  textSize(20);
  text("C", width/4 -5, height*3/4);
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
  
  rect( width/4 - w/2, height*7/8 - h/2, w, h, 6);
  
  fill(0, 1, 0.25);
  textSize(20);
  text("Z", width/4 -5, height*7/8 );
}

void joystick(int x, int y)
{  
  //center point c & y
  int cpx = width*3/4;
  int cpy = height*3/4;
  
  strokeWeight(2);
  stroke(1,0,0); 
  fill( 1,1,1);
  polygon( cpx, cpy, 40, 8);
  
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




