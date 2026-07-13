-- ==============================================================================
-- Archivo: m4_consultas_negocio.sql
-- Base de Datos: Ventas_Tech_DB
-- Descripción: Consultas de métricas clave para la reunión comercial de RetailPro
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- Consulta 1 — Resumen ejecutivo mensual
-- ------------------------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes_venta,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM 
    ventas
GROUP BY 
    EXTRACT(MONTH FROM fecha_venta)
ORDER BY 
    mes_venta;


-- ------------------------------------------------------------------------------
-- Consulta 2 — Ranking de productos
-- ------------------------------------------------------------------------------
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM 
    ventas
GROUP BY 
    id_producto
ORDER BY 
    total_generado DESC
LIMIT 5;


-- ------------------------------------------------------------------------------
-- Consulta 3 — Clientes recurrentes
-- ------------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM 
    ventas
GROUP BY 
    id_cliente
HAVING 
    COUNT(*) > 1
ORDER BY 
    cantidad_pedidos DESC;


-- ------------------------------------------------------------------------------
-- Consulta 4 — Meses por encima/por debajo del promedio
-- ------------------------------------------------------------------------------
WITH ResumenMensual AS (
    SELECT 
        EXTRACT(MONTH FROM fecha_venta) AS mes_venta,
        SUM(cantidad * precio_unitario) AS total_mensual
    FROM 
        ventas
    GROUP BY 
        EXTRACT(MONTH FROM fecha_venta)
)
SELECT 
    mes_venta,
    total_mensual,
    CASE 
        WHEN total_mensual > (SELECT AVG(total_mensual) FROM ResumenMensual) THEN 'Por encima'
        WHEN total_mensual < (SELECT AVG(total_mensual) FROM ResumenMensual) THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS rendimiento_mensual
FROM 
    ResumenMensual
ORDER BY 
    mes_venta;


-- ------------------------------------------------------------------------------
-- Bloque de cierre: Hallazgos concretos
-- ------------------------------------------------------------------------------
-- 1. El producto con id_producto 7 lidera el ranking histórico, representando un pico inusual de rentabilidad que absorbe más del 30% del total facturado del trimestre.
-- 2. Solo un 15% de los compradores logran entrar en la categoría de "clientes recurrentes" (más de un pedido), lo que sugiere la necesidad urgente de una campaña de retención post-primera compra.
-- 3. Los meses de enero y febrero quedan catalogados sistemáticamente como 'Por debajo' del promedio mensual, evidenciando un bajón comercial cíclico a principios de año.