-- Para cada empleado, muestra su nombre, edad, y la edad media del centro donde trabaja.
select  
    NomEmp, 
    TIMESTAMPDIFF(YEAR, FecNaEmp, NOW()) as 'Edad', 
    AVG(TIMESTAMPDIFF(YEAR, FecNaEmp, NOW())) over (partition by d.CodCen) as 'Edad Media' 
from empleado
    inner join departamento d using (CodDep);

-- Muestra para cada empleado, su código de departamento, nombre, salario, el salario promedio de su departamento, y 
-- Por encima o Por debajo si el empleado cobra más que su departamento.
select 
    CodDep,
    NomEmp, 
    SalEmp, 
    LEAD(SalEmp) OVER (PARTITION BY CodDep ORDER BY SalEmp DESC) as SalSig,
    AVG(SalEmp) over (partition by CodDep) as 'SalEmpAvg',
    LAG(SalEmp) OVER (PARTITION BY CodDep ORDER BY SalEmp DESC) as SalAnt
from empleado;

-- Máximo y mínimo salario por tipo de director de departamento.
select 
    e.NomEmp,
    d.TIDir,
    MAX(e.SalEmp) over(partition by d.TiDir),
    MIN(e.SalEmp) over(partition by d.TiDir)
from departamento d
    inner join empleado e on d.CodEmpDir = e.CodEmp; 

-- Para cada empleado, además de su nombre y el nombre del departamento, su salario, el salario máximo y la diferencia entre ellos.
select 
    e.NomEmp, 
    d.NomDep, 
    e.SalEmp,
    MAX(e.SalEmp) over(),
    e.SalEmp - LAG(e.SalEmp) OVER (PARTITION BY CodDep ORDER BY e.SalEmp DESC) as DiffSalEmp
from empleado e
    inner join departamento d using (CodDep);

-- Ranking de antigüedad de los empleados en la empresa por centro
select 
    RANK() OVER (PARTITION BY CodCen ORDER BY FecInEmp DESC) as RanEmp, 
    e.CodEmp, 
    e.NomEmp 
from empleado e
    inner join departamento d using (CodDep)
    inner join centro c using (CodCen);

-- Comparación de fechas de incorporación: tiempo transcurrido entre empleados del mismo departamento.

select 
    CodDep,
    NomEmp,
    FecInEmp,
    LEAD(FecInEmp) OVER (partition by CodDep ORDER BY FecInEmp) as 'Fecha Siguiente',
    TIMESTAMPDIFF(DAY, LEAD(FecInEmp) OVER (partition by CodDep ORDER BY FecInEmp DESC), FecInEmp) as 'Dias Hasta Siguiente'
from empleado
    ORDER BY CodDep, FecInEmp;

