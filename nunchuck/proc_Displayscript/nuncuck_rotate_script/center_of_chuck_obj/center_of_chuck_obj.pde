PShape chuck_mod;
PImage bg;
float r, ry, rx, rz;
   
public void setup() 
{
  size(480, 300, P3D);
  frameRate(5);
  bg = loadImage("WII Wallpaper.png");
  bg.resize(480, 300);
  chuck_mod = loadShape("wii_nunchuck.obj");
  r = 0.0;
  ry = 0.0;
  rx = 0.0;
  rz = 0.0;
}

public void draw() 
{
   
  background(bg); 
  //lights();  
  ambientLight(102, 102, 102);
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, 0, 0, -1);
 // specular(255, 255, 255);
 // emissive(255,255,255);
 // ambient(255,255,255);
  shininess(6.0);
  
  
  translate(width/2, height/2, 50);
  rotateZ(0);
  rotateY(PI);
  rotateX(r);
  scale(20.0);
  shape(chuck_mod);
  r+=0.2;  
  
  
}