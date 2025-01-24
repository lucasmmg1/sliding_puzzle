// 2, 4, 8, 16, 32, 64, 128...
int NUMBER_OF_PIECES = 16;

PImage source;
ArrayList<Piece> pieces;
Grid grid;
int divisions;


String isSelected = "false";
Piece selectedPiece;

void setup()
{
  size(514, 514);
  
  source = loadImage("https://placedog.net/512x512", "png");
  divisions = (int)sqrt(NUMBER_OF_PIECES);
  
  pieces = new ArrayList<Piece>();
  for (int x = 0; x < divisions; x++)
    for (int y = 0; y < divisions; y++)
      pieces.add(new Piece(new PVector(x, y)));
      
  grid = new Grid(2);
}
void draw()
{
  background(0);
  
  for (int x = 0; x < pieces.size(); x++)
    pieces.get(x).draw();
    
  grid.draw();
}
void mouseClicked()
{ 
  switch (isSelected)
  {
    case "true":
      for (int x = 0; x < pieces.size(); x++)
      {
        Piece piece = pieces.get(x);
        if ((mouseX >= piece.cp.x * 128 && mouseX <= piece.cp.x * 128 + 128) && (mouseY >= piece.cp.y * 128 && mouseY <= piece.cp.y * 128 + 128))
        {
          isSelected = "false";
          PVector tmp = selectedPiece.cp;
          selectedPiece.cp = piece.cp;
          piece.cp = tmp;
        }
      }
      break;
      
    case "false":
      for (int x = 0; x < pieces.size(); x++)
      {
        Piece piece = pieces.get(x);
        if ((mouseX >= piece.cp.x * 128 && mouseX <= piece.cp.x * 128 + 128) && (mouseY >= piece.cp.y * 128 && mouseY <= piece.cp.y * 128 + 128))
        {
          isSelected = "true";
          selectedPiece = piece;
        }
      }
      break;
  }
}

void keyPressed()
{
  if (key == 's')
  {
    int quantity = pieces.size() / 2;
    ArrayList<Piece> temp = new ArrayList<Piece>(pieces);
    for (int x = 0; x < quantity; x++)
    {
      int piece_1 = (int)random(0, temp.size());
      temp.remove(piece_1);
      int piece_2 = (int)random(0, temp.size());
      temp.remove(piece_2);
      
      PVector temp_cep_1 = pieces.get(piece_1).cp;
      PVector temp_cep_2 = pieces.get(piece_2).cp;
      pieces.get(piece_1).cp = temp_cep_2;
      pieces.get(piece_2).cp = temp_cep_1;
    }    
  }
}
