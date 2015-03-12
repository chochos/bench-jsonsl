package benchmark;
import com.google.gson.Gson;
import java.util.ArrayList;

public class Benchmark {

  static Factura create() {
    final long t0 = System.currentTimeMillis();
    final Factura f = new Factura();
    f.setNumero(666);
    f.setFecha(20150312);
    final Entidad src = new Entidad();
    final Domicilio d0 = new Domicilio();
    d0.setCalle("Calle");
    d0.setNumExt("1");
    d0.setNumInt("2");
    d0.setColonia("Polanco");
    d0.setMunicipio("Miguel Hidalgo");
    d0.setEstado("DF");
    d0.setCp("11800");
    d0.setPais("Mexico");
    src.setNombre("Red Hat, Inc.");
    src.setRfc("RHI123456ABC");
    src.setDomicilio(d0);
    final Entidad dst = new Entidad();
    final Domicilio d1 = new Domicilio();
    d1.setCalle("Amargura");
    d1.setNumExt("123");
    d1.setColonia("Del Carmen");
    d1.setMunicipio("Coyoacan");
    d1.setEstado("DF");
    d1.setCp("04100");
    d1.setPais("Mexico");
    dst.setNombre("Enrique Zamudio");
    dst.setRfc("EZL432143ZYX");
    dst.setDomicilio(d1);
    f.setAutor(src);
    f.setDestino(dst);
    final ArrayList<Item> items = new ArrayList<>(3);
    Producto p = new Producto();
    p.setNombre("Soporte Anual");
    p.setSku("12341234");
    p.setPrecio(50.0);
    Item item = new Item();
    item.setCantidad(1);
    item.setProducto(p);
    items.add(item);
    p = new Producto();
    p.setNombre("Licencia RHEL");
    p.setSku("12341111");
    p.setPrecio(200.0);
    item = new Item();
    item.setCantidad(2);
    item.setProducto(p);
    items.add(item);
    p = new Producto();
    p.setNombre("Playeras");
    p.setSku("43214321");
    p.setPrecio(00.0);
    item = new Item();
    item.setCantidad(1);
    item.setProducto(p);
    items.add(item);
    f.setItems(items);
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
