import ceylon.json { parse }

shared void json() {
  print("Reading JSON string from file");
  assert(exists res = `module`.resourceByPath("json.txt"));
  value s=res.textContent();
  print(s);
  print("Parser Warmup...");
  value t0=system.nanoseconds;
  for (i in 1:1000) {
    parse(s);
  }
  value t1=system.nanoseconds;
  print("Encoding warmup...");
  value graph = parse(s);
  value t2=system.nanoseconds;
  print(graph.string);
  for (i in 1:1000) {
    value x=graph.string;
  }
  value t3=system.nanoseconds;
  print("DECODE: ``t1-t0``");
  print("ENCODE: ``t3-t2``");
}
