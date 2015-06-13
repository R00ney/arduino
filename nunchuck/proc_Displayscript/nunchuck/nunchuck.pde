//Neal O'Hara   May 2015
// wii nunchuck code
// nunchuck class
// demonstrates the roll and pitch in one window
// and the z, c, and joystick in another
// and the x, y, z accell in another


WiiNunchuck chuck;
WiiSerial myPort;

RPFrame rpf;
JoyButtFrame jba;

void setup()
{
  //frame.dispose(); //close extraneous "this" frame
  chuck = new WiiNunchuck();

  SFrame ser = new SFrame(this, 200, 200);
  ser.setTitle( "Serial Port");
  
  String n = null; //block until port name is valid
  while( (ser.getPort() == null) )
  {
     delay(200);  //delay lower freq of poll
  };
  
  String port = ser.getPort();
  myPort = new WiiSerial();
  
  myPort.open(this, port);

  rpf = new RPFrame( 200, 200);
  rpf.setTitle("Chuck Roll Pan");
  
//  jba = new JoyButtFrame( 200, 200);
//  jba.setTitle("Joystick Buttons ");
  

//  ser.close();
}



void draw()
{
  if( myPort.isOpen() ){
  //  jba.setChuck( chuck );
  

  }//end is open
}

//void serialEvent(Serial myPort ){
//  println(" ser activity");  
//}


char DELIM = ','; // the delimeter for parsing incoming data

void serialEvent(Serial myPort ){
  int sensorCount = chuck.getNumSensors();
  // read incoming data until you get a newline:
  String serialString = myPort.readStringUntil('\n');
  // if the read data is a real string, parse it:
  if (serialString != null) {
     // split it into substrings on the DELIM character:
    String[] numbers = split(serialString, DELIM);
    // convert each subastring into an int
    if (numbers.length ==  sensorCount ) {
      for (int i = 0; i < numbers.length; i++) {
        // make sure you're only reading as many numbers as
        // you can fit in the array:
        if (i < sensorCount-2) { //don't try to convert Z and C
          // trim off any whitespace from the substring:
          numbers[i] = trim(numbers[i]);
          chuck.setSensorValue( int(numbers[i]), i);
        }
//        else if( i == sensorCount -2){
//          if(trim(numbers[i]).equals("Z")){ //Z
//           chuck.setSensorValue( 1, i);
//          }
//          else {
//            chuck.setSensorValue( 0, i);
//          }       
//        }
//        else if( i == sensorCount - 1){
//          if(trim(numbers[i]).equals("C")){ //C
//            chuck.setSensorValue( 1, i);
//          }
//          else {
//            chuck.setSensorValue( 0, i);
//          }          
//        }
      }//end for
    // Things we don't handle in particular can get output to the text window
      print(serialString);
    }
  }//end if null
}
