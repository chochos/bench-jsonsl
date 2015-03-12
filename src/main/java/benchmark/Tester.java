package benchmark;

import java.io.IOException;

public interface Tester {
  public Timed serialize(Factura f) throws IOException;
  public Timed deserialize(String s) throws IOException;
}
