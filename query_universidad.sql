-- Base de dades Universidad

-- Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. 
-- El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
select universidad.persona.apellido1, universidad.persona.apellido2, universidad.persona.nombre 
from universidad.persona 
order by universidad.persona.apellido1 asc, universidad.persona.apellido2 asc, universidad.persona.nombre asc; 

-- Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
select universidad.persona.nombre, universidad.persona.apellido1, universidad.persona.apellido2 
from universidad.persona 
where universidad.persona.telefono is null;

-- Devuelve el listado de los alumnos que nacieron en 1999.
select * from universidad.persona 
where year(fecha_nacimiento) = 1999;

-- Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos 
-- y además su nif termina en K.
select * from universidad.persona 
where (universidad.persona.tipo = 'profesor' 
and universidad.persona.telefono is null 
and nif like '%K');

-- Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, 
-- en el tercer curso del grado que tiene el identificador 7.
select * from universidad.asignatura 
where universidad.asignatura.curso = 3 
and universidad.asignatura.cuatrimestre = 1 
and universidad.asignatura.id_grado = 7;

-- Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. 
-- El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.
select universidad.persona.apellido1, universidad.persona.apellido2, universidad.persona.nombre, universidad.departamento.nombre
from universidad.persona 
inner join universidad.profesor 
on (universidad.persona.id = universidad.profesor.id_profesor)
inner join universidad.departamento 
on (universidad.profesor.id_departamento = universidad.departamento.id) 
order by universidad.persona.apellido1 asc, universidad.persona.apellido2 asc, universidad.persona.nombre asc;

-- Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del 
-- curso escolar del alumno con nif 26902806M.
select universidad.asignatura.nombre, universidad.curso_escolar.anyo_inicio, universidad.curso_escolar.anyo_fin
from universidad.asignatura 
inner join universidad.alumno_se_matricula_asignatura 
on (universidad.asignatura.id = universidad.alumno_se_matricula_asignatura.id_asignatura)
inner join universidad.persona 
on (universidad.alumno_se_matricula_asignatura.id_alumno = universidad.persona.id)
inner join universidad.curso_escolar 
on (universidad.asignatura.curso = universidad.curso_escolar.id)
where universidad.persona.nif = '26902806M'; 

-- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna 
-- asignatura en el Grado en Ingeniería Informática (Plan 2015).
select distinctrow universidad.departamento.nombre 
from universidad.departamento
inner join universidad.profesor 
on (universidad.departamento.id = universidad.profesor.id_departamento)
inner join universidad.asignatura 
on (universidad.profesor.id_profesor = universidad.asignatura.id_profesor)
inner join universidad.grado 
on (universidad.asignatura.id_grado = universidad.grado.id)
where universidad.grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura 
-- durante el curso escolar 2018/2019.
select distinctrow universidad.persona.nombre, universidad.persona.apellido1, universidad.persona.apellido2, universidad.curso_escolar.anyo_inicio
from universidad.persona 
inner join universidad.alumno_se_matricula_asignatura 
on (universidad.persona.id = universidad.alumno_se_matricula_asignatura.id_alumno)
inner join universidad.curso_escolar 
on (universidad.alumno_se_matricula_asignatura.id_curso_escolar = universidad.curso_escolar.id)
where universidad.curso_escolar.anyo_inicio = 2018;

-- Resuelva las 6 siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- Devuelve un listado con los nombres de todos los profesores y departamentos que tienen vinculados. 
-- El listado también debe mostrar a aquellos profesores que no tienen ningún departamento asociado. 
-- El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido 
-- y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre 
-- del departamento, apellidos y nombre.
select universidad.departamento.nombre as nombre_departamento, 
universidad.persona.apellido1, universidad.persona.apellido2, universidad.persona.nombre
from universidad.departamento 
right join universidad.profesor 
on (universidad.profesor.id_departamento = universidad.departamento.id) 
right join universidad.persona 
on (universidad.profesor.id_profesor = universidad.persona.id)
order by universidad.departamento.nombre asc, 
universidad.persona.apellido1 asc, 
universidad.persona.apellido2 asc, 
universidad.persona.nombre asc;

-- Devuelve un listado con los profesores que no están asociados a un departamento.
select universidad.departamento.nombre as nombre_departamento, 
universidad.persona.apellido1, 
universidad.persona.apellido2, 
universidad.persona.nombre
from universidad.departamento 
right join universidad.profesor 
on (universidad.profesor.id_departamento = universidad.departamento.id)
right join universidad.persona 
on (universidad.profesor.id_profesor = universidad.persona.id) 
where universidad.departamento.nombre is null; 

-- Devuelve un listado con los departamentos que no tienen profesores asociados.
select universidad.departamento.nombre as nombre_departamento, 
universidad.persona.apellido1, 
universidad.persona.apellido2, 
universidad.persona.nombre
from universidad.departamento 
left join universidad.profesor 
on (universidad.profesor.id_departamento = universidad.departamento.id)
left join universidad.persona 
on (universidad.profesor.id_profesor = universidad.persona.id) 
where universidad.persona.nombre is null 
and universidad.persona.apellido1 is null 
and universidad.persona.apellido2 is null;

