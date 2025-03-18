DELIMITER $$ -- Cambia el delimitador para que la sentencia se ejecute correctamente

-- Cantidad de empelados
CREATE PROCEDURE cantidadEmpleados()
    COMMENT "Cantidad de empleados"
BEGIN
    SELECT count(*) from empleado;
END $$

-- Saludo
CREATE PROCEDURE saludo(IN nombre VARCHAR(128), OUT saludo VARCHAR(128))
    COMMENT "Un saludito no hace daño"
BEGIN
    set saludo = CONCAT("Hola ", nombre);
END $$


CREATE PROCEDURE empleadosDepartamentos(IN codigoDepartamento CHAR(5))
    COMMENT "Obten empleados de un departamento"
BEGIN
    select * from empleado where CodDep = codigoDepartamento;
END $$

DELIMITER ; -- Despues vuelve a la normalidad

call empleadosDepartamentos('ADMZS')

