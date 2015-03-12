package benchmark;

import com.alibaba.fastjson.JSON;
import java.io.IOException;

public class FastJsonTest implements Tester {

  public Timed serialize(Factura f) throws IOException {
    Timed t = new Timed();
    final long t0 = System.currentTimeMillis();
    String json = JSON.toJSONString(f);
    final long t1 = System.currentTimeMillis();
    t.time=t1-t0;
    t.obj=json;
    return t;
  }
  public Timed deserialize(String s) throws IOException {
    Timed t = new Timed();
    final long t0 = System.currentTimeMillis();
    Factura f = JSON.parseObject(s, Factura.class);
    final long t1 = System.currentTimeMillis();
    t.time=t1-t0;
    t.obj=f;
    return t;
  }
}
