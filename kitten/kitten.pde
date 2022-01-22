
PImage kitten;

void setup() {
  size(1500, 750);
  kitten = loadImage("kitten.jpg");
  kitten.filter(GRAY);
  image(kitten, 0, 0);
}

void draw() {
  kitten.loadPixels();
  
  for (int y = 0; y < kitten.height; y++) {
    for (int x = 0; x < kitten.width; x++) {      
      color pixel = kitten.pixels[index(x, y)];
      float red = red(pixel);
      float green = green(pixel);
      float blue = blue(pixel);
      
      int factor = 1;
      int newRed = round(factor * red / 255) * (255 / factor);
      int newGreen = round(factor * green / 255) * (255 / factor);
      int newBlue = round(factor * blue / 255) * (255 / factor);
      
      float errorRed = red - newRed;
      float errorGreen = green - newGreen;
      float errorBlue = blue - newBlue;
      
      applyErrorToPixel(x + 1, y, errorRed, errorGreen, errorBlue, 7 / 16f);
      applyErrorToPixel(x - 1, y + 1, errorRed, errorGreen, errorBlue, 3 / 16f);
      applyErrorToPixel(x, y + 1, errorRed, errorGreen, errorBlue, 5 / 16f);
      applyErrorToPixel(x +  1, y + 1, errorRed, errorGreen, errorBlue, 1 / 16f);
      
      kitten.pixels[index(x, y)] = color(newRed, newGreen, newBlue);
    }
  }
  
  kitten.updatePixels();
  image(kitten, 750, 0);  
}

void applyErrorToPixel(int x, int y, float errorRed, float errorGreen, float errorBlue, float errorFactor) {
  if (isOutOfBounds(x, y))
    return;
    
  color colorWithError = newColor(x, y, errorRed, errorGreen, errorBlue, errorFactor);
  kitten.pixels[index(x, y)] = colorWithError;
}

boolean isOutOfBounds(int x, int y) {
  if (x < 0 || x > kitten.width - 1)
    return true;
  if (y < 0 || y > kitten.height -1)
    return true;
    
  return false;
}

color newColor(int x, int y, float errorRed, float errorGreen, float errorBlue, float errorFactor) {
  int index = index(x, y);
  color currentColor = kitten.pixels[index];
  
  float red = red(currentColor) + errorRed * errorFactor;
  float green = green(currentColor) + errorGreen * errorFactor;
  float blue = blue(currentColor) + errorBlue * errorFactor;
  return color(red, green, blue);
}

int index(int x, int y) {
  return x + y * kitten.width;
}
