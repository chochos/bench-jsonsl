package benchmark;

import com.alibaba.fastjson.JSON;
import java.io.IOException;

public class FastJsonTest implements Tester<String> {

  public Timed serialize(Factura f) throws IOException {
    Timed t = new Timed();
    final long t0 = System.nanoTime();
    String json = JSON.toJSONString(f);
    final long t1 = System.nanoTime();
    t.time=t1-t0;
    t.obj=json;
    return t;
  }
  public Timed deserialize(String s) throws IOException {
    Timed t = new Timed();
    final long t0 = System.nanoTime();
    Factura f = JSON.parseObject(s, Factura.class);
    final long t1 = System.nanoTime();
    t.time=t1-t0;
    t.obj=f;
    return t;
  }
}
