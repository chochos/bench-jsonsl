package benchmark;

public class Domicilio implements java.io.Serializable {
  private String calle;
  private String numExt;
  private String numInt;
  private String colonia;
  private String municipio;
  private String estado;
  private String pais;
  private String cp;

  public void setCalle(String v) { calle = v; }
  public String getCalle() { return calle; }
  public void setNumExt(String v) { numExt = v; }
  public String getNumExt() { return numExt; }
  public void setNumInt(String v) { numInt = v; }
  public String getNumInt() { return numInt; }
  public void setColonia(String v) { colonia = v; }
  public String getColonia() { return colonia; }
  public void setMunicipio(String v) { municipio = v; }
  public String getMunicipio()  { return municipio; }
  public void setEstado(String v) { estado = v; }
  public String getEstado() { return estado; }
  public void setPais(String v) { pais = v; }
  public String getPais() { return pais; }
  public void setCp(String v) { cp = v; }
  public String getCp() { return cp; }
}
