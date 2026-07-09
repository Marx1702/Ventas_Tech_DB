Ejercicio



Actividad

Checkpoint: Script SQL de Ingeniería de Datos

Contexto del Proyecto Final

Para tu certificación como Data Analyst , el entregable final consiste en un Dashboard de Inteligencia de Negocios que responda a preguntas estratégicas de una empresa de retail (ventas).

Sin embargo, un dashboard es tan bueno como los datos que lo alimentan. Este checkpoint representa la creación del Back-End de tu proyecto: el script SQL que genera la base de datos profesional, limpia y normalizada, donde residirá toda la información de ventas.

¿Qué debes construir?

Vas a crear un archivo de texto con extensión .sql que contenga tres secciones claramente identificadas. Importante: la entrega es el enlace (URL) a tu repositorio público de GitHub donde esté ese archivo — el campo espera un link, no la subida directa del archivo.

1. Definición del Esquema (DDL)

Diseña y crea las tablas para un modelo de Ventas de Tecnología. Tu esquema debe incluir al menos:

Tabla de Productos: (ID, Nombre, Precio, CategoriaID).

Tabla de Categorías: Para cumplir con la 3NF, las categorías no deben ser texto en la tabla de productos, sino una tabla aparte.

Tabla de Clientes: (ID, Nombre, Email, Ciudad).

Tabla de Ventas (Hechos): La tabla central que conecta a las demás (ID_Venta, Fecha, ClienteID, ProductoID, Cantidad).

2. Restricciones de Integridad

Cada tabla debe tener su PRIMARY KEY.

Debes definir las FOREIGN KEYS en la tabla de Ventas para asegurar la integridad referencial (no se puede vender un producto que no existe).

Usa restricciones NOT NULL en campos críticos (como el precio o el nombre del cliente).

3. Carga Inicial de Datos (DML)

Inserta al menos 3 categorías diferentes.

Inserta al menos 5 productos distribuidos en esas categorías.

Inserta al menos 3 clientes.

Registra al menos 10 transacciones de venta para que tengamos datos que analizar después.

Pasos Sugeridos

Dibuja tu modelo: Antes de escribir código, haz un borrador (puede ser en papel o una herramienta digital) de cómo se conectan las tablas.

Escribe el DDL: Comienza con los comandos CREATE TABLE. Recuerda el orden: primero las dimensiones, al final la tabla de hechos.

Añade las restricciones: Define las PKs y FKs dentro del CREATE TABLE o mediante ALTER TABLE.

Carga los datos: Usa INSERT INTO siguiendo el mismo orden lógico.

Prueba tu script: Ejecútalo en tu entorno local, borra las tablas y vuelve a ejecutarlo para asegurar que es "repetible".

Entregá el enlace: subí el archivo .sql a un repositorio público de GitHub y pegá la URL del repositorio en el campo de entrega. ⚠️ Se entrega el link del repo, no el archivo adjunto.

Errores comunes a evitar

El error del "Huevo y la Gallina": Intentar crear la tabla de Ventas antes de que existan Productos o Clientes. SQL te dará un error porque las Foreign Keys no encontrarán su referencia.

Cifras monetarias imprecisas: Usar tipos de datos de texto para precios o fechas. Esto impedirá que puedas hacer cálculos matemáticos (SUM, AVG) en el futuro.



Subí el enlace a tu repositorio GitHub con el archivo ventas_tech_db.sql dentro de la carpeta del módulo. El repositorio debe ser público.

Entregable



Práctica

Creando la base de datos Ventas_Tech_DB: DDL, Constraints e INSERT

Propósito del ejercicio

En esta práctica vas a construir desde cero la base de datos Ventas_Tech_DB — el dataset que vas a usar durante todo el curso. Vas a definir la estructura de cuatro tablas relacionadas, establecer las claves foráneas que garantizan la integridad de los datos y cargarla con información inicial lista para consultar. En el Módulo 6 vas a conectar Power BI directamente a esta base de datos para limpiarla y transformarla. En el Módulo 8 vas a construir el modelo analítico y las medidas DAX encima de ella. Este es el primer paso de ese recorrido.

Contexto

Sos el DBA de TechStore, una cadena de tiendas de tecnología. Tu tarea es crear la base de datos Ventas_Tech_DB con un modelo relacional correcto que soporte las operaciones de ventas del negocio.

Modelo de datos esperado





categorias (1) ──── (N) productos (1) ──── (N) ventas (N) ──── (1) clientes



Instrucciones

Paso 1: Crear la base de datos

sql





CREATE DATABASE Ventas_Tech_DB;



Paso 2: Desarrollá el script con las siguientes secciones

DROP TABLES

Agregá al inicio del script las sentencias para eliminar las tablas si ya existen, respetando el orden inverso de las dependencias para no violar las foreign keys:

sql





DROP TABLE IF EXISTS ventas;

DROP TABLE IF EXISTS productos;

