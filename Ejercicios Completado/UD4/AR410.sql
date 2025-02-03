-- Ejercicio 4.1.1: Obtener los nombres de los departamentos cuyo director lo es en
-- funciones y no en propiedad, ordenados alfabéticamente.

select distinct NomDep from departamento 
    where TiDir = 'F' 
    order by NomDep asc;

-- Ejercicio 4.1.2: Obtener un listín telefónico de los empleados del departamento
-- 121, incluyendo nombre, número de empleado y extensión telefónica, ordenados
-- alfabéticamente.

select NomEmp, CodEmp, ExTelEmp from empleado 
    where CodDep = 'PROZS' 
    and ExTelEmp is not null 
    order by NomEmp asc;

-- Ejercicio 4.1.3: Obtener una relación de todos los números de extensiones
-- telefónicas de los empleados del departamento VENZS, junto con el nombre de los
-- empleados, ordenados por extensión.

select NomEmp, ExTelEmp from empleado
    where CodDep = 'VENZS'
    order by ExTelEmp asc;

-- Ejercicio 4.1.4 Obtener la comisión, nombre y salario de los empleados que tiene
-- un hijos, ordenados por comisión y dentro de esta por orden alfabético.

select comision, NomEmp, SalEmp from empleado
    where NumHi > 0
    order by comision asc, NomEmp asc;

-- Ejercicio 4.1.5 Obtener las distintas comisiones que hay en el departamento 110.

select distinct comision from empleado where CodDep = 'VENZS';

-- Ejercicio 4.1.6. Obtener los números de los departamentos donde trabajan
-- empleados cuyo salario sea inferior a 1500 €

select CodDep, SalEmp:=SalEmp from empleado where SalEmp:=SalEmp < 1800000;

-- Ejercicio 4.1.7.Hallar la comisión, nombre y salario de los empleados que tienen
-- hijos, clasificados por comisión, y dentro de comisión por orden alfabético, para
-- aquellos empleados que tienen comisión

select comision, NomEmp, SalEmp:=SalEmp from empleado
    where NumHi > 0
    order by comision;

-- Ejercicio 4.2.1: Obtener una relación alfabética de los departamentos cuyo
-- presupuesto es inferior a 26.000.000 , precedidos de "DEPARTAMENTO DE".

select concat('Departamento de ', NomDep) as departamento from departamento
    where PreAnu < 26000000;

-- Ejercicio 4.2.2: Mostrar el número y nombre de cada departamento separados por
-- un guion en un solo campo llamado "Número-Nombre", además del tipo de
-- director mostrado como "Tipo de Director" para departamentos con presupuesto
-- menor a 7.000.000.

select 
    concat(CodDep, "-", NomDep) as 'Numero-Nombre',
    TiDir as 'Tipo de director'
from departamento
where PreAnu < 7000000;


-- Ejercicio 4.2.4:Hallar, por orden alfabético, los nombres de los empleados tales
-- que si se les da una gratificación de 120 € por hijo, el total de esta gratificación
-- supera el 20% de su salario.

select NomEmp from empleado
    where (120 * NumHi) > (0.20 * SalEmp)
    order by NomEmp asc;

-- Ejercicio 4.2.3: Suponiendo que el próximo año el coste de vida va a aumentar un
-- 8% anual y que se suben los salarios solo un 2% anual, hallar para los empleados
-- con más de 1 hijo, su nombre y su sueldo anual actual y para el próximo año,
-- clasificados por orden alfabético. Muestra la consulta tal y como aparece en la
-- captura.

select 
    NomEmp as Nombre, 
    SalEmp as 'Salario 2025', 
    @SalEmp:=SalEmp+(SalEmp*0.2) as 'Salario 2026' 
from empleado where NumHi > 1;

-- Ejercicio 4.2.5: Para los empleados del departamento PROZS hallar el nombre y el
-- salario total (salario más comisión), por orden de salario total decreciente, y por
-- orden alfabético dentro de salario total.

select 
    NomEmp as Nombre, 
    @SalTotal:=SalEmp + (SalEmp * (0.01 * comision)) as 'Salario Total' 
from empleado
where CodDep = 'PROZS'
order by @SalTotal desc, NomEmp asc;

-- Ejercicio 4.2.6. Realiza la misma consulta pero el salario debe de aparecer con la
-- moneda . Es decir 1200€

select 
    NomEmp as Nombre, 
    concat(@SalTotal:=SalEmp + (SalEmp * (0.01 * comision)), "€") as 'Salario Total' 
from empleado
where CodDep = 'PROZS'
order by @SalTotal desc, NomEmp asc;

-- Ejercicio 4.2.7.En una campaña de ayuda familiar se ha decidido dar a los
-- empleados una paga extra de 600 € por hijo, a partir del segundo inclusive.
-- Obtener por orden alfabético para estos empleados: nombre y salario total que
-- van a cobrar incluyendo esta paga extra.

select NomEmp as Nombre, SalEmp + (NumHi * 600) as 'Salario Total' 
    from empleado where NumHi > 0
    order by NomEmp;

-- Ejemplo 4.2.8: Introducción a SELECT subordinado. Imaginemos la misma
-- consulta anterior, pero en la que se nos pide mostrar los mismos campos pero
-- para aquellos empleados cuyo número de hijos iguale o supere a los de Eloísa
-- Mascullas. Es decir, Eloísa tiene 1 hijo pero no lo sabemos. Lo que sabemos es el
-- nombre. En este caso haremos otro SELECT cuyo resultado de la búsqueda sea el
-- número de hijos de Eloísa.
select NomEmp as Nombre, SalEmp + (NumHi * 600) as 'Salario Total' 
    from empleado where NumHi > (select NumHi from empleado where CodEmp = 8)
    order by NomEmp;


-- Ejemplo 4.2.9: Obtener por orden alfabético los nombres de los empleados cuyos
-- sueldos igualan o superan al de Eloísa Mascullas en más del 15%

select NomEmp as Nombre from empleado 
    where SalEmp > (select SalEmp + (SalEmp * 0.15) from empleado where CodEmp = 8)
    order by NomEmp asc;

-- Ejercicio 4.3.1: Obtener los nombres de los empleados cuyo salario supera al
-- máximo salario de los empleados del departamento .

select NomEmp, SalEmp, @EmpCodDep:=CodDep as Nombre from empleado 
    where SalEmp > (select MAX(SalEmp) from empleado where CodDep != @EmpCodDep);
