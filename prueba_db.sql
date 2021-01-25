CREATE DATABASE prueba1;
\c prueba1

CREATE TABLE info_cliente(
    id_cliente SERIAL,
    RUT INT, -- Consider putting UNIQUE
    nombre  VARCHAR(60),
    direccion VARCHAR(90),
    PRIMARY KEY (id_cliente)
);

INSERT INTO info_cliente (RUT, nombre, direccion)
VALUES (121112222,'Ana','No se 12');

INSERT INTO info_cliente (RUT, nombre, direccion)
VALUES (131112223,'Lucilda','Muy lejos 123');

INSERT INTO info_cliente (RUT, nombre, direccion)
VALUES (141112224,'Juan','En la nada 14');

INSERT INTO info_cliente (RUT, nombre, direccion)
VALUES (151112225,'Pedro','Camino a Argentina 15');

INSERT INTO info_cliente (RUT, nombre, direccion)
VALUES (161112226,'Sergio','Camino a Peru 16');



CREATE TABLE categoria_productos(
    id_categoria SERIAL,
    nombre_categoria VARCHAR(30),
    descripcion_categoria VARCHAR(120),
    PRIMARY KEY (id_categoria)
);

INSERT INTO categoria_productos (nombre_categoria, descripcion_categoria)
VALUES ('Stable Coin', 'Monedas pegadas a plata');

INSERT INTO categoria_productos (nombre_categoria, descripcion_categoria)
VALUES ('Utility Coin', 'Monedas con utilidad dentro de su ecosistema');

INSERT INTO categoria_productos (nombre_categoria, descripcion_categoria)
VALUES ('Currency Coin', 'Monedas utilizadas para compras');


CREATE TABLE productos(
    id_producto SERIAL,
    nombre_producto VARCHAR(30), --Considerar hacer que esto sea UNIQUE
    descripcion_producto VARCHAR(120),
    valor_unitario INT,
    id_categoria INT,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categoria_productos(id_categoria)
);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('USDT', 'Stablecoin de Tether', 11, 1);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('USDC', 'Stablecoin de Coinbase', 10, 1);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('BUSD', 'Stablecoin de Binance', 9, 1);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('ETH', 'Token para plataforma Ethereum', 1300, 2);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('DOT', 'Token para plataforma Polkadot', 18, 2);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('BTC', 'Bitcoin', 33000, 3);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('BCH', 'Bitcoin Cash', 450, 3);

INSERT INTO productos (nombre_producto, descripcion_producto, valor_unitario,id_categoria)
VALUES ('LTC', 'Litecoin', 142, 3);



CREATE TABLE factura(
    id_factura SERIAL,
    id_cliente INT,
    fecha DATE, --Consider NOT NULL
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_cliente) REFERENCES info_cliente(id_cliente)
);

INSERT INTO factura (id_cliente, fecha)
VALUES (1, '2021-01-15');

INSERT INTO factura (id_cliente, fecha)
VALUES (1, '2021-01-16');

INSERT INTO factura (id_cliente, fecha)
VALUES (2, '2021-01-17');

INSERT INTO factura (id_cliente, fecha)
VALUES (2, '2021-01-18');

INSERT INTO factura (id_cliente, fecha)
VALUES (2, '2021-01-19');

INSERT INTO factura (id_cliente, fecha)
VALUES (3, '2021-01-20');

INSERT INTO factura (id_cliente, fecha)
VALUES (4, '2021-01-21');

INSERT INTO factura (id_cliente, fecha)
VALUES (4, '2021-01-22');

INSERT INTO factura (id_cliente, fecha)
VALUES (4, '2021-01-23');

INSERT INTO factura (id_cliente, fecha)
VALUES (4, '2021-01-24');



CREATE TABLE cantidades(
    id_factura INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (1, 6, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (1, 2, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (2, 1, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (2, 3, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (3, 8, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (3, 5, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (4, 4, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (4, 3, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (5, 7, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (5, 6, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (6, 3, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (6, 8, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (7, 4, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (7, 5, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (8, 1, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (8, 6, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (9, 8, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (9, 2, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (10, 1, 1000);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (10, 4, 1000);

