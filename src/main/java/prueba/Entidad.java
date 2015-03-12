package prueba;

public class Entidad {
  private String nombre;
  private String rfc;
  private Domicilio domicilio;

  public void setNombre(String v) { nombre = v; }
  public String getNombre() { return nombre; }
  public void setRfc(String v) { rfc = v; }
  public String getRfc() { return rfc; }
  public void setDomicilio(Domicilio v) { domicilio = v; }
  public Domicilio getDomicilio() { return domicilio; }
}
