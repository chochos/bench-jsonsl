import jsonsl { Deserializer }

shared void crosstest() {
  value mod=`module`;
  assert(exists js = mod.resourceByPath("js.txt"),
         exists jvm = mod.resourceByPath("jvm.txt"));
  print("Deserializing JS string");
  assert(is Factura fs = Deserializer().parse(js.textContent()).first);
  print("Deserializing JVM string");
  assert(is Factura fvm = Deserializer().parse(jvm.textContent()).first);
  compFacts(fs, fvm);
}
