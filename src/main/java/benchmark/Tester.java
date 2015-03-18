package benchmark;

import java.io.IOException;

public interface Tester<Serialized> {
  public Timed serialize(Factura f) throws IOException;
  public Timed deserialize(Serialized s) throws IOException;
}
