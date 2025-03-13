
-- empleado_anyos: Para cada empleado, mostrar, además de su código y nombre, su edad (EdadEmp) y los años de antigüedad en la empresa (AntEmp).

CREATE VIEW empleado_anyos AS
    SELECT 
        CodEmp, 
        NomEmp,
        TIMESTAMPDIFF(YEAR, FecNaEmp, NOW()) as EdadEmp,
        TIMESTAMPDIFF(YEAR, FecInEmp, NOW()) as AntEmp
    FROM empleado;

-- centro_presupuesto: Para cada centro, además de su código y nombre, mostrar su presupuesto anual (CenPreAnu), y el código (CodDir) y el nombre (NomDir) de su director.

CREATE VIEW centro_presupuesto AS
    SELECT DISTINCT
        c.`CodCen`, 
        c.`NomCen`, 
        SUM(d.`PreAnu`) OVER (PARTITION BY c.`CodCen`) as CenPreAnu,
        e.`CodEmp` as 'CodDir',
        e.`NomEmp`as 'NomDir'
    FROM centro c
        inner join departamento d using (CodCen)
        inner join empleado e on c.CodEmpDir = e.CodEmp


-- empleado_habilidades_total: Para cada empleado, además de su código y nombre, el código y nombre de su departamento, y muestre una columna con el total de habilidades de dicho empleado (NumHab) (si no tiene habilidades, debe aparecer el empleado, pero con dicho valor a 0).

CREATE VIEW empleado_habilidades_total AS 
    SELECT DISTINCT
        e.`CodEmp`, 
        e.`NomEmp`,
        d.`CodDep`,
        d.`NomDep`,
        COUNT(h.`CodHab`)
    from empleado e
        LEFT JOIN departamento d USING (`CodDep`)
        LEFT JOIN habemp h USING (`CodEmp`)
    GROUP BY e.`CodEmp`, e.`NomEmp`


-- departamento_jerarquia: Para cada departamento, además del código y el nombre, muestre el código (CodDepSup)y el nombre (NomDepSup) de su departamento superior si lo tienen (deben aparecer todos los departamentos).

CREATE VIEW departamento_jerarquia AS 
    SELECT 
        d.`CodDep`,
        d.`NomDep`,
        dsup.`CodDep` as CodDepSup,
        dsup.`NomDep` as NomDepSup
    FROM departamento d
        LEFT JOIN departamento dsup on d.`CodDepDep` = dsup.`CodDep`