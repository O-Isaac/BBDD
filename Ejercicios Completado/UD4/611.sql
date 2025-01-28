-- Muestra un listado de todas las habilidades, y si tienen, el código del empleado y el nivel de su habilidad.

select * from habilidad s 
    left join habemp h on h.CodHab = s.CodHab;

-- Muestra un listado de las habilidades que no tiene ningún empleado.

select * from habilidad s 
    left join habemp h on h.CodHab = s.CodHab
    where h.CodEmp is null;

-- Comprueba si los empleados que no tienen hijos (empleado.NumHi) coinciden con los empleados no tienen hijos relacionados (tabla hijo).

select e.* from empleado e
    where e.NumHi = 0 and e.CodEmp not in (select CodEmp from hijo);


select * from empleado e
    left join hijo h on h.CodEmp = e.CodEmp;