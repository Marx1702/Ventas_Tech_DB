-- ==============================================================================
-- Archivo: m5_consultas_joins.sql
-- Base de Datos: Ventas_Tech_DB
-- Descripción: Consultas con JOINs para enriquecimiento de datos y vistas de Power BI
-- Compatibilidad: Microsoft SQL Server (T-SQL)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Combina toda la información en una sola vista plana o "sábana" de datos
-- ------------------------------------------------------------------------------
SELECT 
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.segmento,
    t.region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    v.canal
FROM 
    ventas v
INNER JOIN 
    clientes c ON v.id_cliente = c.id_cliente
INNER JOIN 
    territorios t ON c.id_territorio = t.id_territorio
INNER JOIN 
    productos p ON v.id_producto = p.id_producto
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categoria;


-- ------------------------------------------------------------------------------
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Identifica clientes registrados en el CRM que nunca concretaron una compra
-- ------------------------------------------------------------------------------
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM 
    clientes c
LEFT JOIN 
    ventas v ON c.id_cliente = v.id_cliente
WHERE 
    v.id_venta IS NULL;


-- ------------------------------------------------------------------------------
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Identifica el inventario inmovilizado o artículos sin demanda
-- ------------------------------------------------------------------------------
SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM 
    productos p
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN 
    ventas v ON p.id_producto = v.id_producto
WHERE 
    v.id_venta IS NULL;


-- ------------------------------------------------------------------------------
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Unifica flujos de ventas y agrupa el total facturado por origen
-- ------------------------------------------------------------------------------
WITH ConsolidadoCanales AS (
    -- Bloque 1: Ventas Online
    SELECT 
        'Online' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM 
        ventas
    WHERE 
        canal = 'Online'
        
    UNION ALL
    
    -- Bloque 2: Ventas Presenciales
    SELECT 
        'Presencial' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM 
        ventas
    WHERE 
        canal = 'Presencial'
)
SELECT 
    canal,
    SUM(total_venta) AS total_facturado
FROM 
    ConsolidadoCanales
GROUP BY 
    canal;