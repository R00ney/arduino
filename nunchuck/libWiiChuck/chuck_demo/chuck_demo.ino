
#include <math.h>

#include "Wire.h"
#include "WiiChuck.h"
//#include "nunchuck_funcs.h"

#define MAXANGLE 90
#define MINANGLE -90


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
  new_time = millis();
  chuck.update(); 

  Serial.print("roll ");
  Serial.print(chuck.readRoll());
  Serial.print(", ");
  Serial.print("pitch ");  
  Serial.print(chuck.readPitch());
  Serial.print(", ");  
  
  Serial.print("accX ");
  Serial.print((int)chuck.readAccelX()); 
  Serial.print(", ");  
  Serial.print("accY ");
  Serial.print((int)chuck.readAccelY()); 
  Serial.print(", ");  
  
  Serial.print("accZ ");
  Serial.print((int)chuck.readAccelZ()); 
  Serial.print(", "); 

  Serial.print("joyX ");
  Serial.print(chuck.readJoyX());
    Serial.print(", ");
  Serial.print("accY ");  
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


    //print time diff of loop
   Serial.print(", dT ");
   old_time = millis();
   Serial.print( old_time - new_time);
   

    Serial.println();
}
 
