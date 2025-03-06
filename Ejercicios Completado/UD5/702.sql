-- Listar para cada departamento, su código, nombre, salario mínimo, máximo y medio.
select d.NomDep, d.CodDep, MAX(*), MIN(*), AVG(e.SalEmp) from departamento d
    inner join empleado e on d.CodDep = e.CodDep
    group by d.NomDep, d.CodDep;

-- Obtener, para cada empleado (mostrando su código y nombre), cuantas habilidades tiene.
-- Obtener, para cada departamento (mostrando su código y nombre), la cantidad de habilidades que tienen sus empleados.
-- Obtener, para cada centro (mostrando su código y nombre), la cantidad de habilidades que tienen sus empleados.
-- Obtener, para cada departamento y centro (mostrando sus códigos y nombres), la cantidad de habilidades que tienen sus empleados, mostrando los datos acumulados.
-- Listar el salario medio por centro para aquellos departamentos con más de 25 millones de presupuesto. Indicar el nombre del centro. Ordenar de manera descendente por el salario medio.
-- Obtener para cada ciudad donde se sitúen los departamentos, el total de salario de sus empleados, mostrando también el total acumulado.
