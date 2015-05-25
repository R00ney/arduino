

import javax.swing.*;         // for JFrame and PApplet
import controlP5.*;            // see https://github.com/sojamo/controlp5 for more info
import processing.serial.*;   //for serial


Nunchuck chuck;
void setup()
{
  chuck = new Nunchuck();
  chuck.init();
  
}

void draw()
{
  
  
}


//===================================================================================
// Nunchuck Class

public class Nunchuck {
  Serial myPort;                // The serial port
  
  public void init(){
    SerialApp  startSer = new SerialApp();
    startSer.setup();
    
  } 
  
}


//===================================================================================
//  Window Features


public class SerialApp extends PApplet {
  ControlP5 cp5;     //The startup GUI for choosing correct serial port
  DropdownList d1;
  boolean serialOpen = false;
  
  Serial myPort;                // The serial port
  int BAUDRATE = 115200; 
  char DELIM = ','; // the delimeter for parsing incoming data
  
  //setup dropdown, open serial functions
  float x, z;
  
  public void setup(){
    //  bring up GUI for user to choose Serial port
    cp5 = new ControlP5(this);
    d1 = cp5.addDropdownList("SerialPorts").setPosition(20,20);
    customize(d1);
  }
  
  public void draw(){
    
  }
  
  
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
  
}//end SerialApp



