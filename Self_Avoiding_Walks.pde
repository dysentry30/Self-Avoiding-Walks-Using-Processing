// Created by Bagas Satria Nurwinanto
// 30 June 2021

int cols = 0, rows = 0, spacing = 20, x, y, walkers;
int millis;
boolean[][] grid;
void setup() {
  size(400, 400);
  // Initialize cols and rows depends on width and height
  cols = height;
  rows = width;
  
  // Initialize the grids as a boolean
  grid = new boolean[cols][rows];
  
  // set all grid to false
  for (int i = 0; i < grid.length; i+=spacing) {
    for (int j = 0; j < grid.length; j+= spacing) {
      grid[i][j] = false;
    }
  }

  // initialize where to start 
  x = cols / 2;
  y = rows / 2;
  grid[x][y] = true;

  // initialize the background desktop
  background(0);

  // make the walkers to center of the canvas
  translate(spacing * 0.5, spacing * 0.5);

  // this variable is used for checking if the algorithm work in a short time
  millis = millis();
}

void draw() {
  //frameRate(floor(400 / 60));
  
  // Saving x and y to prevX and prevY
  int prevX = x;
  int prevY = y;
  
  // open the shape using for vertex etc in Processing
  beginShape();
  
  // Set stroke to white and the weight 
  stroke(255);
  strokeWeight(1);
  
  // Set fill to white and litle bit of transparency
  fill(255, 20);


  // make a random turn 
  walkers = floor(random(0, 5));
  switch(walkers) {
  case 1 : 
    {
      // set the walkers to right
      x = x + spacing;
      break;
    }
  case 2 : 
    {
      // set the walkers to left
      x = x - spacing;
      break;
    }
  case 3 : 
    {
      // set walkers to down
      y = y + spacing;
      break;
    }
  case 4 : 
    {
      // Set the walkers to up
      y = y - spacing;
      break;
    }
  }

  // this used to not exeeced from the maximum amount
  // constraint(value, min, max);
  x = constrain(x, 0, cols - spacing);
  y = constrain(y, 0, rows - spacing);
  
  // initialize x and y because i add the spacing to the walkers 
  int xPlusSpacing = x + spacing;
  int xMinusSpacing = x - spacing;
  int yPlusSpacing = y + spacing;
  int yMinusSpacing = y - spacing;

  // if x and y not exceeded the edges and the grid is false
  if ((xPlusSpacing < rows && xMinusSpacing > 0) && (yPlusSpacing < cols && yMinusSpacing > 0) && grid[x][y] == false) {
  
    // set to true
    grid[x][y] = true;
    
    // draw a line between previous X and Y to X and Y
    vertex(prevX, prevY);
    vertex(x, y);
    
    // draw ellipse
    ellipse(x, y, spacing / 2, spacing / 2);
  } else {
    // set current X and Y to previous X and Y. so it not checking the up, down, left and right from current position if the grid is true and not exceeded the edges
    x = prevX;
    y = prevY;
    
    // set x and y spacing for checking grid
    xPlusSpacing = x + spacing;
    xMinusSpacing = x - spacing;
    yPlusSpacing = y + spacing;
    yMinusSpacing = y - spacing;

    // checking the up, down, left and right from the lastest position
    // NOTE when the walkers is stuck on the edges it can't detect the edges condition so this condition is running if up, down, left and right is true
    if ((grid[xPlusSpacing][y] == true && grid[xMinusSpacing][y] == true && grid[x][yPlusSpacing] == true && grid[x][yMinusSpacing] == true) || ((xPlusSpacing > rows || xMinusSpacing < 0) || (yPlusSpacing > cols || yMinusSpacing < 0))) {
      fill(255);
      textSize(15);
      textAlign(CENTER);
      textSize(15);
      // Showing text to canvas 
      text("algorithm takes " + (millis() - millis) + "ms to finish", width / 2, height - 10);
      
      // draw function can't run again
      noLoop();
    }
  } 
  // closed the shape
  endShape();
}
