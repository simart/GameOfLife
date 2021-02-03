import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons
private boolean[][] buffer;
private boolean running = true;

void setup ()
{
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_ROWS; c++) {
      buttons[r][c] = new Life(r, c);
      buffer[r][c] = buttons[r][c].getLife();
    }
}


public void draw ()
{
  background( 0 );
  if (running == false)
    return;
  copyFromButtonsToBuffer();
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++) {
      if (countNeighbors(r, c) == 3)
        buffer[r][c] = true;
      else if (countNeighbors(r, c) == 2 && buttons[r][c].getLife())
        buffer[r][c] = true;
      else
        buffer[r][c] = false;
      buttons[r][c].draw();
    }
  copyFromBufferToButtons();
}
public void keyPressed() {
  running = !running;
}
public void copyFromBufferToButtons() {
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c].setLife(buffer[r][c]);
}
public void copyFromButtonsToBuffer() {
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buffer[r][c] = buttons[r][c].getLife();
}
public boolean isValid(int r, int c)
{
  if (r>=0 && c>=0 && r< NUM_ROWS && c <NUM_COLS)
    return true;
  return false;
}
public int countNeighbors(int row, int col)
{
  int neighbors = 0;
  if (isValid(row-1, col-1) && buttons[row-1][col-1].getLife())
    neighbors++;
  if (isValid(row-1, col+1) && buttons[row-1][col+1].getLife())
    neighbors++;
  if (isValid(row+1, col-1) && buttons[row+1][col-1].getLife())
    neighbors++;
  if (isValid(row+1, col+1) && buttons[row+1][col+1].getLife())
    neighbors++;
  if (isValid(row, col+1) && buttons[row][col+1].getLife())
    neighbors++;
  if (isValid(row+1, col) && buttons[row+1][col].getLife())
    neighbors++;
  if (isValid(row, col-1) && buttons[row][col-1].getLife())
    neighbors++;
  if (isValid(row-1, col) && buttons[row-1][col].getLife())
    neighbors++;
  return neighbors;
}
public class Life
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random()<.5;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    //your code here
    alive = !alive;
  }
  public void draw () 
  {    
    if (alive != true)
      fill(0);
    else 
    fill(150);
    rect(x, y, width, height);
  }
  public boolean getLife()
  {
    return alive;
  }
  public void setLife(boolean living)
  {
    alive = living;
  }
}
