/**************************************************************
* File: a3.pde
* Group: Esther Oh, Samuel Nelson, Jame Cameron ( Group 40 )
* Date: 14/03/2018
* Course: COSC101 - Software Development Studio 1
* Desc: Astroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/

PImage ship; 
PImage flame;
int astroNums=20;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums];
PVector astroRandom;
float[] destroyed = new float[astroNums];
float speed = 0;
boolean drift = false;
float driftDirection = 0;
float maxSpeed = 4;
float radians=radians(270); //if your ship is facing up (like in atari game)
PVector shipCoord;
Float direction = 0.0;
ArrayList shots= new ArrayList();
ArrayList sDirections= new ArrayList();
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
int score=0;
boolean alive=true;
float asteroidSide;
int time;
int waitIncrease = 50;
int waitDecrease = 200;
boolean drawFlame = false;
int level = 1;

void setup(){
  size(800,800);
  for(int i=0;i<destroyed.length;i++){
    destroyed[i] = 0;
  }
  flame = loadImage("flame.png");
  flame.resize(10, 0);
  
  
  ship = loadImage("ship.png");
  ship.resize(20, 0);
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
  
  //detect collision with walls and send it out its opposing wall if so
  if (shipCoord.x > width) {
      shipCoord.x = 0;
    }
    if(shipCoord.y > height) {
      shipCoord.y = 0; 
    }
     if (shipCoord.x < 0) {
      shipCoord.x = width;
    }
    if(shipCoord.y < 0) {
      shipCoord.y = height; 
    }
    
    
  //this function should update if keys are pressed down 
     // - this creates smooth movement
  //update rotation,speed and update current location
  //you should also check to make sure your ship is not outside of the window
  if(drift) {
     shipCoord.x -= cos(driftDirection-42.5)*(speed);
     shipCoord.y -= sin(driftDirection-42.5)*(speed);
  }
  if(sUP){
     shipCoord.x -= cos(direction-42.5)*(maxSpeed);
     shipCoord.y -= sin(direction-42.5)*(maxSpeed);
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
  for(int i=0;i<astroids.length;i++){
    // not spawned in yet
    if(astroids[i] == null){
      spawnAsteroid(i);
    //Has gone off screen
    } else if (astroids[i].x > 900 || astroids[i].x < -100 || astroids[i].y < -100 || astroids[i].y > 900){
      spawnAsteroid(i);
    // if nothing happened
    } else {
      //This will keep the asteroid moving
      astroids[i].add(astroDirect[i]);
      
      //This will draw a ellipse to the screen using the coordinates of the asteroid
      ellipse (astroids[i].x, astroids[i].y, 24, 24);
      //Fills the asteroid with white(This will probably change)
      fill(255);
    }
  }
}

void nextLevel() {
  
}

boolean levelDone() {
    for(int i=0; i < destroyed.length; i++) {
     if(destroyed[i] == 0) {
       return false;
     } 
    }
    return true;
}

void collisionDetection(){
 
  //check if shots have collided with astroids
  //Dont run, just a holder for the code
  if(false) {
    for(int i=0; i < astroids.length; i++) {
        if( false /*COLLISION HERE*/) {
          destroyed[i] = 1;
          score++;
        }
    }
    
  }
  
  System.out.println(astroids.length);
  
  //check if ship as collided wiht astroids
  for(int i=0; i < astroids.length; i++){
    /* 12 is Asteroid width/2 FIX THIS*/
    if(shipCoord.x - ship.width/2 < astroids[i].x + 12 && shipCoord.x + ship.width/2 > astroids[i].x - 12 && shipCoord.y - ship.height/2 < astroids[i].y + 12 && shipCoord.y + ship.height/2 > astroids[i].y - 12) {
          alive = false;
    }
  }
}

void driftShip() {
  if (millis() - time >= waitDecrease) {
    speed -= 0.1;
    if(speed <= 0) {
       drift = false; 
    }
    time = millis();
  } 
}

void draw(){
  //Draw ship in coordinates
  
  background(0);
  
  if(alive) {
    //Spin the ship based on direction
    pushMatrix();
    translate(shipCoord.x, shipCoord.y);
    rotate(direction);
    
    image(ship, -ship.width/2, -ship.height/2);
    
    if(drawFlame) {
     rotate(PI);
     image(flame, -flame.width/2, -flame.height*1.5); 
    }
      
    translate(20, 0); // Translate to default Polar Coordinate 0 radians
  
    popMatrix();
    
    //might be worth checking to see if you are still alive first
    moveShip();
    driftShip();
  
    drawShots();
    // draw ship - call shap(..) if Pshape
    // report if game over or won
    drawAstroids();
    collisionDetection();
  
    //return if level is done or not
    if(levelDone()) {
      level++;
      nextLevel();
    }
  } else {
    textSize(50);
    text("GAME OVER", width/3, height/2);
  }
  
  
  // draw score
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      drawFlame = true;
      sUP=true;
      speed = 4;
      drift = false;
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
      driftDirection = direction;
      drawFlame = false;
      sUP=false;
      drift = true;
      time=0;
    }
    if (keyCode == RIGHT) {
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      sLEFT=false;
    }
  }
}

void spawnAsteroid(int i) {
  //This creates two random floats depending on size of the screen and a random speed variable
  astroRandom = new PVector(random(0, width), random(0, height), random(-3, 3));
  //This finds a random side to spawn from
  asteroidSide = Math.round(random(1, 4));
  if(asteroidSide == 1){
    //This will save the coordinates of a asteroid to the top of the screen
    astroids[i] = new PVector(astroRandom.x , 0);
  } else if (asteroidSide == 2) {
    //This will save the coordinates of a asteroid to the left of the screen
    astroids[i] = new PVector(0, astroRandom.y);
  } else if (asteroidSide == 3) {
    ////This will save the coordinates of a asteroid to the bottom of the screen
    astroids[i] = new PVector(astroRandom.x, 800);
  } else if (asteroidSide == 4) {
    //This will save the coordinates of a asteroid to the right of the screen
    astroids[i] = new PVector(800, astroRandom.y);
  }
  //This will set the speed and direction
  astroDirect[i] = new PVector(random(-4, 4), random(-4, 4));
  //This will draw a ellipse to the screen using the coordinates of the asteroid
  ellipse (astroids[i].x, astroids[i].y, 24, 24);
  //Fills the asteroid with white(This will probably change)
  fill(255);
}
