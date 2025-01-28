-- Muestra un listado de todas las habilidades, y si tienen, el código del empleado y el nivel de su habilidad.

    select * from habemp h
        left join habilidad s on h.CodHab = s.CodHab;

-- Muestra un listado de las habilidades que no tiene ningún empleado. (Aqui no entiendo la pregunta)
    
    select s.* from habemp h
        left join habilidad s on s.CodHab = h.CodHab
        where h.CodEmp is null;


-- Comprueba si los empleados que no tienen hijos (empleado.NumHi) coinciden con los empleados no tienen hijos relacionados (tabla hijo).

    select * from empleado 
        where NumHi = 0 and CodEmp not in (select CodEmp from hijo);

-- Obtén el nombre del empleado y el nombre del hijo, si tuviese, para todos los empleados.

    select e.NomEmp, h.NomHi from empleado e
        left join hijo h on h.CodEmp = e.CodEmp;

-- Mostrar un listado con todos los departamentos junto con los nombres de los departamentos de los cuales dependen (propiedad CodDepDep) (en el caso que dependan de alguno).

    select d.NomDep, s.NomDep from departamento d
        inner join departamento s on d.CodDepDep = s.CodDep;

-- Devuelve un listado de los empleados que no son directivos (usando joins) de departamentos.

    select e.* from empleado e
        left join departamento d on d.CodEmpDir = e.CodEmp
        where d.CodEmpDir is null;

-- Devuelve un listado de los empleados que no son directivos (usando joins) de ningún centro.

    select e.* from empleado e
        left join centro c on c.CodEmpDir = e.CodEmp
        where c.CodEmpDir is null;


-- Comprueba si tenemos centros que no tengan ningún departamento asignado.

    select * from centro
        where CodCen not in (select CodCen from departamento);

-- Devuelve un listado de los empleados que no son directivos de ningún tipo.

    select * from empleado
        where CodEmp not in (select CodEmpDir from departamento)
        and CodEmp not in (select CodEmpDir from centro);
        
