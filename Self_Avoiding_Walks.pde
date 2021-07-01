// Created by Bagas Satria Nurwinanto
// 30 June 2021

int cols = 0, rows = 0, spacing = 20, x, y, walkers;
int millis;
boolean[][] grid;
//HashMap<String, Integer> option = new HashMap();
boolean option;
void setup() {
  size(400, 400);
  cols = height;
  rows = width;
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

  translate(spacing * 0.5, spacing * 0.5);

  // this variable is used for Big O Notation
  millis = millis();
}

void draw() {
  //frameRate(floor(400 / 60));

  int prevX = x;
  int prevY = y;
  beginShape();
  stroke(255);
  strokeWeight(1);
  fill(255, 20);



  walkers = floor(random(0, 5));
  switch(walkers) {
  case 1 : 
    {
      x = x + spacing;
      break;
    }
  case 2 : 
    {
      x = x - spacing;
      break;
    }
  case 3 : 
    {
      y = y + spacing;
      break;
    }
  case 4 : 
    {
      y = y - spacing;
      break;
    }
  }

  //  if (grid[x + spacing][y] == false) {
  //    x = x + spacing;
  //  } else if (grid[x - spacing][y] == false) {
  //    x = x - spacing;
  //  } else if (grid[x][y + spacing] == false) {
  //    y = y + spacing;
  //  } else if (grid[x][y - spacing] == false) {
  //    y = y - spacing;
  //  }

  x = constrain(x, 0, cols - spacing);
  y = constrain(y, 0, rows - spacing);

  int xPlusSpacing = x + spacing;
  int xMinusSpacing = x - spacing;
  int yPlusSpacing = y + spacing;
  int yMinusSpacing = y - spacing;


  if ((xPlusSpacing < rows && xMinusSpacing > 0) && (yPlusSpacing < cols && yMinusSpacing > 0) && grid[x][y] == false) {
    grid[x][y] = true;

    vertex(prevX, prevY);
    vertex(x, y);
    ellipse(x, y, spacing / 2, spacing / 2);
  } else {
    x = prevX;
    y = prevY;
    xPlusSpacing = x + spacing;
    xMinusSpacing = x - spacing;
    yPlusSpacing = y + spacing;
    yMinusSpacing = y - spacing;

    if ((grid[xPlusSpacing][y] == true && grid[xMinusSpacing][y] == true && grid[x][yPlusSpacing] == true && grid[x][yMinusSpacing] == true) || ((xPlusSpacing > rows || xMinusSpacing < 0) || (yPlusSpacing > cols || yMinusSpacing < 0))) {
      fill(255);
      textSize(15);
      textAlign(CENTER);
      textSize(15);
      text("algorithm takes " + (millis() - millis) + "ms to finish", width / 2, height - 10);
      noLoop();
    }
  } 

  endShape();
}
