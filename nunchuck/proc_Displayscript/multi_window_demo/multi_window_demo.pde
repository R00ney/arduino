

import javax.swing.*; 
SecondApplet s;
void setup() {
  size(640, 480);
  PFrame f = new PFrame(width, height);
  frame.setTitle("first window");
  f.setTitle("second window");
  fill(0);
}
void draw() {
  background(255);
  ellipse(mouseX, mouseY, 10, 10);
  s.setGhostCursor(mouseX, mouseY);
}
public class PFrame extends JFrame {
  public PFrame(int width, int height) {
    setBounds(100, 100, width, height);
    s = new SecondApplet();
    add(s);
    s.init();
    show();
  }
}
public class SecondApplet extends PApplet {
  int ghostX, ghostY;
  public void setup() {
    background(0);
    noStroke();
  }

  public void draw() {
    background(50);
    fill(255);
    ellipse(mouseX, mouseY, 10, 10);
    fill(0);
    ellipse(ghostX, ghostY, 10, 10);
  }
  public void setGhostCursor(int ghostX, int ghostY) {
    this.ghostX = ghostX;
    this.ghostY = ghostY;
  }
}


//================================================================================================================
//
//
//import g4p_controls.*;
////import guicomponents.*;
////import processing.video.*;
//
//private GWindow w1;
//private GWindow w2;
//
////Capture video;
//
//PImage sorted;
//PImage imgdif; // image with pixel thresholding
//
//GWinData data;
////MyWinData data;
//
//void setup(){
//
//  size(640, 480,P2D); // Change size to 320 x 240 if too slow at 640 x 480
//
//  // Uses the default video input, see the reference if this causes an error
////  video = new Capture(this, 640, 480, 24);
////  numPixels = video.width * video.height;
//
//    data = new GWinData();
////  data = new MyWinData();
//
//  w1 = new GWindow(this, "TEST", 0,0, 640,480, true, P2D);
//  w1.isAlwaysOnTop();
//  w1.addData(data);
////  w1.addDrawHandler(this, "Window1draw");
//
//  w2 = new GWindow(this, "TEST", 640,0 , 640,480, true, P2D);
//  w2.isAlwaysOnTop();
//  w2.addData(data);
////  w2.addDrawHandler(this, "Window2draw");
//
////  loadColors("64rev.csv");
////  colorlength = mycolors.length;
////  distances = new float[colorlength];
//
//  //noCursor(); 
//  frameRate(30);
//}
//
//int col = 0;
//void draw()
//{
////    if (video.available()) 
////    {
////      background(0);
////      video.read();
////
////      image(video,0,0);
////      loadPixels();
////
////      imgdif = get(); // clones the last image drawn to the screen v1.1     
////      sorted = get();
////      /// Removed a lot of code here that did the processing
////
////      // hand data to our data class to pass to other windows
////      data.sortedimage = sorted;
////      data.difimage = imgdif;
////
////    }
//  w1.setVisible(true);
//  w1.setBackground(col);
//  w2.setVisible(true);
//  w2.setBackground(abs(255-col));
//
//  col=+1;
//  if(col>255) col = 0;
//}
//
////class MyWinData extends GWinData {
////   public PImage sortedimage; 
////   public PImage difimage;
////
////   MyWinData(){
////      sortedimage = createImage(640,480,RGB); 
////      difimage = createImage(640,480,RGB);
////    }
////}
////
////
////public void Window1draw(GWinApplet a, GWinData d){
////  MyWinData data = (MyWinData) d;
////  a.image(data.sortedimage, 0,0);
////}
////
////
////public void Window2draw(GWinApplet a, GWinData d){
////  MyWinData data = (MyWinData) d;
////  a.image(data.difimage,0,0);
////}
