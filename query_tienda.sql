
-- Lista el nombre de todos los productos que hay en la mesa producto.
select tienda.producto.nombre 
from tienda.producto;

-- Lista los nombres y los precios de todos los productos de la mesa producto.
select tienda.producto.nombre, tienda.producto.precio 
from tienda.producto;

-- Lista todas las columnas de la tabla producto.
select * 
from tienda.producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
select tienda.producto.nombre, 
tienda.producto.precio as precio_euros, 
tienda.producto.precio * 1.1 as precio_dolares 
from tienda.producto; 

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). 
-- Utiliza los siguientes sobrenombre para las columnas: nombre de producto, euros, dólares.
select tienda.producto.nombre as nombre_de_producto, 
tienda.producto.precio as euros, 
tienda.producto.precio * 1.1 as dolares 
from tienda.producto;

-- Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a mayúscula.
select upper(nombre) as nombre_producto,
tienda.producto.precio 
from tienda.producto;

-- Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a minúscula.
select lower(nombre),
tienda.producto.precio 
from tienda.producto;

-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros 
-- caracteres del nombre del fabricante.
select tienda.fabricante.nombre, 
upper(SUBSTRING(nombre, 1, 2)) as dos_caracteres_iniciales  
from tienda.fabricante;

-- Lista los nombres y los precios de todos los productos de la mesa producto, redondeando el valor del precio.
select tienda.producto.nombre, 
round(precio, 0) 
from tienda.producto;	

-- Lista los nombres y precios de todos los productos de la tabla producto, truncando el valor del precio para 
-- mostrarlo sin ninguna cifra decimal.
select tienda.producto.nombre, 
truncate(precio, 0) 
from tienda.producto;

-- Lista el código de los fabricantes que tienen productos en la mesa producto.
select tienda.fabricante.codigo 
from tienda.fabricante 
inner join tienda.producto 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Lista el código de los fabricantes que tienen productos en la mesa producto, eliminando los códigos que aparecen repetidos.
select distinctrow tienda.fabricante.codigo 
from tienda.fabricante 
inner join tienda.producto 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
select tienda.fabricante.nombre 
from tienda.fabricante 
order by tienda.fabricante.nombre asc;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
select tienda.fabricante.nombre 
from tienda.fabricante 
order by tienda.fabricante.nombre desc;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo 
-- lugar por el precio de forma descendente.
select * 
from tienda.producto 
order by tienda.producto.nombre desc, tienda.producto.precio desc;

-- Devuelve una lista con las 5 primeras filas de la mesa fabricante.
select * 
from tienda.fabricante 
limit 5;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la mesa fabricante. La cuarta fila también debe 
-- incluirse en la respuesta.
select * 
from tienda.fabricante 
limit 3,2;

-- Lista el nombre y precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT). 
-- NOTA: Aquí no podría usar MIN(precio), necesitaría GROUP BY
select * 
from tienda.producto 
order by tienda.producto.precio asc 
limit 1;

-- Lista el nombre y precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT). 
-- NOTA: Aquí no podría usar MAX(precio), necesitaría GROUP BY.
select * 
from tienda.producto 
order by tienda.producto.precio desc 
limit 1;

-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select tienda.producto.nombre 
from tienda.producto 
where tienda.producto.codigo_fabricante = 2; 

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select tienda.producto.nombre, 
tienda.producto.precio, 
tienda.fabricante.nombre as nombre_fabricante 
from tienda.producto 
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.
select tienda.producto.nombre, 
tienda.producto.precio, 
tienda.fabricante.nombre as nombre_fabricante 
from tienda.producto 
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
order by tienda.fabricante.nombre asc;

