
#include <math.h>

#include "Wire.h"
#include "WiiChuck.h"
//#include "nunchuck_funcs.h"

#define MAXANGLE 90
#define MINANGLE -90

#define debug false

unsigned long old_time;
unsigned long new_time;


WiiChuck chuck = WiiChuck();
int angleStart, currentAngle;
int tillerStart = 0;
double angle;

void setup() {
  //nunchuck_init();
  Serial.begin(115200);
  chuck.begin();
  chuck.update();
  chuck.calibrateJoy();
}


void loop() {
  delay(20);
  if(debug) new_time = millis();
  chuck.update(); 

  if(debug) Serial.print("roll ");
  Serial.print(chuck.readRoll());
  Serial.print(", ");
  if(debug) Serial.print("pitch ");  
  Serial.print(chuck.readPitch());
  Serial.print(", ");  
  
  if(debug) Serial.print("accX ");
  Serial.print((int)chuck.readAccelX()); 
  Serial.print(", ");  
  if(debug) Serial.print("accY ");
  Serial.print((int)chuck.readAccelY()); 
  Serial.print(", ");  
  
  if(debug) Serial.print("accZ ");
  Serial.print((int)chuck.readAccelZ()); 
  Serial.print(", "); 

  if(debug) Serial.print("joyX ");
  Serial.print(chuck.readJoyX());
    Serial.print(", ");
  if(debug) Serial.print("accY ");  
  Serial.print(chuck.readJoyY());
    Serial.print(", ");  

  if (chuck.buttonZ) {
     Serial.print("Z");
  } else  {
     Serial.print("-");
  }

    Serial.print(", ");  

//not a function//  if (chuck.buttonC()) {
  if (chuck.buttonC) {
     Serial.print("C");
  } else  {
    Serial.print("-");
  }


    if(debug) {  
      //print time diff of loop
     Serial.print(", dT ");
     old_time = millis();
     Serial.print( old_time - new_time);
    }

    Serial.println();
}
 