DROP TABLE IF EXISTS clientes;

DROP TABLE IF EXISTS categorias;



CREATE TABLES

Creá las cuatro tablas en este orden con los tipos de datos indicados:

Tabla categorias





ColumnaTipoRestricciónid_categoriaINTPRIMARY KEYnombre_categoriaVARCHAR(50)NOT NULLdescripcionVARCHAR(200)​

Tabla clientes





ColumnaTipoRestricciónid_clienteINTPRIMARY KEYnombreVARCHAR(100)NOT NULLemailVARCHAR(100)UNIQUEciudadVARCHAR(50)​fecha_registroDATENOT NULL

Tabla productos





ColumnaTipoRestricciónid_productoINTPRIMARY KEYnombre_productoVARCHAR(100)NOT NULLid_categoriaINTFOREIGN KEY → categoriasprecioDECIMAL(10,2)NOT NULLstockINTDEFAULT 0activoTINYINT(1)DEFAULT 1

Tabla ventas





ColumnaTipoRestricciónid_ventaINTPRIMARY KEYid_clienteINTFOREIGN KEY → clientesid_productoINTFOREIGN KEY → productoscantidadINTNOT NULLprecio_unitarioDECIMAL(10,2)NOT NULLfecha_ventaDATENOT NULL

INSERT DATA

Cargá los siguientes datos en el orden correcto (primero las tablas sin dependencias):

categorias — 4 registros:

sql





INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');

INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');

INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');

INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');



sql





INSERT INTO clientes VALUES (1, 'María López', 'maria@mail.com', 'Buenos Aires', '2024-01-05');

INSERT INTO clientes VALUES (2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10');

INSERT INTO clientes VALUES (3, 'Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01');

INSERT INTO clientes VALUES (4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15');

INSERT INTO clientes VALUES (5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');





productos — 6 registros:

sql





INSERT INTO productos VALUES (1, 'Laptop Pro 15', 1, 1200.00, 15, 1);

INSERT INTO productos VALUES (2, 'Mouse Inalámbrico', 2, 28.00, 80, 1);

INSERT INTO productos VALUES (3, 'Monitor 4K 27"', 1, 450.00, 12, 1);

INSERT INTO productos VALUES (4, 'Auriculares BT Pro', 3, 120.00, 35, 1);

INSERT INTO productos VALUES (5, 'SSD Externo 1TB', 4, 130.00, 18, 1);

INSERT INTO productos VALUES (6, 'Teclado Mecánico', 2, 95.00, 40, 1);



ventas — 10 registros:

sql





INSERT INTO ventas VALUES (1, 1, 1, 2, 1200.00, '2024-03-05');

INSERT INTO ventas VALUES (2, 2, 2, 5, 28.00, '2024-03-06');

INSERT INTO ventas VALUES (3, 3, 3, 1, 450.00, '2024-03-07');

INSERT INTO ventas VALUES (4, 1, 4, 2, 120.00, '2024-03-08');

INSERT INTO ventas VALUES (5, 4, 5, 3, 130.00, '2024-03-10');

INSERT INTO ventas VALUES (6, 2, 6, 4, 95.00, '2024-03-11');

INSERT INTO ventas VALUES (7, 5, 1, 1, 1200.00, '2024-03-12');

INSERT INTO ventas VALUES (8, 3, 2, 8, 28.00, '2024-03-13');

INSERT INTO ventas VALUES (9, 4, 4, 1, 120.00, '2024-03-14');

INSERT INTO ventas VALUES (10, 5, 3, 2, 450.00, '2024-03-15');



Paso 3: Verificá la integridad Ejecutá el script completo y confirmá que no hay errores. Luego ejecutá estas consultas de validación:

sql





-- Confirmá que cada tabla se cargó correctamente

SELECT * FROM categorias;

SELECT * FROM clientes;

SELECT * FROM productos;

SELECT * FROM ventas;



-- (Más adelante, en el Módulo 5, vas a poder cruzar estas tablas con JOIN

-- para ver las ventas junto al nombre del cliente y del producto.

-- Por ahora alcanza con confirmar que las 4 tablas tienen sus datos.)



Criterios de aceptación

El script debe ejecutarse sin errores en PostgreSQL o SQL Server.

Las foreign keys deben estar definidas correctamente en productos y ventas.

No se permiten valores nulos en columnas marcadas como NOT NULL.

El DROP TABLE debe respetar el orden inverso de dependencias.

Las 4 tablas se cargan sin errores y la tabla ventas contiene 10 registros.

⚠️ Errores comunes a evitar

Orden incorrecto en DROP TABLE: Siempre eliminá primero las tablas que tienen FK antes que las tablas referenciadas.

Orden incorrecto en INSERT: Cargá primero categorias y clientes antes de productos y ventas.

FLOAT para precios: Usá siempre DECIMAL(10,2) para valores monetarios. 

