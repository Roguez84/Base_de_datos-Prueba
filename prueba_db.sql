CREATE DATABASE prueba1;
\c prueba1

CREATE TABLE info_cliente(
    id_cliente SERIAL,
    RUT INT,
    nombre  VARCHAR(60),
    direccion VARCHAR(90),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE categoria_productos(
    id_categoria SERIAL,
    nombre_categoria VARCHAR(30),
    descripcion_categoria VARCHAR(120),
    PRIMARY KEY (id_categoria)
);

CREATE TABLE productos(
    id_producto SERIAL,
    nombre_producto VARCHAR(30),
    descripcion_producto VARCHAR(120),
    valor_unitario INT,
    id_categoria INT,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categoria_productos(id_categoria)
);

CREATE TABLE factura(
    id_factura SERIAL,
    id_cliente INT,
    fecha DATE,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_cliente) REFERENCES info_cliente(id_cliente)
);

CREATE TABLE cantidades(
    id_factura INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

