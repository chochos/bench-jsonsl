import jsonsl {...}

Factura crear() {
  return Factura {
    numero=666;
    fecha=20150312;
    autor=Entidad{
      nombre="Red Hat, Inc.";
      rfc="RHI123456ABC";
      domicilio=Domicilio("Calle","1","2","Polanco","Miguel Hidalgo","DF","11800","Mexico");
    };
    destino=Entidad{
      nombre="Enrique Zamudio";
      rfc="EZL654321ABC";
      domicilio=Domicilio("Amargura","123",null,"Del Carmen","Coyoacan","DF","04100","Mexico");
    };
    items=[
      Item(Producto("Soporte Anual","12341234",50.00),1),
      Item(Producto("Licencia RHEL","12341111",200.00),2),
      Item(Producto("Playeras","43214321",20.00),1)
    ];
  };
}

"Return the time it took to serialize an object, along with its serialized representation"
[Integer, String] timeSerial(Factura f) {
  value t0 = system.milliseconds;
  value ser = Serializer();
  ser.add(f);
  value json = ser.json;
  value t1 = system.milliseconds;
  return [t1-t0, json];
}

[Integer, Factura] timeParse(String json) {
  value t0 = system.milliseconds;
  value deser = Deserializer();
  value restored = deser.parse(json).first;
  value t1 = system.milliseconds;
  assert(is Factura restored);
  return [t1-t0, restored];
}

void stat([[Integer,Anything]+] data) {
  value times = [ for (d in data) d[0] ];
  value tot   = sum(times);
  print("MIN: ``min(times)``");
  print("MAX: ``max(times)``");
  print("AVG: ``tot/data.size``");
}

shared void run() {
  value factura = crear();
  print(factura);
  //warmup
  value json = timeSerial(factura)[1];
  print(json);
  timeParse(json);
  value times = 100;
  print("Encoding ``times`` times");
  value encodeTimes = [ for (i in 1..times) timeSerial(factura) ];
  print("Decoding ``times`` times");
  value decodeTimes = [ for (i in encodeTimes) timeParse(i[1]) ];
  for (d in decodeTimes) {
    assert(d[1].string == factura.string);
  }
  print("Encoding times:");
  stat(encodeTimes);
  print("Decoding times:");
  stat(decodeTimes);
}
