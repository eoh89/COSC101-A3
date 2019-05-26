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
PShape[] asteroidShape = new PShape[astroNums];
float[] rotateSpeed = new float[astroNums];
float size = 50;
float[] destroyed = new float[astroNums];
float gainSpeed = 0;
float loseSpeed = 0;
float shipOffset = 42.5;
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
boolean alive=false;
float asteroidSide;
int time;
int time2;
int wait = 200;
int wait2 = 100;
boolean drawFlame = false;
int level = 1;
int levelSpeed = 1;
int lives = 3;
boolean start = true;

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
* Function: reset()
* Parameters: None
* Returns: Void 
* Desc: Function to reset the initial variables to start a fresh
        game
***************************************************************/
void reset() {
  alive = true;
  for(int i=0;i<destroyed.length;i++){
    destroyed[i] = 0;
  }
   shipCoord = new PVector(height/2, width/2);
   astroids = new PVector[astroNums];
   astroDirect = new PVector[astroNums];
   drawFlame = false;
   drift = false;
   lives = 3;
   loseSpeed = 0;
   gainSpeed = 0;
   start = true;
}


/**************************************************************
* Function: moveShip()
* Parameters: None
* Returns: Void 
* Desc: Function to move the ship based on direction, speed, and
        loops the screen if it goes off.
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
  
  /* If the function is in the drift stage of movement  
     ie. once the up button is done 
     Move based on a decreasing speed */
  if(drift) {
     shipCoord.x -= cos(driftDirection-shipOffset)*(loseSpeed);
     shipCoord.y -= sin(driftDirection-shipOffset)*(loseSpeed);
  }
 
  
  if(sUP){
     //move in the direction the ship is facing based of gainSpeed
     shipCoord.x -= cos(direction-shipOffset)*(gainSpeed);
     shipCoord.y -= sin(direction-shipOffset)*(gainSpeed);
  }
  
  if(sRIGHT){
    //rotate ship to the right by 0.05
    direction += 0.05;
  }
  
  if(sLEFT){
    //rotate ship to the left by 0.05
   direction -= 0.05;
  }
}

/**************************************************************
* Function: drawShots()
* Parameters: None
* Returns: Void 
* Desc: Function that draws the array of shots on the screen
***************************************************************/
void drawShots(){
   //draw points for each shot from spacecraft 
   //at location and updated to new location
}


/**************************************************************
* Function: drawAstroids()
* Parameters: None
* Returns: Void 
* Desc: Function that draws the astroids onto the game screen
***************************************************************/
void drawAstroids(){
  //Loop through all astroids
  for(int i=0;i<astroids.length;i++){
    //If the astroid has been destroyed
    if(destroyed[i] == 1) {
      //do nothing
    } 
    // If they are not spawned in yet
    else if(astroids[i] == null ){
      //Spawn an astroid and draw it
      spawnAsteroid(i);
      shape(asteroidShape[i], astroids[i].x, astroids[i].y);
    //If the astroid has gone off screen
    } else if (astroids[i].x > 900 || astroids[i].x < -100 || astroids[i].y < -100 || astroids[i].y > 900){
      //spawn a new astroid and draw it
      spawnAsteroid(i);
      shape(asteroidShape[i], astroids[i].x, astroids[i].y);
    // all other cases
    } else {
      //This will keep the asteroid moving
      astroids[i].add(astroDirect[i]);
      //This will draw a ellipse to the screen using the coordinates of the asteroid
      rotateSpeed[i] = random(0, 0.01);
      asteroidShape[i].rotate(rotateSpeed[i]);
      shape(asteroidShape[i], astroids[i].x, astroids[i].y);
    }
  }
}

