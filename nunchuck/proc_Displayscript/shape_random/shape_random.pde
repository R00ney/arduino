/*
* Neal O'Hara May 2015
* modified from the following
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
 
 //body1
 beginShape(QUAD_STRIP); 
 for (int i=0; i<=pts; i++){
   float  px = fx(ang);
   float  py = fy(ang);
   vertex(px, py, depth); 
   vertex(2*px, 2*py, 0); 
   ang+=360/pts;
 }
 endShape(); 
 
 
  //body2
 beginShape(QUAD_STRIP); 
 for (int i=0; i<=pts; i++){
   float  px = fx(ang);
   float  py = fy(ang);
   curveVertex(px, py, -depth); 
   curveVertex(2*px, 2*py, 0); 
   ang+=360/pts;
 }
 endShape(); 
 
 
//  //body2
// beginShape(QUAD_STRIP); 
// for (int i=0; i<=pts; i++){
//   float  px = fx(ang);
//   float  py = fy(ang); 
//   vertex(2*px, 2*py, 0); 
//   vertex(px, py, -depth); 
//   ang+=360/pts;
// }
// endShape(); 
// 
//   //body3
// beginShape(QUAD_STRIP); 
// for (int i=0; i<=pts; i++){
//   float  px = fx(ang);
//   float  py = fy(ang); 
//  vertex(px, py, -depth);
//  vertex(0.0*px, 0.0*py, -depth*2); 
//   ang+=360/pts;
// }
// endShape(); 
// 
// //cap 1
// beginShape(POLYGON); 
// for (int i=0; i<=pts; i++){
//   float  px = fx(ang);
//   float  py = fy(ang);
//   vertex(px, py, depth); 
//   ang+=360/pts;
// }
// endShape(); 

 //cap2
 beginShape(POLYGON); 
 for (int i=0; i<=pts; i++){
   float  px = fx(ang);
   float  py = fy(ang); 
   vertex(2*px, 2*py, -depth);
   ang+=360/pts;
 }
 endShape(); 
 
 ang2+=PI/120; //for rotation
}

float  fx(float ang)
{
  return cos(radians(ang))*(radius-radius/2*abs(sin(radians(ang))));
}

float fy(float ang)
{
    return sin(radians(ang))*(radius-radius/2*abs(sin(radians(ang))));
}