-- Devuelve un listado con los profesores que no imparten ninguna asignatura.
select distinctrow universidad.persona.apellido1, universidad.persona.apellido2, universidad.persona.nombre
from universidad.persona 
left join universidad.asignatura 
on (universidad.persona.id = universidad.asignatura.id_profesor)
where universidad.persona.tipo = 'profesor' and universidad.asignatura.nombre is null;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.
select distinct universidad.asignatura.nombre
from universidad.persona
right join universidad.asignatura
on (universidad.persona.id = universidad.asignatura.id_profesor)
where universidad.persona.nombre is null
and universidad.persona.apellido1 is null
and universidad.persona.apellido2 is null;

-- Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
select distinct universidad.departamento.nombre
from universidad.departamento
left join universidad.profesor 
on (universidad.departamento.id = universidad.profesor.id_departamento)
where universidad.profesor.id_profesor is null; 

-- Consultas resumen:

-- Devuelve el número total de alumnos existentes.
select universidad.persona.tipo, count(*) as numero_alumnos
from universidad.persona
where universidad.persona.tipo = 'alumno';

-- Calcula cuántos alumnos nacieron en 1999.
select year(universidad.persona.fecha_nacimiento) as anio_nacimiento, count(*) as numero_Alumnos 
from universidad.persona
where year(universidad.persona.fecha_nacimiento) = 1999;  

-- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, 
-- una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. 
-- El resultado sólo debe incluir los departamentos que tienen profesores asociados y tendrá que estar 
-- ordenado de mayor a menor por el número de profesores.
select universidad.departamento.nombre as nombre_departamento,
count(universidad.profesor.id_departamento) as numero_profesores
from universidad.profesor
inner join universidad.departamento
on (universidad.profesor.id_departamento = universidad.departamento.id)
group by universidad.departamento.nombre
order by numero_profesores desc;

-- Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. 
-- Tenga en cuenta que pueden existir departamentos que carecen de profesores asociados. 
-- Estos departamentos también deben aparecer en el listado.
select universidad.departamento.nombre as nombre_departamento,
count(universidad.profesor.id_departamento) as numero_profesores
from universidad.profesor
right join universidad.departamento
on (universidad.profesor.id_departamento = universidad.departamento.id)
group by universidad.departamento.nombre;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos 
-- y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados 
-- que carecen de asignaturas asociadas. Estos grados también deben aparecer en el listado. 
-- El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
select universidad.grado.nombre as nombre_grados_existentes,
count(universidad.asignatura.id_grado) as numero_asignaturas
from universidad.grado
left join universidad.asignatura
on (universidad.grado.id = universidad.asignatura.id_grado)
group by universidad.grado.nombre
order by numero_asignaturas desc; 

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número 
-- de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
select universidad.grado.nombre as nombre_grados_existentes,
count(universidad.asignatura.id_grado) as numero_asignaturas
from universidad.grado
left join universidad.asignatura
on (universidad.grado.id = universidad.asignatura.id_grado)
group by universidad.grado.nombre
having numero_asignaturas > 40; 

-- Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes 
-- para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura 
-- y la suma de los créditos de todas las asignaturas que existen de este tipo.
select universidad.grado.nombre as nombre_grado,
universidad.asignatura.tipo as tipo_asignatura,
sum(universidad.asignatura.creditos) as total_creditos_existentes
from universidad.grado
left join universidad.asignatura
on (universidad.grado.id = universidad.asignatura.id_grado)
group by universidad.grado.nombre,
universidad.asignatura.tipo; 

-- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno 
-- de los cursos escolares. El resultado tendrá que mostrar dos columnas, una columna con el año de inicio 
-- del curso escolar y otra con el número de alumnos matriculados.
select distinctrow universidad.curso_escolar.anyo_inicio,
count(distinctrow universidad.alumno_se_matricula_asignatura.id_alumno) as numero_alumnos_matriculados
from universidad.curso_escolar 
inner join universidad.alumno_se_matricula_asignatura
on (universidad.curso_escolar.id = universidad.alumno_se_matricula_asignatura.id_curso_escolar)
group by universidad.curso_escolar.anyo_inicio;

-- Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe 
-- tener en cuenta a aquellos profesores que no imparten ninguna asignatura. El resultado mostrará 
-- cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado 
-- estará ordenado de mayor a menor por el número de asignaturas.
select universidad.persona.id,
universidad.persona.nombre,
universidad.persona.apellido1,
universidad.persona.apellido2,
count(universidad.asignatura.nombre) as asignatura
from universidad.persona
left join universidad.asignatura
on (universidad.asignatura.id_profesor = universidad.persona.id)
where universidad.persona.tipo = 'profesor'
group by universidad.persona.id
order by asignatura desc;

-- Devuelve todos los datos del alumno más joven.
select *
from universidad.persona
order by universidad.persona.fecha_nacimiento desc 
limit 1; 

-- Devuelve un listado con los profesores que tienen un departamento asociado y 
-- que no imparten ninguna asignatura.
select distinctrow universidad.persona.id,
universidad.persona.nombre,
universidad.persona.apellido1,
universidad.persona.apellido2
from universidad.persona
left join universidad.profesor
on (universidad.persona.id = universidad.profesor.id_profesor)
left join universidad.asignatura
on (universidad.profesor.id_profesor = universidad.asignatura.id_profesor)
where universidad.persona.tipo = 'profesor'
and universidad.asignatura.nombre is null;