/**************************************************************
* Function: nextLevel()
* Parameters: None
* Returns: Void 
* Desc: Changes the level speed based on what level it is
***************************************************************/
void nextLevel() {
  switch (level) {
    case 1:
      levelSpeed = 1;
      break;
    case 2:
      levelSpeed = 2;
      break;
    case 3:
      levelSpeed = 3;
      break;
    case 4:
      levelSpeed = 4;
      break;
    //This will be hard
    case 5:
      levelSpeed = 5;
      break;
    //You will not survive
    case 6:
      levelSpeed = 100;
      break;
  }
}

/**************************************************************
* Function: nextLife()
* Parameters: None
* Returns: Void 
* Desc: Once the ship has lost a life, reset the ship and astroids
        Note: This doesnt change count of astroids still in game,
              simply redraws current ones
***************************************************************/
void nextLife(){
  shipCoord = new PVector(height/2, width/2);
  astroids = new PVector[astroNums];
  astroDirect = new PVector[astroNums];
  loseSpeed=0;
  gainSpeed = 0;
  drift=false;
  
}

/**************************************************************
* Function: levelDone()
* Parameters: None
* Returns: Boolean (If level is done)
* Desc: Checks if all astroids are destroyed and returns if 
        they are or not
***************************************************************/
boolean levelDone() {
    //Loop through the destroyed astroids
    for(int i=0; i < destroyed.length; i++) {
     //if any have not been destroyed return false
     if(destroyed[i] == 0) {
       return false;
     } 
    }
    return true;
}


/**************************************************************
* Function: collisionDetection()
* Parameters: None
* Returns: Void 
* Desc: Checks collision of Ship with Astroids and also checks
        the shot with astroids and handles the cases appropriately
***************************************************************/
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
    
  //check if ship as collided wiht astroids
  for(int i=0; i < astroids.length; i++){
    /* 12 is Asteroid width/2 FIX THIS*/
    if(shipCoord.x - ship.width/2 < astroids[i].x + 30 && shipCoord.x + ship.width/2 > astroids[i].x - 30 && shipCoord.y - ship.height/2 < astroids[i].y + 30 && shipCoord.y + ship.height/2 > astroids[i].y - 30) {
      //Lose a life and progress to next life
      lives--;
      if(lives == 0) {
        //no longer alive
        alive = false;
      } else {
         //move to next life
         nextLife();
      }
    //Makes sure the array isn't continued to loop through due to destruction from nextLife()
    break;
    }
  }
}

/**************************************************************
* Function: increaseSpeed()
* Parameters: None
* Returns: Void 
* Desc: Increases the speed of the ship when velocity is to increase
***************************************************************/
void increaseSpeed() {
  //If up is pressed
  if(sUP) {
    //Ensure that we aren't drifting
    drift = false;
    //if the current time - the second timer is more than 2nd waiter
    if (millis() - time2 >= wait2) {
      //increase the speed by 0.2
      gainSpeed += 0.2;
      //make sure the speed doesn't exceed maxspeed
      if(gainSpeed >= maxSpeed) {
        gainSpeed = maxSpeed;  
      }
      //set the second timer to now
      time2 = millis();
    }
    //reset the loseSpeed 
    loseSpeed = 0;
  }
}

/**************************************************************
* Function: driftShip()
* Parameters: None
* Returns: Void 
* Desc: decrease the speed of the ship when in drift
***************************************************************/
void driftShip() {
  //if drifting
  if(drift){
    //make sure we aren't controlling the ship
    sUP = false;
    //if the current time - the timer is more than the waiter
    if (millis() - time >= wait) {
      //decrease speed
      loseSpeed -= 0.1;
      //when speed hits 0 stop drifting and don't go lower
      if(loseSpeed <= 0) {
         loseSpeed = 0;
         drift = false; 
      }
      //reset timer
      time = millis();
    } 
   //reset gainSpeed 
   gainSpeed = 0;
  }
}

