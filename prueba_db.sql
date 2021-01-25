CREATE DATABASE prueba;
\c prueba;

CREATE TABLE info_cliente(
    ID_cli SERIAL,
    RUT INT, -- Consider putting UNIQUE
    nombre  VARCHAR(60),
    direccion VARCHAR(90),
    PRIMARY KEY (ID_cli)
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
    ID_cat SERIAL,
    nombre_categoria VARCHAR(30),
    descripcion_categoria VARCHAR(120),
    PRIMARY KEY (ID_cat)
);

INSERT INTO categoria_productos (nombre_categoria, descripcion_categoria)
VALUES ('Stable Coin', 'Monedas pegadas a plata');

INSERT INTO categoria_productos (nombre_categoria, descripcion_categoria)
VALUES ('Utility Coin', 'Monedas con utilidad dentro de su ecosistema');

INSERT INTO categoria_productos (nombre_categoria, descripcion_categoria)
VALUES ('Currency Coin', 'Monedas utilizadas para compras');


CREATE TABLE productos(
    ID_pro SERIAL,
    nombre_producto VARCHAR(30), --Considerar hacer que esto sea UNIQUE
    descripcion_producto VARCHAR(120),
    valor_unitario INT,
    id_categoria INT,
    PRIMARY KEY (ID_pro),
    FOREIGN KEY (id_categoria) REFERENCES categoria_productos(ID_cat)
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
    ID_fac SERIAL,
    id_cliente INT,
    fecha DATE, --Consider NOT NULL
    PRIMARY KEY (ID_fac),
    FOREIGN KEY (id_cliente) REFERENCES info_cliente(ID_cli)
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
    FOREIGN KEY (id_factura) REFERENCES factura(ID_fac),
    FOREIGN KEY (id_producto) REFERENCES productos(ID_pro)
);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (1, 5, 1);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (1, 2, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (2, 1, 1);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (2, 3, 3);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (3, 8, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (3, 5, 1);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (4, 4, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (4, 3, 1);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (5, 7, 3);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (5, 6, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (6, 3, 4);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (6, 8, 3);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (7, 4, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (7, 5, 1);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (8, 1, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (8, 3, 3);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (9, 8, 2);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (9, 2, 1);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (10, 1, 5);

INSERT INTO cantidades(id_factura, id_producto, cantidad)
VALUES (10, 4, 3);

--Consultas
--tabla general para mi referencia
SELECT id_fac, fecha, id_cli, nombre, ID_pro, nombre_producto, valor_unitario, cantidad, valor_unitario*cantidad as valor_total
FROM ((
        SELECT *
        FROM info_cliente i JOIN factura f ON i.ID_cli = f.id_cliente
    )  AS cliente_factura
    JOIN cantidades ON cantidades.id_factura = cliente_factura.ID_fac ) AS cliente_factura_cantidad
    JOIN productos ON productos.ID_pro = cliente_factura_cantidad.id_producto
;

--Otra tabla general mas completa para mi referencia
SELECT id_fac, fecha, id_cli, nombre, ID_pro, nombre_producto, valor_unitario, cantidad, valor_sin_iva, iva, valor_total
FROM (
        SELECT *, valor_unitario*cantidad AS valor_sin_iva, valor_unitario*cantidad*0.19 AS IVA, (valor_unitario*cantidad + valor_unitario*cantidad*0.19)  AS valor_total
        FROM ((
            SELECT *
            FROM info_cliente i JOIN factura f ON i.ID_cli = f.id_cliente
            )  AS cliente_factura
            JOIN cantidades ON cantidades.id_factura = cliente_factura.ID_fac ) AS cliente_factura_cantidad
            JOIN productos ON productos.ID_pro = cliente_factura_cantidad.id_producto
    ) AS tablisima
;

--Que cliente realizo la compra mas cara?
SELECT nombre, ID_fac, fecha, sum(valor_total) AS total
FROM (
        SELECT *, valor_unitario*cantidad AS valor_sin_iva, valor_unitario*cantidad*0.19 AS IVA, (valor_unitario*cantidad + valor_unitario*cantidad*0.19)  AS valor_total
        FROM ((
            SELECT *
            FROM info_cliente i JOIN factura f ON i.ID_cli = f.id_cliente
            )  AS cliente_factura
            JOIN cantidades ON cantidades.id_factura = cliente_factura.ID_fac ) AS cliente_factura_cantidad
            JOIN productos ON productos.ID_pro = cliente_factura_cantidad.id_producto
    ) AS tablisima
GROUP BY ID_fac, fecha, nombre
ORDER BY total DESC
LIMIT 1
;


--Que cliente pago sobre 100 de monto?
SELECT *
FROM (
    SELECT nombre, sum(valor_total) AS total
    FROM 
        (
        SELECT *, valor_unitario*cantidad AS valor_sin_iva, valor_unitario*cantidad*0.19 AS IVA, (valor_unitario*cantidad + valor_unitario*cantidad*0.19)  AS valor_total
        FROM ((
            SELECT *
            FROM info_cliente i JOIN factura f ON i.ID_cli = f.id_cliente
            )  AS cliente_factura
            JOIN cantidades ON cantidades.id_factura = cliente_factura.ID_fac ) AS cliente_factura_cantidad
            JOIN productos ON productos.ID_pro = cliente_factura_cantidad.id_producto
        ) AS tablisima
    GROUP BY nombre
    ) AS resumen   
WHERE total >100
;

--Cuantos clientes han comprado el producto 6?
SELECT DISTINCT(nombre) --, ID_fac, fecha, id_pro, nombre_producto
FROM (
        SELECT *, valor_unitario*cantidad AS valor_sin_iva, valor_unitario*cantidad*0.19 AS IVA, (valor_unitario*cantidad + valor_unitario*cantidad*0.19)  AS valor_total
        FROM ((
            SELECT *
            FROM info_cliente i JOIN factura f ON i.ID_cli = f.id_cliente
            )  AS cliente_factura
            JOIN cantidades ON cantidades.id_factura = cliente_factura.ID_fac ) AS cliente_factura_cantidad
            JOIN productos ON productos.ID_pro = cliente_factura_cantidad.id_producto
    ) AS tablisima
WHERE id_pro =6
;
