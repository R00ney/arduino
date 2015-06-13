//Neal O'Hara May 2015
import processing.serial.*;


public class WiiSerial{
  public Serial myPort;
  int BAUDRATE = 115200; 
  boolean open = false;
  String portName;
  WiiNunchuck chuck;
  
  public void setPort( String port)
  {
    portName = port;
  }
  
  public void open(nunchuck app1, String port){
    myPort = new Serial( app1, port, BAUDRATE);
    myPort.clear();
    open = true;
    println("Serial open");
    chuck = new WiiNunchuck();
  }
  
  public boolean isOpen(){
   return open; 
  }
  
  public Serial getSer(){
   return myPort; 
  }
  
}


