package benchmark;

import java.io.*;

public class NativeTest implements Tester<byte[]> {

  public Timed serialize(Factura f) throws IOException {
    Timed t = new Timed();
    final long t0 = System.currentTimeMillis();
    final ByteArrayOutputStream bout = new ByteArrayOutputStream();
    final ObjectOutputStream oout = new ObjectOutputStream(bout);
    oout.writeObject(f);
    oout.flush();
    final byte[] buf = bout.toByteArray();
    final long t1 = System.currentTimeMillis();
    t.time=t1-t0;
    t.obj=buf;
    return t;
  }
  public Timed deserialize(byte[] s) throws IOException {
    Timed t = new Timed();
    final long t0 = System.currentTimeMillis();
    final ByteArrayInputStream bin = new ByteArrayInputStream(s);
    final ObjectInputStream oin = new ObjectInputStream(bin);
    try {
    Factura f = (Factura)oin.readObject();
    final long t1 = System.currentTimeMillis();
    t.time=t1-t0;
    t.obj=f;
    } catch (ClassNotFoundException ignore){}
    return t;
  }
}
