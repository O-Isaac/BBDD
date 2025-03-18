CREATE OR REPLACE TABLE directivo AS
SELECT e.CodEmp, e.NomEmp, d.CodDep, d.NomDep, d.TiDir
    from empleado e join departamento d on d.CodEmpDir = e.CodEmp
    where d.TiDir = "P";

INSERT directivo
SELECT e.CodEmp, e.NomEmp, d.CodDep, d.NomDep, d.TiDir
    from empleado e join departamento d on d.CodEmpDir = e.CodEmp
    where d.TiDir = "F";


DELETE from directivo
WHERE `CodEmp` not in (
    select `CodEmp` from empleado where `NumHi` = 0
);

select * from empleado
    where `CodEmp` in (select `CodEmp` from directivo);

CREATE FULLTEXT INDEX idx_nombre_empleado ON empleado(NomEmp);

CREATE INDEX idx_dep_tidir ON departamento(TiDir);

EXPLAIN SELECT `NomEmp`, `NomDep` FROM empleado e
    JOIN departamento d using (`CodDep`)
    WHERE d.`TiDir` = "P";


SHOW INDEX FROM departamento;

DROP INDEX idx_dep_tidir ON departamento;

CREATE USER ocasional IDENTIFIED BY 'ocasional';

GRANT SELECT ON empresa.directivo TO admin

CREATE USER admin IDENTIFIED BY 'admin'

GRANT ALL PRIVILEGES ON *.* TO admin WITH GRANT OPTION

REVOKE ALL PRIVILEGES ON *.* FROM admin

REVOKE SELECT ON empresa.directivo FROM admin


CREATE ROLE desarrollador

GRANT ALL PRIVILEGES ON empresa.* to desarrollador

SHOW GRANTS for desarrollador

GRANT desarrollador to admin
