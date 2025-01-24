class Grid
{
  int weight;
  
  Grid(int weight)
  {
    this.weight = weight;
  }
  
  void draw()
  {
    strokeWeight(2);
    for (int x = 0; x < divisions; x++)
      line(x * (width / divisions), 0, x * (width / divisions), height);
    for (int x = 0; x < divisions; x++)
      line(0, x * (height / divisions), width, x * (height / divisions));
  }
}
