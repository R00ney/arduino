//Neal O'Hara   May 2016
// wii nunchuck code
// nunchuck class
// demonstrates the roll and pitch with a chuck model,
// and the z, c, and joystick as highlight icons,
// and the x, y, z accell in a textbox

/*******************import**********************/

/*******************variables**********************/

PShape chuck_mod;  // object model
PImage bg;        //background image
float r = 0.0;    //radial temp var for turning model

/*******************initialization**********************/
void setup()
{
  size(480, 300, P3D);
  frameRate(30);
  bg = loadImage("WII Wallpaper.png");
  bg.resize(480, 300);
  chuck_mod = loadShape("wii_nunchuck.obj");

}


/*******************screen draw**********************/
int count = 0;      //for mock accel values
 boolean f = true;  //for mock button highlights
 int i = 30;        //for mock button highlights
 
void draw()
{
  int t;
  count++;
  
  background(bg); 
  //lights();  
  ambientLight(102, 102, 102);
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, 0, 0, -1);
 // specular(255, 255, 255);
 // emissive(255,255,255);
 // ambient(255,255,255);
  shininess(6.0);
  
   t = int(count/5);
   accel_text_box( str(t) + " " + str(t+1) + " " + str(t+2) );  
   
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
    r=0;
    rotateZ(PI);
    rotateX(PI/16*3);
    translate(-mouseX,-mouseY, 50);
    //translate(-mouseX+width/2,-mouseY+height/2, -200);
    scale(16.0);
    shape(chuck_mod);
  } 
  else {
    translate(width/2, height/2, 50);
    rotateZ(PI);
    rotateY(r);
    rotateX(PI/16*3);
    scale(16.0);
    shape(chuck_mod);
    r+=0.2;  
  }
  
}

/******************* accel_text_box **********************/
int MAX_LINES = 20;
int line_count = 0;
String [] lines = new String[MAX_LINES];

void accel_text_box( String new_line){
  int tmp_count = 0;
  
  rectMode(CENTER);
  fill(180);
  stroke(0);
  rect(width/8, height/2, width/16*3+20, height/4*3+5);
  
  
  if( line_count >= MAX_LINES){
    for(tmp_count=0; tmp_count<(MAX_LINES-1); tmp_count++){
      lines[tmp_count] = lines[tmp_count+1];
    }
    line_count = (MAX_LINES-1);
    lines[line_count] = new_line;
  }
  else {
    lines[line_count] = new_line;
  }
  
  
  textSize(12); 
  fill(255,0,100);
  textAlign(CENTER,CENTER);
  text(" X  Y  Z ", width/8, (height/8+10)-25 );
  fill(0);
  for(tmp_count=0; tmp_count<(line_count+1); tmp_count++){
    text(lines[tmp_count], width/8, (height/8+10)+11*tmp_count );
  }
  
  line_count++;
}

/******************* c_button **********************/
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



/******************* z_button **********************/
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



/******************* joystick **********************/
void joystick(int x, int y)
  { 
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
  