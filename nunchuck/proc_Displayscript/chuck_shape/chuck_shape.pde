/*
* Neal O'Hara May 2015
* demo to construct animated drawing of nunchuck
*/

float ang1 =0;
float ang2 = 0;
 float ang3 = 0;;


void setup()
{
  size(200, 400, P3D);
  colorMode(RGB,1);
  background(1);
  //smooth();
  frameRate(30);
  
  draw_nunchuck();
  
  buttC(false);
  buttZ(true);
  joystick( 0, 0);
}


void draw()
{
 background(1);
 translate(width/2, height/4, -200);
 
 
  rotateY(ang1);
 rotateX(ang2);
 rotateZ(ang3);
 
 
  draw_nunchuck();
  
  
   ang1+=PI/120; //for rotation y
 
 if(ang1 >= 2*PI){
   ang1 = 2*PI;
   ang2 +=PI/120; //for rotation x
 }
 
 if(ang2 >= 2*PI){
   ang2 = 2*PI;
   ang3 +=PI/120; //for rotation x
 }
 
 if(ang3 > 2*PI){
  ang1 = 0; 
  ang2 = 0;
  ang3 = 0;
 }
 
  buttC(false);
  buttZ(true);
  joystick( 0, 0);
}




//======================================================================
//simple button functions

void draw_nunchuck(){
 float ang;
 float r = 30;
 int div = 70;
 
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
  
  ellipse( -width/2, height*2/4, w, h);
  
  fill(0, 1, 0.25);
  textSize(20);
  text("C", -width/2 -5, height*2/4);
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
  
  rect( -width/2 - w/2, height*3/4 - h/2, w, h, 6);
  
  fill(0, 1, 0.25);
  textSize(20);
  text("Z", -width/2 -5, height*3/4 );
}

void joystick(int x, int y)
{  
  //center point c & y
  int cpx = width*1/4;
  int cpy = height*3/4;
  
  strokeWeight(2);
  stroke(1,0,0); 
  fill( 1,1,1);
  polygon( cpx, cpy, 60, 8);
  
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

