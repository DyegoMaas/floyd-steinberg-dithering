
PImage kitten;

void setup() {
  size(1500, 750);
  kitten = loadImage("kitten.jpg");
  kitten.filter(GRAY);
  image(kitten, 0, 0);
}

void draw() {
  kitten.loadPixels();
  
  for (int x = 0; x < kitten.width; x++) {
    for (int y = 0; y < kitten.height; y++) {
      int index = x + y * kitten.width;
      
      color pixel = kitten.pixels[index];
      float red = red(pixel);
      float green = green(pixel);
      float blue = blue(pixel);
      
      int factor = 2;
      int newRed = round(factor * red / 255) * (255 / factor);
      int newGreen = round(factor * green / 255) * (255 / factor);
      int newBlue = round(factor * blue / 255) * (255 / factor);
      
      kitten.pixels[index] = color(newRed, newGreen, newBlue);    
    }
  }
  
  kitten.updatePixels();
  image(kitten, 750, 0);  
}
