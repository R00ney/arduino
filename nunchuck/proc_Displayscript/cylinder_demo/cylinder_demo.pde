/*
* Neal O'Hara May 2015
* modified from the following
* https://processing.org/discourse/beta/num_1159147633.html
*/
/*
Simple Cylinder
Ira Greenberg, November 27, 2005
*/
import processing.opengl.*;

float radius = 40;
float ang = 0, ang2 = 0;
int pts = 120;
float depth = 60;

void setup(){
 //size(400, 400, OPENGL);
 size(200, 400, P3D);
 colorMode(RGB,1);
 background(0.25);
 fill(0.7);
 //smooth();  // comment out with P3D renderer
 noStroke();
 frameRate(30);
}

void draw(){
 background(0.25);
 directionalLight(0.65, 0.65, 0.77, -60, -60, -60);
 ambientLight(0.41, 0.41, 0.51);
 translate(width/2, height/4, -200);
 rotateY(ang2);
 rotateX(ang2*2);
 rotateZ(ang2);
 
 //body
 beginShape(QUAD_STRIP); 
 for (int i=0; i<=pts; i++){
   float  px = cos(radians(ang))*radius;
   float  py = sin(radians(ang))*radius;
   vertex(px, py, depth); 
   vertex(px, py, -depth); 
   ang+=360/pts;
 }
 endShape(); 
 
 //cap 1
 beginShape(POLYGON); 
 for (int i=0; i<=pts; i++){
   float  px = cos(radians(ang))*radius;
   float  py = sin(radians(ang))*radius;
   vertex(px, py, depth); 
   ang+=360/pts;
 }
 endShape(); 

 //cap2
 beginShape(POLYGON); 
 for (int i=0; i<=pts; i++){
   float  px = cos(radians(ang))*radius;
   float  py = sin(radians(ang))*radius;
   vertex(px, py, -depth); 
   ang+=360/pts;
 }
 endShape(); 
 
 ang2+=PI/120; //for rotation
}
