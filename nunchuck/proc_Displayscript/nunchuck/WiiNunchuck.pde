//Neal O'Hara May 2015

public class  WiiNunchuck {
   int num_sensors = 9;  //default 9:  roll, pitch, xacc, yacc, zacc, xjoy, yjoy, Z, C
   int [] values;
   int [] zeros;
   boolean cPress, zPress;
  public void WiiNunchuck()
  {
   for(int i = 0; i < num_sensors; i++){
     values[i] = 0; 
   }
    setZeros(); 
   
  }//end init 
  
  public void setZeros()
  {
   for(int i = 0; i < num_sensors; i++){
     zeros[i] = values[i];  
   } 
   cPress = false;
   zPress = false;
  }
  
  public void setSensorValue(int val, int i){
    values[i] = val;
    if( i == 8){
      if(values[i] > 0)
        cPress = true;
      else
        cPress = false; 
    }
    if( i == 7){
      if(values[i] > 0)
        zPress = true;
      else
        zPress = false; 
    }
  }
  
  public int getValue(int i){
    if((i < num_sensors) && ( i >= 0)){
      return values[i];
    }
    else{
      return 0;  //ignore error that should not occur
    }
  }
  
  public int getZeros(int i){
    if((i < num_sensors) & ( i >= 0))
      return zeros[i];
    else
      return 0;  //ignore error that should not occur
  }
  
  public boolean isCpress(){
   return cPress; 
  }
  
  public boolean isZpress(){
   return zPress; 
  }
  
  public int getNumSensors(){
   return num_sensors; 
  }
}
