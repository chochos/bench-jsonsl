import jsonsl {
    ... 
}
import ceylon.collection{ArrayList}

Factura crear() => Factura {
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

class Stopwatch() {
    variable Integer t0 = system.nanoseconds;
    variable Integer t1 = t0;
    variable Boolean running = false;
    shared Stopwatch start() {
        running = true;
        t0 = system.nanoseconds;
        return this;
    }
    shared Stopwatch stop() {
        t1 = system.nanoseconds;
        running = false;
        return this;
    }
    shared Integer read => running then system.nanoseconds-t0 else t1-t0;
}

class SerializationResult(totalTime, addTime, serTime, serializedResult) {
    shared Integer totalTime;
    shared Integer addTime;
    shared Integer serTime;
    shared String serializedResult;
}

"Return the time it took to serialize an object, along with its serialized representation"
SerializationResult timeSerial(Factura f) {
  value totalTime = Stopwatch();
  value serTime = Stopwatch();
  value addTime = Stopwatch();
  totalTime.start();
  value ser = Serializer();
  addTime.start();
  ser.add(f);
  addTime.stop();
  serTime.start();
  value json = ser.json;
  serTime.stop();
  totalTime.stop();
  return SerializationResult(totalTime.read, addTime.read, serTime.read, json);
}

class DeserializationResult(totalTime, restored) {
    shared Integer totalTime;
    shared Factura restored;
}

DeserializationResult timeParse(String json) {
  value t0 = Stopwatch().start();
  value deser = Deserializer();
  value restored = deser.parse(json).first;
  t0.stop();
  assert(is Factura restored);
  return DeserializationResult(t0.read, restored);
}

void statSer({SerializationResult*} data) {
  assert(nonempty times = [ for (d in data) d.totalTime ]);
  print("MIN: ``min(times)/1_000_000.0``");
  print("MAX: ``max(times)/1_000_000.0``");
  print("AVG: ``sum(times)/data.size/1_000_000.0``");
  
  assert(nonempty sertimes = [ for (d in data) d.serTime ]);
  print("ser AVG: ``sum(sertimes)/data.size/1_000_000.0``");
  assert(nonempty addtimes = [ for (d in data) d.addTime ]);
  print("add AVG: ``sum(addtimes)/data.size/1_000_000.0``");
}

void statDeser({DeserializationResult*} data) {
    assert(nonempty times = [ for (d in data) d.totalTime ]);
    print("MIN: ``min(times)/1_000_000.0``");
    print("MAX: ``max(times)/1_000_000.0``");
    print("AVG: ``sum(times)/data.size/1_000_000.0``");
    
    //value sertimes = [ for (d in data) d.serTime ];
    //print("ser AVG: ``sum(sertimes)/data.size``");
    //value addtimes = [ for (d in data) d.addTime ];
    //print("add AVG: ``sum(addtimes)/data.size``");
}

shared void run() {
  value isJvm = runtime.name=="JVM";
  if (isJvm) {
    print("press enter");
    process.readLine();
  }
  value factura = crear();
  print(factura);
  value other = timeParse(timeSerial(factura).serializedResult).restored;
  compFacts(factura, other);
  //warmup
  variable value times = isJvm then 1000 else 50;
  print("Warmup...");
  for (i in 1..times) {
      value json = timeSerial(factura);
      timeParse(json.serializedResult);
  }
  print(timeSerial(factura).serializedResult);
  print("Done. Benchmarking...");
  //measure
  times = 100;
  print("Encoding ``times`` times");
  value encodeTimes = ArrayList<SerializationResult>(times);
  for (i in 1..times) {
      encodeTimes.add(timeSerial(factura));
  }
  print("Decoding ``times`` times");
  value decodeTimes = ArrayList<DeserializationResult>(times);
  for (i in encodeTimes) {
      decodeTimes.add(timeParse(i.serializedResult)); 
  }
  for (d in decodeTimes) {
    assert(d.restored.string == factura.string);
  }
  print("Encoding times:");
  statSer(encodeTimes);
  print("Decoding times:");
  statDeser(decodeTimes);
}
