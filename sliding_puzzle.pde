// 2, 4, 8, 16, 32, 64, 128...
int NUMBER_OF_PIECES = 16;

PImage source;
ArrayList<PVector> pieceOriginalPositions = new ArrayList<PVector>();
ArrayList<PVector> pieceCurrentPositions = new ArrayList<PVector>();
ArrayList<PImage> pieceImages = new ArrayList<PImage>();
int divisions;

boolean isSelected = false;
int selectedIndex = -1;

void setup() {
  size(514, 514);
  source = loadImage("https://placedog.net/512x512", "png");
  divisions = (int) sqrt(NUMBER_OF_PIECES);
  
  for (int x = 0; x < divisions; x++) {
    for (int y = 0; y < divisions; y++) {
      PVector pos = new PVector(x, y);
      pieceOriginalPositions.add(pos);
      pieceCurrentPositions.add(pos.copy());

      PImage img = createImage(width / divisions, height / divisions, RGB);
      img.copy(source,
               (int)pos.x * (width / divisions),
               (int)pos.y * (height / divisions),
               width / divisions, height / divisions,
               0, 0, width / divisions, height / divisions);
      pieceImages.add(img);
    }
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < pieceImages.size(); i++) {
    PVector cp = pieceCurrentPositions.get(i);
    image(pieceImages.get(i), (int)cp.x * (width / divisions), (int)cp.y * (height / divisions));
  }
  
  drawGrid(2);
}

void drawGrid(int weight) {
  strokeWeight(weight);
  for (int x = 0; x < divisions; x++) {
    line(x * (width / divisions), 0, x * (width / divisions), height);
    line(0, x * (height / divisions), width, x * (height / divisions));
  }
}

void mouseClicked() {
  for (int i = 0; i < pieceCurrentPositions.size(); i++) {
    PVector cp = pieceCurrentPositions.get(i);
    float px = cp.x * (width / divisions);
    float py = cp.y * (height / divisions);
    
    if (mouseX >= px && mouseX <= px + width / divisions &&
        mouseY >= py && mouseY <= py + height / divisions) {
      if (!isSelected) {
        selectedIndex = i;
        isSelected = true;
      } else {
        // Swap positions
        PVector temp = pieceCurrentPositions.get(i);
        pieceCurrentPositions.set(i, pieceCurrentPositions.get(selectedIndex));
        pieceCurrentPositions.set(selectedIndex, temp);
        isSelected = false;
        selectedIndex = -1;
      }
      break;
    }
  }
}

void keyPressed() {
  if (key == 's') {
    int quantity = pieceCurrentPositions.size() / 2;
    ArrayList<Integer> tempIndices = new ArrayList<Integer>();
    for (int i = 0; i < pieceCurrentPositions.size(); i++) tempIndices.add(i);

    for (int i = 0; i < quantity; i++) {
      int idx1 = tempIndices.remove((int)random(tempIndices.size()));
      int idx2 = tempIndices.remove((int)random(tempIndices.size()));
      
      PVector temp1 = pieceCurrentPositions.get(idx1);
      PVector temp2 = pieceCurrentPositions.get(idx2);
      pieceCurrentPositions.set(idx1, temp2);
      pieceCurrentPositions.set(idx2, temp1);
    }
  }
}
