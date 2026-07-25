USE Ventas_Tech_DB;
GO

/*CONSULTA 1 - VISTA BASE DEL PROYECTO (INNER JOIN)*/

SELECT
    v.id_venta,
    v.fecha_venta AS Fecha,
    c.nombre AS Cliente,
    c.email AS Email,
    c.ciudad AS Ciudad,
    p.nombre_producto AS Producto,
    cat.nombre_categoria AS Categoria,
    v.cantidad AS Cantidad,
    v.precio_unitario AS Precio_Unitario,
    (v.cantidad * v.precio_unitario) AS Total_Venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria;
GO


/*CONSULTA 2 - CLIENTES SIN VENTAS (LEFT JOIN)*/

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;
GO


/*CONSULTA 3 - PRODUCTOS SIN VENTAS (LEFT JOIN)*/

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS Categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_producto IS NULL;
GO


/*CONSULTA 4 - CONSOLIDADO DE VENTAS*/

SELECT
    'Ventas Registradas' AS Tipo_Registro,
    COUNT(*) AS Cantidad_Ventas,
    SUM(cantidad * precio_unitario) AS Total_Facturado
FROM ventas;
GO


/*HALLAZGOS*/

-- 1) Los JOIN permiten reunir información de ventas, clientes,
--    productos y categorías en una sola consulta.

-- 2) Con LEFT JOIN es posible identificar clientes o productos
--    que aún no tienen movimientos registrados.

-- 3) La vista consolidada servirá como base para el modelo
--    analítico que se utilizará posteriormente en Power BI.
