-- PASO 1: MODELO CLAVE-VALOR
-- Colección: carrito
-- Simula un almacenamiento de tipo clave-valor para carritos de compra

-- Inserción de datos clave-valor
db.carrito.insertMany([
  { _id: "cliente_uio_101", items: [{ producto: "Licuadora de Cacao Industrial", cantidad: 1 }, { producto: "Cacao 100% Barra", cantidad: 5 }] },
  { _id: "cliente_rbb_202", items: [{ producto: "Molino de Cacao Artesanal", cantidad: 2 }] }
]);

-- Consulta por clave específica
db.carrito.findOne({ _id: "cliente_uio_101" });

-- Eliminación por clave
db.carrito.deleteOne({ _id: "cliente_uio_101" });

-- PASO 2: MODELO DOCUMENTAL
-- Colección: pedidos
-- Almacena transacciones jerárquicas con subdocumentos embebidos

-- Inserción de pedidos con estructura jerárquica
db.pedidos.insertMany([
  {
    nro_pedido: "PED-2026-001",
    fecha: ISODate("2026-07-01T20:00:00Z"),
    cliente: { id_cliente: 1, nombre: "Corporación Oro Cacao", ruc: "1792345678001" },
    envio: { direccion: "Av. Amazonas y Patria", ciudad: "Quito", provincia: "Pichincha" },
    items: [
      { producto: "Refinadora de Cacao Industrial", precio: 2450.00, cantidad: 1 },
      { producto: "Moldes de Policarbonato", precio: 10.00, cantidad: 10 }
    ],
    estado: "Procesado"
  },
  {
    nro_pedido: "PED-2026-002",
    fecha: ISODate("2026-07-01T21:15:00Z"),
    cliente: { id_cliente: 2, nombre: "Distribuidora Chimborazo", ruc: "0601234567" },
    envio: { direccion: "Guayaquil y Tarqui", ciudad: "Riobamba", provincia: "Chimborazo" },
    items: [
      { producto: "Molino de Cacao Artesanal", precio: 320.00, cantidad: 2 }
    ],
    estado: "Pendiente"
  }
]);

-- Consulta de agregación: filtrado y cálculo de totales por cliente
db.pedidos.aggregate([
  { $match: { "cliente.nombre": "Corporación Oro Cacao" } },
  { $unwind: "$items" },
  { 
    $group: { 
      _id: "$nro_pedido", 
      cliente: { $first: "$cliente.nombre" },
      total_pagar: { $sum: { $multiply: [ "$items.precio", "$items.cantidad" ] } } 
    } 
  }
]);

-- PASO 3: MODELO DE GRAFOS - NODOS
-- Colección: red_universitaria
-- Almacena los vértices o entidades de la red universitaria

-- Inserción de nodos (entidades)
db.red_universitaria.insertMany([
  { _id: "docente_jmoyano", tipo: "Docente", nombre: "Ing. Johana Moyano", catedra: "Administración de Bases de Datos" },
  { _id: "estudiante_lordoniez", tipo: "Estudiante", nombre: "Luis Ordoñez", semestre: "Cuarto" },
  { _id: "estudiante_aperez", tipo: "Estudiante", nombre: "Ana Pérez", semestre: "Cuarto" },
  { _id: "grupo_A", tipo: "Clases", nombre: "Grupo paralelo A" }
]);


-- PASO 4: MODELO DE GRAFOS - ARISTAS
-- Colección: conexiones_red
-- Almacena las relaciones dirigidas entre nodos

-- Inserción de aristas (relaciones)
db.conexiones_red.insertMany([
  { desde: "docente_jmoyano", hacia: "estudiante_lordoniez", relacion: "DictaMateria", detalles: "Periodo 2026-1S" },
  { desde: "docente_jmoyano", hacia: "grupo_A", relacion: "Lidera", rol: "Director Principal" },
  { desde: "estudiante_lordoniez", hacia: "grupo_A", relacion: "MiembroAnterior", baja: "2026-05" },
  { desde: "estudiante_lordoniez", hacia: "estudiante_aperez", relacion: "ColaboracionAcademica", proyecto: "Task NoSQL" }
]);

-- PASO 5: CONSULTA DE GRAFOS - CONEXIONES DIRECTAS
-- Identifica relaciones desde un nodo raíz con enriquecimiento de datos

-- Consulta de conexiones desde el nodo docente
db.conexiones_red.aggregate([
  { $match: { desde: "docente_jmoyano" } },
  {
    $lookup: {
      from: "red_universitaria",
      localField: "hacia",
      foreignField: "_id",
      as: "entidad_conectada"
    }
  },
  { $unwind: "$entidad_conectada" },
  {
    $project: {
      _id: 0,
      origen: "$desde",
      conexion: "$relacion",
      destino: "$entidad_conectada.nombre",
      tipo_destino: "$entidad_conectada.tipo"
    }
  }
]);

-- PASO 6: CONSULTA DE GRAFOS - RED COMPLETA
-- Visualiza todas las relaciones con información de origen y destino

-- Consulta completa de la red universitaria
db.conexiones_red.aggregate([
  {
    $lookup: {
      from: "red_universitaria",
      localField: "desde",
      foreignField: "_id",
      as: "origen_info"
    }
  },
  {
    $lookup: {
      from: "red_universitaria",
      localField: "hacia",
      foreignField: "_id",
      as: "destino_info"
    }
  },
  { $unwind: "$origen_info" },
  { $unwind: "$destino_info" },
  {
    $project: {
      _id: 0,
      desde: "$origen_info.nombre",
      tipo_origen: "$origen_info.tipo",
      relacion: 1,
      hacia: "$destino_info.nombre",
      tipo_destino: "$destino_info.tipo"
    }
  }
]);

-- PASO 7: MODELO DE COLUMNAS
-- Colección: ventas_columnas
-- Simula almacenamiento orientado a familias de columnas

-- Inserción de registros con familias de columnas
db.ventas_columnas.insertMany([
  {
    _id: ObjectId(),
    familia_cliente: { id: 1, razon_social: "Corporación Oro Cacao", region: "Sierra" },
    familia_producto: { sku: "PROD-001", descripcion: "Refinadora de Cacao Industrial", categoria: "Maquinaria" },
    familia_transaccion: { factura: "F-001", cantidad: 2, ingresos_totales: 4900.00, fecha: ISODate("2026-06-27") }
  },
  {
    _id: ObjectId(),
    familia_cliente: { id: 2, razon_social: "Distribuidora Chimborazo", region: "Sierra" },
    familia_producto: { sku: "PROD-002", descripcion: "Molino de Cacao Artesanal", categoria: "Equipos" },
    familia_transaccion: { factura: "F-002", cantidad: 1, ingresos_totales: 320.00, fecha: ISODate("2026-06-27") }
  }
]);

-- PASO 8: CONSULTA DE COLUMNAS ESPECÍFICAS
-- Lectura selectiva de columnas con filtro por categoría

-- Consulta analítica: ingresos por producto de categoría Maquinaria
db.ventas_columnas.find(
  { "familia_producto.categoria": "Maquinaria" },
  { _id: 0, "familia_producto.descripcion": 1, "familia_transaccion.ingresos_totales": 1 }
);