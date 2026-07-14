Base de Datos Relacional: TechStore (Ventas_Tech_DB)
Descripción del Proyecto
Este repositorio contiene el Back-End de datos para el proyecto final de Data Analytics de TechStore, una cadena de tiendas de tecnología. El objetivo principal es construir una base de datos relacional desde cero (Ventas_Tech_DB), profesional, limpia y normalizada.

Este script SQL sienta las bases para la posterior ingesta, transformación y visualización de datos en herramientas de Inteligencia de Negocios, respondiendo directamente a las necesidades estratégicas del equipo comercial.

Modelo de Datos
La base de datos sigue un modelo relacional en Tercera Forma Normal (3NF) estructurado en formato de estrella (Star Schema), con una tabla de hechos central rodeada de dimensiones:

categorias (1) ──── (N) productos (1) ──── (N) ventas (N) ──── (1) clientes

Estructura de las Tablas
El esquema consta de cuatro tablas principales:

Categorías (Dimensión): Clasificación de los productos (ej. Computación, Audio).

Clientes (Dimensión): Información de los compradores registrados (nombre, email, ciudad).

Productos (Dimensión): Catálogo de artículos disponibles, vinculados a una categoría específica, con su precio y control de stock.

Ventas (Tabla de Hechos): El núcleo del modelo. Registra cada transacción, vinculando qué cliente compró qué producto, en qué cantidad, a qué precio y en qué fecha.

Características del Script (ventas_tech_db.sql)
El archivo SQL está diseñado para ser completamente automatizado y repetible, dividido en tres bloques fundamentales:

Limpieza Previa (DROP TABLES): Gestión segura de dependencias (claves foráneas) para eliminar tablas en orden inverso, permitiendo la re-ejecución del script sin errores.

Definición de Esquema (DDL) y Restricciones: Creación de tablas con estrictas reglas de integridad referencial. Uso de PRIMARY KEY, FOREIGN KEY y restricciones NOT NULL. Los valores monetarios utilizan tipos de datos precisos (DECIMAL(10,2)).

Carga Inicial (DML): Inserción de datos semilla en el orden lógico de dependencias (Dimensiones primero, Hechos al final) para habilitar las pruebas analíticas inmediatas (4 categorías, 5 clientes, 6 productos y 10 transacciones).

Entorno y Compatibilidad
Lenguaje: SQL (T-SQL)

Motor de Base de Datos: Microsoft SQL Server.

Nota técnica de implementación: El esquema está optimizado para funcionar de manera nativa en SQL Server. Por ejemplo, la validación de estados booleanos (como el campo activo en la tabla de productos) se maneja con tipos de datos nativos del motor, evitando conflictos de sintaxis o funcionamiento con directivas como TINYINT.

Próximos Pasos en el Flujo de Trabajo (Data Pipeline)
Conexión y ETL: Conexión directa de esta base de datos a Power BI para la limpieza y transformación de los registros.

Modelado Analítico: Construcción del modelo de datos e implementación de medidas con lenguaje DAX.

Visualización: Creación del Dashboard interactivo final para los stakeholders de TechStore.