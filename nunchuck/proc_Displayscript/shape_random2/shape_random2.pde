/*
* Neal O'Hara May 2015
*/
import processing.opengl.*;

float ang1,ang2, ang3;

void setup(){
 //size(400, 400, OPENGL);
 size(200, 400, P3D);
 colorMode(RGB,1);
 background(0.25);
 fill(0.7);
 //smooth();  // comment out with P3D renderer
 noStroke();
 frameRate(30);
 
  ang1 = 0; 
  ang2 = 0;
  ang3 = 0;
  
}

void draw(){
 background(0.25);
 directionalLight(0.65, 0.65, 0.77, -60, -60, -60);
 ambientLight(0.41, 0.41, 0.51);
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
 
}

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







