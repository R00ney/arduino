//Neal O'Hara May 2015

import controlP5.*;    // see https://github.com/sojamo/controlp5 for more info
    
//for Frame and PApplet
import javax.swing.*; 

//======================================================================
// SerialApplet features
public class SFrame extends JFrame {
  SerialApp s;
  
  public SFrame( nunchuck topthread, int width, int height) {
    setBounds( displayWidth/2, displayHeight/2, 200, 100);
    s = new SerialApp();
    add(s);
    s.init( );
    show();
    
  }
  
  public String getPort()
  {
   return s.getPort(); 
  }
  
  public void hide(){
    s.hide(); 
   //this.setVisible(false); 
  }
  
  public void close()
  {
     s.exit();
     this.dispose(); 
  }
}


public class SerialApp extends PApplet {
  ControlP5 cp5;     //The startup GUI for choosing correct serial port
  DropdownList d1;
  String portName;
  
  public void setup() {
    colorMode(RGB,1);
    background(1);
     
    cp5 = new ControlP5( this );
    d1 = cp5.addDropdownList("SerialPorts").setPosition(20,20);
    customize(d1);
  }
  
  public void draw() {
    
  }
  
  //setup dropdown, open serial functions
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
  
  // listener for the dropdown
  void controlEvent(ControlEvent theEvent) {
    // DropdownList is of type ControlGroup.
    
    if (theEvent.isGroup()) {
      // check if the Event was triggered from a ControlGroup
      println("Chose Serial : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
      
        //pass on open Serial port
      portName =  Serial.list()[(int)theEvent.getGroup().getValue()];
      println( portName);
      
      d1.hide(); //cp5.close(); //remove();
    } 
    else if (theEvent.isController()) {
      println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    }
  }
  
  public String getPort()
  {
    return portName; 
  }
  
}



