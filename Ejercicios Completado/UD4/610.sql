-- Muestra para cada departamento, su nombre, presupuesto y el nombre del centro al que pertenece

select d.NomDep, d.PreAnu, c.NomCen from departamento d
    inner join centro c on d.CodCen = c.CodCen;

-- Muestra para cada departamento, su nombre, presupuesto y el nombre del empleado que lo dirige.

select d.NomDep, d.PreAnu, e.NomEmp as Director from departamento d
    inner join empleado e on e.CodEmp = d.CodEmpDir;

-- Muestra para cada departamento, su nombre, presupuesto, el nombre del centro al que pertenece y el nombre del empleado que lo dirige.

select d.NomDep, d.PreAnu, c.NomCen, e.NomEmp from departamento d
    inner join centro c on d.CodCen = c.CodCen
    inner join empleado e on c.CodEmpDir = e.CodEmp;


-- Muestra el nombre del departamento, el nombre del centro al que pertenece y el nombre del empleado que lo dirige, de aquel departamento que tenga el presupuesto más alto.

select d.NomDep, MAX(d.PreAnu) as PreAnu, c.NomCen, e.NomEmp from departamento d
    inner join centro c on d.CodCen = c.CodCen
    inner join empleado e on c.CodEmpDir = e.CodEmp;

-- Listar los empleados del centro Fábrica Zona Sur.

select c.NomCen, e.* from departamento d
    inner join empleado e on e.CodDep = d.CodDep
    inner join centro c on c.CodCen = d.CodCen
    where c.NomCen = 'Fábrica Zona Sur';

-- Listar el nombre del empleado y el nombre y fecha de nacimiento de su hijo/hija para aquellos empleados con un único hijo. Ordenar por fecha de nacimiento de los hijos.

select e.NomEmp, h.NomHi, h.FecNaHi from empleado e
    inner join hijo h on h.CodEmp = e.CodEmp
    where e.NumHi = 1
    order by h.FecNaHi desc;

-- Usando los operadores de conjuntos, recupera:
--  1. el código de departamento para aquellos departamentos que tienen empleados.
    
    select distinct d.CodDep from departamento d
        inner join empleado e ON d.CodDep = e.CodDep;

--  2. el código de departamento para aquellos departamentos que no tienen empleados.

    select distinct d.CodDep, e.* from departamento d
        left join empleado e ON d.CodDep = e.CodDep
        where e.CodDep is null; 

--  3. los empleados que no son directivos de ningún departamento (no aparecen en departamento.CodEmpDir).
    
    select e.* from empleado e
        left join departamento d on d.CodEmpDir = e.CodEmp
        where CodEmpDir is null;

--  4. los empleados que no son directivos de ningún departamento ni de ningún centro
    
    select e.* from empleado e
        left join departamento d on d.CodEmpDir = e.CodEmp
        left join centro c on d.CodCen = c.CodCen
        where c.CodEmpDir is null and d.CodEmpDir is null;

-- Recupera los empleados que trabajan en Oficinas Zona Sur y que tienen hijos.

    select e.* from empleado e
        inner join departamento d on e.CodDep = d.CodDep
        inner join centro c on c.CodCen = d.CodCen
        where e.NumHi > 0 and c.NomCen = 'Oficinas Zona Sur';

-- Recupera los departamentos que tienen empleados con la habilidad Fontanería.

    select d.* from departamento d
        inner join empleado e on d.CodDep = e.CodDep
        left join habemp ha on ha.CodEmp = e.CodEmp
        left join habilidad sk on sk.CodHab = ha.CodHab
        where sk.DesHab = 'Fontanería';

-- Recupera todos los departamentos que dependen de un departamento secundario.

    select * from departamento where CodDepDep is not null;