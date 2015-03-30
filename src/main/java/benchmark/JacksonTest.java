package benchmark;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;

public class JacksonTest implements Tester<String> {

  public Timed serialize(Factura f) throws IOException {
    Timed t = new Timed();
    final long t0 = System.nanoTime();
    ByteArrayOutputStream bout = new ByteArrayOutputStream();
    new ObjectMapper().writeValue(bout, f);
    String json = new String(bout.toByteArray());
    final long t1 = System.nanoTime();
    t.time=t1-t0;
    t.obj=json;
    return t;
  }
  public Timed deserialize(String s) throws IOException {
    Timed t = new Timed();
    final long t0 = System.nanoTime();
    ByteArrayInputStream bin = new ByteArrayInputStream(s.getBytes());
    Factura f = new ObjectMapper().readValue(bin, Factura.class);
    final long t1 = System.nanoTime();
    t.time=t1-t0;
    t.obj=f;
    return t;
  }
}