-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante 
-- y nombre del fabricante, de todos los productos de la base de datos.
select tienda.producto.codigo as codigo_producto, 
tienda.producto.nombre as nombre_producto, 
tienda.fabricante.codigo as codigo_fabricante, 
tienda.fabricante.nombre as nombre_fabricante
from tienda.producto 
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select tienda.producto.nombre as nombre_producto, 
tienda.producto.precio, 
tienda.fabricante.nombre as nombre_fabricante 
from tienda.producto
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
order by tienda.producto.precio asc 
limit 1;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select tienda.producto.nombre as nombre_producto, 
tienda.producto.precio, 
tienda.fabricante.nombre as nombre_fabricante 
from tienda.producto
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
order by tienda.producto.precio desc 
limit 1;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
select tienda.producto.nombre 
from tienda.producto 
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where tienda.fabricante.nombre = 'Lenovo';

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200 €.
select tienda.producto.nombre  
from tienda.producto 
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where tienda.fabricante.nombre = 'Crucial' 
and tienda.producto.precio > 200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
select tienda.producto.nombre  
from tienda.producto 
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where tienda.fabricante.nombre = 'Asus' 
or tienda.fabricante.nombre = 'Hewlett-Packard' 
or tienda.fabricante.nombre = 'Seagate';

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
select tienda.producto.nombre  
from tienda.producto 
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where tienda.fabricante.nombre 
in('Asus', 'Hewlett-Packard', 'Seagate');

-- Devuelve un listado con el nombre y precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
select tienda.producto.nombre, 
tienda.producto.precio  
from tienda.producto 
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where tienda.fabricante.nombre like '%e';

-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select tienda.producto.nombre, 
tienda.producto.precio  
from tienda.producto 
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where tienda.fabricante.nombre 
like '%w%';

-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que 
-- tengan un precio mayor o igual a 180 €. Ordene el resultado en primer lugar por el precio (en orden descendente) 
-- y en segundo lugar por el nombre (en orden ascendente)
select tienda.producto.nombre as nombre_producto, 
tienda.producto.precio, tienda.fabricante.nombre as nombre_fabricante  
from tienda.producto 
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante) 
where precio >= 180 
order by tienda.producto.precio desc, 
tienda.fabricante.nombre asc;

-- Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos 
-- asociados en la base de datos.
select tienda.fabricante.codigo, 
tienda.fabricante.nombre 
from tienda.fabricante 
where exists (select * from tienda.producto 
where tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Devuelve un listado de todos los fabricantes que existen en la base de datos, 
-- junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.
select tienda.fabricante.codigo, 
tienda.fabricante.nombre, 
tienda.producto.nombre 
from tienda.fabricante 
left join tienda.producto 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select * 
from tienda.fabricante 
where not exists (select * from tienda.producto 
where tienda.fabricante.codigo = tienda.producto.codigo_fabricante);

-- Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select tienda.producto.nombre 
from tienda.producto 
where exists (select * from tienda.fabricante 
where tienda.fabricante.codigo = tienda.producto.codigo_fabricante 
and tienda.fabricante.nombre = 'Lenovo');

-- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. 
-- (Sin utilizar INNER JOIN).
select * 
from producto 
where tienda.producto.precio = (select max(precio) 
from tienda.producto 
where tienda.producto.codigo_fabricante = (select tienda.fabricante.codigo 
from tienda.fabricante 
where tienda.fabricante.nombre = 'Lenovo'));

-- Lista el nombre del producto más caro del fabricante Lenovo.
select tienda.fabricante.nombre, 
max(precio) 
from tienda.producto
inner join tienda.fabricante 
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante)
where tienda.fabricante.nombre = 'Lenovo';  

-- Lista el nombre del producto más barato del fabricante Hewlett-Packard.
select tienda.fabricante.nombre, 
min(precio) from tienda.producto
inner join tienda.fabricante
on (tienda.fabricante.codigo = tienda.producto.codigo_fabricante)
where tienda.fabricante.nombre = 'Hewlett-Packard';

-- Devuelve todos los productos de la base de datos que tienen un precio mayor o igual 
-- al producto más caro del fabricante Lenovo.
select * 
from tienda.producto
where tienda.producto.precio >= (select max(precio) from tienda.producto 
where tienda.producto.codigo_fabricante = (select tienda.fabricante.codigo from tienda.fabricante 
where nombre = 'Lenovo'));

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
select * 
from tienda.producto 
where tienda.producto.precio > (select avg(precio) 
from tienda.producto 
where tienda.producto.codigo_fabricante = (select tienda.fabricante.codigo 
from tienda.fabricante 
where tienda.fabricante.nombre = 'Asus'))