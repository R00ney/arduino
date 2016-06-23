PShape chuck_mod;
PImage bg;
float ry;
   
public void setup() 
{
  size(480, 300, P3D);
  frameRate(30);
  bg = loadImage("WII Wallpaper.png");
  bg.resize(480, 300);
  chuck_mod = loadShape("wii_nunchuck.obj");
  
}
 
 boolean f = true;
 int i = 30;
 
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
  
  i--;
  if( i == 0 ){
    i = 30;
    f = !f;  
  }
  c_button( f );
  z_button( !f );
  joystick( 5, 5);
  
  if(mousePressed) 
  {
    ry=0;
    rotateZ(PI);
    rotateX(PI/16*3);
    translate(-mouseX,-mouseY, 50);
    //translate(-mouseX+width/2,-mouseY+height/2, -200);
    scale(20.0);
    shape(chuck_mod);
  } 
  else {
    translate(width/2, height/2, 50);
    rotateZ(PI);
    rotateY(ry);
    rotateX(PI/16*3);
    scale(20.0);
    shape(chuck_mod);
    ry+=0.2;  
  }
  
  
}


void c_button(boolean pressed){
  if(pressed){
    fill(200,200,0);
  }
  else{
    fill(200,200,200);
  }
  ellipse(width/8*7, height/4*3, 50, 50 );
  fill(0,0,0);
  textAlign(CENTER, CENTER);
  textSize(26); 
  text("C", width/8*7, height/4*3 -3); 
  
}




void z_button(boolean pressed){
  if(pressed){
    fill(200,200,0);
  }
  else{
    fill(200,200,200);
  }
  rectMode(CENTER);
  rect(width/8*7, height/4*2, 55, 40, 5, 5, 20, 20);
  //ellipse(width/8*7, height/4*3, 50, 50 );
  fill(0,0,0);
  textAlign(CENTER, CENTER);
  textSize(26); 
  text("Z", width/8*7, height/4*2 -3); 
  
}




void joystick(int x, int y)
  { 
   // println(myChuck);
   // println(myChuck.zeros[5]);
   // int x = myChuck.values[5] - myChuck.zeros[5]; 
   // int y = myChuck.values[6] - myChuck.zeros[6];
   
    //center point c & y
    int cpx = width/8*7;
    int cpy = height*1/4;
    
    strokeWeight(2);
    stroke(0,0,0); 
    fill( 255,255,255);
    int rad_bound = width/14;
    polygon( cpx, cpy, rad_bound, 8);
    
    if( x >rad_bound)
      x = rad_bound;
    if( x < -rad_bound)
      x = -rad_bound;
    if( y > rad_bound)
      y = rad_bound;
    if( y < -rad_bound)
      y = -rad_bound;
      
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
  