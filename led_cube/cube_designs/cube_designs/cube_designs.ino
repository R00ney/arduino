/*
  3x3x3 LED cube
 */

//intializing and declaring layers
int layer[3]={
  A1,A2,A4};
//initializing and declaring leds, bottom right is led[0]
int led[9]={
  2,4,A5,6,5,A0,10,7,11};

int time = 1500;


void setup() {
  //setting leds to ouput  
  for(int i = 0; i<9; i++)
  {
    pinMode(led[i], OUTPUT);
  }

  //setting layers to output
  for(int i = 0; i<3; i++)
  {
    pinMode(layer[i], OUTPUT);
  }

}
//++++++++++++++MAIN FUNCTION+++++++++++
void loop() {
  
  for(int j=0; j<=6;  j++){
     face(j);
     delay(time);
  }   
  
}



//+++++++++FUNCTIONS++++++++++

/////////turn all off
void turnEverythingOff()
{
  for(int i = 0; i<9; i++)
  {
    digitalWrite(led[i], LOW);
  }
  for(int i = 0; i<3; i++)
  {
    digitalWrite(layer[i], HIGH);
  }
}

/* Side indices
*    bottom= 1
*    right = 2
*    front = 3
*    left  = 4
*    back  = 5
*    top   = 6
*   default is center LED on
*/
void face(int side)
{
 turnEverythingOff();
 switch (side){
   case 1:  
     bottom();
     break;
   case 2:
     right();
     break;
   case 3:
     front();
     break;
   case 4:
     left();
     break;
   case 5:
     back();
     break;
   case 6:
     top();
     break;
   default:
     center();
     break;  
 }
    
  
}
//=================================================================

void center()
{
  digitalWrite(led[4], HIGH);
  digitalWrite(layer[1], LOW);
}

void bottom()
{
  for(int i = 0; i<9; i++)
  {
    digitalWrite(led[i], HIGH);
  }
  digitalWrite(layer[0], LOW);
  digitalWrite(layer[1], HIGH);
  digitalWrite(layer[2], HIGH);
}


void right()
{
  for(int i = 0; i<9; i=i+3)
  {
    digitalWrite(led[i], HIGH);
  }
  for(int i = 0; i<3; i++)
  {
    digitalWrite(layer[i], LOW);
  }
}
  
void front()
{
  for(int i = 0; i<3; i=i+1)
  {
    digitalWrite(led[i], HIGH);
  }
  for(int i = 0; i<3; i++)
  {
    digitalWrite(layer[i], LOW);
  }
}  
  
void left()
{
  for(int i = 2; i<9; i=i+3)
  {
    digitalWrite(led[i], HIGH);
  }
  for(int i = 0; i<3; i++)
  {
    digitalWrite(layer[i], LOW);
  }
}

void back()
{
  for(int i = 6; i<9; i=i+1)
  {
    digitalWrite(led[i], HIGH);
  }
  for(int i = 0; i<3; i++)
  {
    digitalWrite(layer[i], LOW);
  }
}

void top()
{
  for(int i = 0; i<9; i++)
  {
    digitalWrite(led[i], HIGH);
  }
  digitalWrite(layer[0], HIGH);
  digitalWrite(layer[1], HIGH);
  digitalWrite(layer[2], LOW);
}

//=================================================================

void iterate()
{
  turnEverythingOff();
  
  for(int j=0; j<3; j++){
    turnEverythingOff();
    digitalWrite(layer[j], LOW);  
    for(int i=0; i<9; i++){  
      digitalWrite(led[i], HIGH);  
      delay(time);
    }
  }
  
  
  delay(time);

}

void wink()
{
   digitalWrite(layer[1], HIGH);
  digitalWrite(layer[2], HIGH);  
  digitalWrite(led[0], HIGH);   
  delay(2*time);
    
  digitalWrite(led[0], LOW); 
  delay(1*time); 
}
