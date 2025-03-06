-- 7.a La cantidad de empleados de la empresa que tienen 2 hijos.
select e.NomEmp, COUNT(h.NumHij) from empleado e 
    join hijo h on e.CodEmp = h.CodEmp
    group by e.CodEmp
    having COUNT(h.NumHij) = 2;

-- 7.b Cuantos empleados no tiene extensión telefónica.
select COUNT(*) as 'Sin Extension' from empleado
    where ExTelEmp is null;

-- 7.c La edad media de los empleados.
select AVG(TIMESTAMPDIFF(YEAR, FecNaEmp, NOW())) AS 'Edad media' from empleado;

-- 7.d La edad media de los empleados que trabajan en un centro que esté en Murcia.
select AVG(TIMESTAMPDIFF(YEAR, e.FecNaEmp, NOW())) from empleado e
    inner join departamento d on e.CodDep = d.CodDep
    inner join centro c on d.CodCen = c.CodCen
    where c.PobCen = 'Murcia';


-- 7.e La suma de presupuesto para los departamentos que estén en Cartagena.
select SUM(d.PreAnu) from departamento d
    inner join centro c on d.CodCen = c.CodCen
    where c.PobCen = 'Cartagena';

-- 7.f Cuantos empleados tienen habilidades.
select COUNT(*) as 'Empleados con habilidades' from empleado 
    where CodEmp in (select CodEmp from habemp);

-- 7.g Cuantos empleados no tienen habilidades.
select COUNT(*) as 'Empleados sin habilidades' from empleado e
    where e.CodEmp not in (select CodEmp from habemp);

