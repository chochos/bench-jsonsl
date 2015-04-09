shared serializable class Factura(numero,fecha,autor,destino,items,impuesto=16.0,descuento=0.0) {
  shared Integer numero;
  shared Entidad autor;
  shared Entidad destino;
  shared Integer fecha;
  shared [Item+] items;
  shared Float impuesto;
  shared Float descuento;
  shared actual String string {
    value subtotal = sum(items.map((i)=>i.producto.precio*i.cantidad));
    value tax = subtotal * impuesto / 100.00;
    return "FACTURA # ``numero``
            EXPIDE:  ``autor.nombre``
                     RFC ``autor.rfc``
                     ``autor.domicilio``
            CLIENTE: ``destino.nombre``
                     RFC ``destino.rfc``
                     ``destino.domicilio``
            DETALLE:  ``items``
            SUBTOTAL: $ ``subtotal``
            IMPUESTO: $ ``tax`` (``impuesto``%)
            TOTAL:    $ ``subtotal+tax``";
  }
}

shared serializable class Entidad(nombre,rfc,domicilio) {
  shared String nombre;
  shared String rfc;
  shared Domicilio domicilio;
}

shared serializable class Domicilio(calle,numExt,numInt,colonia,municipio,estado,cp,pais) {
  shared String calle;
  shared String numExt;
  shared String? numInt;
  shared String colonia;
  shared String municipio;
  shared String estado;
  shared String pais;
  shared String cp;
  string="``calle`` #``numExt``
          Col. ``colonia``
          ``municipio``,``estado``
          CP ``cp`` ``pais``";
}

shared serializable class Item(producto,cantidad) {
  shared Producto producto;
  shared Integer cantidad;
  string = "``producto`` x``cantidad``";
}

shared serializable class Producto(nombre,sku,precio) {
  shared String nombre;
  shared String sku;
  shared Float precio;
  string = "PROD[``nombre`` (``sku``) $``precio``]";
}

void compFacts(Factura f1, Factura f2) {
  function compDom(Domicilio d1, Domicilio d2) {
    value eqs = d1.calle==d2.calle && d1.numExt==d2.numExt
        && d1.colonia==d2.colonia && d1.municipio==d2.municipio
        && d1.estado==d2.estado && d1.pais==d2.pais
        && d1.cp==d2.cp;
    if (eqs) {
      if (exists n=d1.numInt) {
        if (exists dn=d2.numInt) {
          return dn==n;
        }
      } else {
        return !d2.numInt exists;
      }
    }
    return false;
  }
  assert(f1.numero==f1.numero && f1.fecha==f2.fecha
        && f1.autor.nombre==f2.autor.nombre && f1.autor.rfc==f2.autor.rfc
        && f1.destino.nombre==f2.destino.nombre && f1.destino.rfc==f2.destino.rfc
        && compDom(f1.autor.domicilio, f2.autor.domicilio)
        && compDom(f1.destino.domicilio, f2.destino.domicilio)
        && f1.items.size==f2.items.size
        && f1.impuesto==f2.impuesto && f1.descuento==f2.descuento);
  value it2=f2.items.iterator();
  for (i in f1.items) {
    assert(is Item i2 = it2.next(),
           i.cantidad==i2.cantidad,
           i.producto.nombre==i2.producto.nombre && i.producto.sku == i2.producto.sku && i.producto.precio==i2.producto.precio);
  }
}
