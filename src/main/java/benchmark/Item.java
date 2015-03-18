package benchmark;

public class Item implements java.io.Serializable {
  private Producto producto;
  private int cantidad;

  public void setProducto(Producto p) { producto = p; }
  public Producto getProducto() { return producto; }
  public void setCantidad(int v) { cantidad = v; }
  public int getCantidad() { return cantidad; }
}
