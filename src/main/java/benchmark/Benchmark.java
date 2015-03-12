package benchmark;
import com.google.gson.Gson;

public class Benchmark {

  static Factura create() {
    final long t0 = System.currentTimeMillis();
    final Factura f = new Factura();
    return f;
  }

  static Timed serialize(Factura f) {
    Timed t = new Timed();
    final long t0 = System.currentTimeMillis();
    String json = new Gson().toJson(f);
    final long t1 = System.currentTimeMillis();
    t.time=t1-t0;
    t.obj=json;
    return t;
  }
  static Timed deserialize(String s) {
    Timed t = new Timed();
    final long t0 = System.currentTimeMillis();
    Factura f = new Gson().fromJson(s, Factura.class);
    final long t1 = System.currentTimeMillis();
    t.time=t1-t0;
    t.obj=f;
    return t;
  }

  static void stat(Timed[] times) {
    long min=Long.MAX_VALUE;
    long max=-1;
    long sum=0;
    for (int i = 0; i < times.length; i++) {
      Timed t = times[i];
      if (t.time > max) max=t.time;
      if (t.time < min) min=t.time;
      sum += t.time;
    }
    System.out.println("MIN: " + min);
    System.out.println("MAX: " + max);
    System.out.println("AVG: " + (sum/times.length));
  }

  public static void main(String... args) {
    final Factura factura = create();
    Timed json = serialize(factura);
    System.out.println(json.obj);
    deserialize((String)json.obj);
    int times = 100;
    Timed[] encodings = new Timed[times];
    for (int i = 0; i < times; i++) {
      encodings[i] = serialize(factura);
    }
    Timed[] decodings = new Timed[times];
    for (int i = 0; i < times; i++) {
      decodings[i] = deserialize((String)encodings[i].obj);
    }
    System.out.println("Encoding times:");
    stat(encodings);
    System.out.println("Decoding times:");
    stat(decodings);
  }

}
