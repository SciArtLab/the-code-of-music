//a quick grid system to position elements on the screen
int x = 10;
int y = 10;


int col_w = 40;
int row_h = 14;
int pad = 4;


int x(int colNumber){
  return x + colNumber*col_w + (colNumber + 1)*pad;
}

int y(int rowNumber){
  return y + rowNumber*row_h + (rowNumber + 1)*pad;
}
