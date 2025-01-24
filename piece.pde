class Piece
{
  PImage img;
  PVector op, cp;

  Piece(PVector op)
  {
    this.op = op;
    cp = op;
    
    img = createImage(width / divisions, height / divisions, RGB);
    img.copy(source, (int)cp.x * (width / divisions), (int)cp.y * (height / divisions), width / divisions, height / divisions, 0, 0, width / divisions, height / divisions);
  }

  void draw()
  {
    image(img, (int)cp.x * (width / divisions), (int)cp.y * (height / divisions));
  }
}