/**************************************************************
* Function: draw()
* Parameters: None
* Returns: Void 
* Desc: Function that loops for every frame to draw things
***************************************************************/
void draw(){
  //Set black background 
  background(0);
  if(start) {
    textSize(100);
    text("ASTEROIDS", width/2 - 250, height/3);
    textSize(30);
    text("Press 'Space' to begin", width/2 - 175, height/2 + 60);
  }
  //If ship is still alive
  else {
    if(alive) {
    //Spin the ship based on direction
    pushMatrix();
    translate(shipCoord.x, shipCoord.y);
    rotate(direction);
    
    image(ship, -ship.width/2, -ship.height/2);
    //If the flame is to be drawn
    if(drawFlame) {
     //Rotate by PI and draw the flame at the back of the ship
     rotate(PI);
     image(flame, -flame.width/2, -flame.height*1.5); 
    }
      
    translate(20, 0); // Translate to default Polar Coordinate 0 radians
    
    //Pop the matrix
    popMatrix();
    
    //Call ship movement functions
    moveShip();
    increaseSpeed();
    driftShip();
  
    //Draw the shots
    drawShots();
   
    //Draw the Astroids
    drawAstroids();
    
    //Check for colissions
    collisionDetection();
   
  
    //If level is done
    if(levelDone()) {
      //increase level and move to next level
      level++;
      nextLevel();
    }
  } else {
    //Show game over screen
    textSize(50);
    text("GAME OVER", width/2 - 150, height/2);
    textSize(30);
    text("Your final score was: " + score, width/2 - 175, height/2 + 30);
    text("Press 'Space' to restart", width/2 - 175, height/2 + 60);
  }
  
  
  
  // draw score and lives
  textSize(20);
  text("Score: " + score, 20, 20);
  text("Lives", 20, 40);
  
  //draw images of ship to simulate amount of lives
  for(int i=0; i < lives; i++) {
   image(ship, 20+i*20, 45); 
  }
  }
}

/**************************************************************
* Function: keyPressed()
* Parameters: None
* Returns: Void 
* Desc: Checks key presses and handle them accordingly
***************************************************************/
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      //Set sUP to true and set speed values for gain
      sUP = true;
      drawFlame = true;
      drift = false;
      gainSpeed = loseSpeed + gainSpeed;
    }
    if (keyCode == RIGHT) {
      sRIGHT=true;
    }
    if (keyCode == LEFT) {
      sLEFT=true;
    }
  }
  if (key == ' ') {
    if(start) {
      start=false;
      alive = true;
    } else {
     if(alive) {
       //fire a shot
     } else {
       reset(); 
     }
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      //set speed values for continuous speed
      loseSpeed = gainSpeed;
      gainSpeed = loseSpeed;
      
      //Set the drift direction to current
      driftDirection = direction;
      
      //dont draw flame and sUp to false
      drawFlame = false;
      sUP=false;
      
      //set drift and time
      drift = true;
      time=millis();
    }
    if (keyCode == RIGHT) {
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      sLEFT=false;
    }
  }
}

/**************************************************************
* Function: spawnAstroid()
* Parameters: int (i) : Loop Number
* Returns: Void 
* Desc: Spawn an astroid 
***************************************************************/
void spawnAsteroid(int i) {
  //This creates two random floats depending on size of the screen
  astroRandom = new PVector(random(0, width), random(0, height));
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
  astroDirect[i] = new PVector(random(-levelSpeed, levelSpeed), random(-levelSpeed, levelSpeed));
  //This will draw a ellipse to the screen using the coordinates of the asteroid
  float rotation = 0.0;
  asteroidShape[i] = createShape();
  asteroidShape[i].beginShape();
  asteroidShape[i].noFill();
  asteroidShape[i].stroke(200, 200, 200);
  while (rotation < 2 * PI) {
    float x = cos(rotation) * size * random(0.8, 1.2);  //Casts a single ray outwards and places a vertex at a point
    float y = sin(rotation) * size * random(0.8, 1.2);  //on the ray (distance away from the origin is relative to the size)
    asteroidShape[i].vertex(x, y);
    rotation += PI / random(5, 10);
  }
  asteroidShape[i].endShape(CLOSE);
}
