package benchmark;
import java.util.List;

public class Factura {
  private int numero;
  private Entidad autor;
  private Entidad destino;
  private int fecha;
  private List<Item> items;
  private double impuesto=16.00;
  private double descuento;

  public void setNumero(int n) { numero = n; }
  public int getNumero() { return numero; }
  public void setAutor(Entidad v) { autor = v; }
  public Entidad getAutor() { return autor; }
  public void setDestino(Entidad v) { destino = v; }
  public Entidad getDestino() { return destino; }
  public void setFecha(int v) { fecha = v; }
  public int getFecha() { return fecha; }
  public void setItems(List<Item> v) { items = v; }
  public List<Item> getItems() { return items; }
  public void setImpuesto(double v) { impuesto = v; }
  public double getImpuesto() { return impuesto; }
  public void setDescuento(double v) { descuento = v; }
  public double getDescuento() { return descuento; }
}
