USE Ventas_Tech_DB;
GO

/*CONSULTA 1 - RESUMEN EJECUTIVO MENSUAL*/

SELECT
    MONTH(fecha_venta) AS Mes,
    SUM(cantidad * precio_unitario) AS Total_Facturado,
    COUNT(*) AS Cantidad_Pedidos,
    CAST(SUM(cantidad * precio_unitario) AS DECIMAL(10,2))
        / COUNT(*) AS Ticket_Promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY Mes;
GO

/*CONSULTA 2 - TOP 5 PRODUCTOS POR FACTURACIÓN*/

SELECT TOP (5)
    id_producto,
    SUM(cantidad) AS Unidades_Vendidas,
    SUM(cantidad * precio_unitario) AS Total_Facturado
FROM ventas
GROUP BY id_producto
ORDER BY Total_Facturado DESC;
GO

/*CONSULTA 3 - CLIENTES RECURRENTES*/

SELECT
    id_cliente,
    COUNT(*) AS Cantidad_Pedidos,
    SUM(cantidad * precio_unitario) AS Total_Gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY Total_Gastado DESC;
GO

/*CONSULTA 4 - MESES POR ENCIMA / POR DEBAJO DEL PROMEDIO*/

WITH VentasMensuales AS (
    SELECT
        MONTH(fecha_venta) AS Mes,
        SUM(cantidad * precio_unitario) AS Total_Facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)

SELECT
    Mes,
    Total_Facturado,
    CASE
        WHEN Total_Facturado >
             (SELECT AVG(Total_Facturado)
              FROM VentasMensuales)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS Comparacion
FROM VentasMensuales
ORDER BY Mes;
GO

/*HALLAZGOS*/


-- 1) Se identifican diferencias en la facturación generada por los distintos productos.

-- 2) Existen clientes que realizaron más de una compra durante el período analizado.

-- 3) El análisis mensual permite monitorear el desempeño de las ventas y servirá como base para comparar futuros períodos.
