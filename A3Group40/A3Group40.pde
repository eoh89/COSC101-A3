/**************************************************************
* File: a3.pde
* Group: <Group members,group number>
* Date: 14/03/2018
* Course: COSC101 - Software Development Studio 1
* Desc: Astroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/

PImage ship; 
int astroNums=20;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums];
float speed = 0;
float maxSpeed = 4;
float radians=radians(270); //if your ship is facing up (like in atari game)
PVector shipCoord;
Float direction = 0.0;
ArrayList shots= new ArrayList();
ArrayList sDirections= new ArrayList();
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
int score=0;
boolean alive=true;
void setup(){
  size(800,800);
  
  ship = loadImage("ship.png");
  ship.resize(50, 0);
  shipCoord = new PVector(height/2, width/2);
  //initialise pvtecotrs 
  //random astroid initial positions and directions;
  //initialise shapes if needed
}

/**************************************************************
* Function: myFunction()

* Parameters: None ( could be integer(x), integer(y) or String(myStr))

* Returns: Void ( again this could return a String or integer/float type )

* Desc: Each funciton should have appropriate documentation. 
        This is designed to benefit both the marker and your team mates.
        So it is better to keep it up to date, same with usage in the header comment

***************************************************************/

void moveShip(){
  
  //this function should update if keys are pressed down 
     // - this creates smooth movement
  //update rotation,speed and update current location
  //you should also check to make sure your ship is not outside of the window
  if(sUP){
     shipCoord.x -= cos(direction-42.5)*1;
     shipCoord.y -= sin(direction-42.5)*1;
  }
  
  if(sDOWN){
     shipCoord.x += cos(direction-42.5) *1;
     shipCoord.y += sin(direction-42.5)*1;
  }
  
  if(sRIGHT){
    direction += 0.05;
  }
  
  if(sLEFT){
   direction -= 0.05;
  }
}
void drawShots(){
   //draw points for each shot from spacecraft 
   //at location and updated to new location
}

void drawAstroids(){
  //check to see if astroid is not already destroyed
  //otherwise draw at location 
  //initial direction and location should be randomised
  //also make sure the astroid has not moved outside of the window
    
}

void collisionDetection(){
 
  //check if shots have collided with astroids
  //check if ship as collided wiht astroids
}

void draw(){
  //Draw ship in coordinates
 
  background(0);
  
  //Spin the ship based on direction in radians
  pushMatrix();
  translate(shipCoord.x, shipCoord.y);
  rotate(direction);
  image(ship, -ship.width/2, -ship.height/2);
  translate(20, 0); // Translate to default Polar Coordinate 0 radians

  popMatrix();

  /*translate(shipCoord.x, shipCoord.y);
  rotate((float) 1 * direction.x);
 
  rotate((float) -1 * direction.x);
  translate(-shipCoord.x, -shipCoord.y);
  */
  
  //might be worth checking to see if you are still alive first
  moveShip();
  collisionDetection();
  drawShots();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  drawAstroids();
  // draw score
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=true;
    }
    if (keyCode == DOWN) {
      sDOWN=true;
    } 
    if (keyCode == RIGHT) {
      sRIGHT=true;
    }
    if (keyCode == LEFT) {
      sLEFT=true;
    }
  }
  if (key == ' ') {
    //fire a shot
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=false;
    }
    if (keyCode == DOWN) {
      sDOWN=false;
    } 
    if (keyCode == RIGHT) {
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      sLEFT=false;
    }
  }
}
