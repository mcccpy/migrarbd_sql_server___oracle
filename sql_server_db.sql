
-- 1. FACULTADES
CREATE TABLE Facultades (
    id_facultad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150)
);

-- 2. EDIFICIOS
CREATE TABLE Edificios (
    id_edificio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo VARCHAR(20) UNIQUE NOT NULL
);

-- 3. ROLES
CREATE TABLE Roles (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- 4. PERMISOS
CREATE TABLE Permisos (
    id_permiso INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- 5. USUARIOS
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

-- 6. PERMISOS_ROLES (Tabla intermedia)
CREATE TABLE Roles_Permisos (
    id_rol INT NOT NULL,
    id_permiso INT NOT NULL,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES Permisos(id_permiso)
);

-- 7. DEPARTAMENTOS ACADÉMICOS
CREATE TABLE Departamentos (
    id_departamento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_facultad INT NOT NULL,
    FOREIGN KEY (id_facultad) REFERENCES Facultades(id_facultad)
);

-- 8. CARRERAS
CREATE TABLE Carreras (
    id_carrera INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_facultad INT NOT NULL,
    FOREIGN KEY (id_facultad) REFERENCES Facultades(id_facultad)
);

-- 9. PLANES DE ESTUDIO
CREATE TABLE Planes_Estudio (
    id_plan INT IDENTITY(1,1) PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    anio_vigencia INT NOT NULL,
    id_carrera INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

-- 10. ESTUDIANTES
CREATE TABLE Estudiantes (
    id_estudiante INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    id_carrera INT NOT NULL,
    id_usuario INT UNIQUE,
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 11. DOCENTES
CREATE TABLE Docentes (
    id_docente INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    id_usuario INT UNIQUE,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 12. PERSONAL ADMINISTRATIVO
CREATE TABLE Personal_Administrativo (
    id_personal INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    id_usuario INT UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 13. ASIGNATURAS
CREATE TABLE Asignaturas (
    id_asignatura INT IDENTITY(1,1) PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    id_plan INT NOT NULL,
    FOREIGN KEY (id_plan) REFERENCES Planes_Estudio(id_plan)
);

-- 14. AULAS
CREATE TABLE Aulas (
    id_aula INT IDENTITY(1,1) PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    capacidad INT NOT NULL,
    id_edificio INT NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 15. CURSOS
CREATE TABLE Cursos (
    id_curso INT IDENTITY(1,1) PRIMARY KEY,
    periodo_academico VARCHAR(20) NOT NULL,
    id_asignatura INT NOT NULL,
    id_docente INT NOT NULL,
    FOREIGN KEY (id_asignatura) REFERENCES Asignaturas(id_asignatura),
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente)
);

-- 16. HORARIOS
CREATE TABLE Horarios (
    id_horario INT IDENTITY(1,1) PRIMARY KEY,
    dia_semana VARCHAR(15) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    id_curso INT NOT NULL,
    id_aula INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_aula) REFERENCES Aulas(id_aula)
);

-- 17. INSCRIPCIONES
CREATE TABLE Inscripciones (
    id_inscripcion INT IDENTITY(1,1) PRIMARY KEY,
    fecha_inscripcion DATE NOT NULL,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- 18. NOTAS
CREATE TABLE Notas (
    id_nota INT IDENTITY(1,1) PRIMARY KEY,
    calificacion DECIMAL(4,2) NOT NULL,
    tipo_evaluacion VARCHAR(50) NOT NULL,
    id_inscripcion INT NOT NULL,
    FOREIGN KEY (id_inscripcion) REFERENCES Inscripciones(id_inscripcion)
);

-- 19. CALENDARIO ACADÉMICO
CREATE TABLE Calendario_Academico (
    id_calendario INT IDENTITY(1,1) PRIMARY KEY,
    evento VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    periodo VARCHAR(20) NOT NULL
);

-- 20. EXÁMENES
CREATE TABLE Examenes (
    id_examen INT IDENTITY(1,1) PRIMARY KEY,
    tipo_examen VARCHAR(50) NOT NULL,
    fecha_examen DATETIME NOT NULL,
    id_curso INT NOT NULL,
    id_aula INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_aula) REFERENCES Aulas(id_aula)
);

-- 21. RESULTADOS EXÁMENES
CREATE TABLE Resultados_Examenes (
    id_resultado INT IDENTITY(1,1) PRIMARY KEY,
    nota_obtenida DECIMAL(4,2) NOT NULL,
    id_examen INT NOT NULL,
    id_estudiante INT NOT NULL,
    FOREIGN KEY (id_examen) REFERENCES Examenes(id_examen),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 22. BIBLIOTECA
CREATE TABLE Biblioteca (
    id_biblioteca INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_edificio INT NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 23. LIBROS
CREATE TABLE Libros (
    id_libro INT IDENTITY(1,1) PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    id_biblioteca INT NOT NULL,
    FOREIGN KEY (id_biblioteca) REFERENCES Biblioteca(id_biblioteca)
);

-- 24. PRÉSTAMOS BIBLIOTECA
CREATE TABLE Prestamos_Biblioteca (
    id_prestamo INT IDENTITY(1,1) PRIMARY KEY,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    id_libro INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 25. LABORATORIOS
CREATE TABLE Laboratorios (
    id_laboratorio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_edificio INT NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 26. EQUIPOS LABORATORIO
CREATE TABLE Equipos_Laboratorio (
    id_equipo INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(50) UNIQUE NOT NULL,
    id_laboratorio INT NOT NULL,
    FOREIGN KEY (id_laboratorio) REFERENCES Laboratorios(id_laboratorio)
);

-- 27. INVESTIGACIONES
CREATE TABLE Investigaciones (
    id_investigacion INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    linea_investigacion VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
);

-- 28. PROYECTOS
CREATE TABLE Proyectos (
    id_proyecto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    presupuesto DECIMAL(12,2),
    id_investigacion INT NOT NULL,
    id_docente INT NOT NULL,
    FOREIGN KEY (id_investigacion) REFERENCES Investigaciones(id_investigacion),
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente)
);

-- 29. PUBLICACIONES
CREATE TABLE Publicaciones (
    id_publicacion INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    revista_o_editorial VARCHAR(100) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    id_investigacion INT NOT NULL,
    FOREIGN KEY (id_investigacion) REFERENCES Investigaciones(id_investigacion)
);

-- 30. EVENTOS ACADÉMICOS
CREATE TABLE Eventos_Academicos (
    id_evento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    fecha_evento DATE NOT NULL,
    id_edificio INT NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 31. CONFERENCIAS
CREATE TABLE Conferencias (
    id_conferencia INT IDENTITY(1,1) PRIMARY KEY,
    tema VARCHAR(150) NOT NULL,
    expositor VARCHAR(100) NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos_Academicos(id_evento)
);

-- 32. SEMINARIOS
CREATE TABLE Seminarios (
    id_seminario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    duracion_horas INT NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos_Academicos(id_evento)
);

-- 33. PAGOS MATRÍCULA
CREATE TABLE Pagos_Matricula (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    id_estudiante INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 34. BECAS
CREATE TABLE Becas (
    id_beca INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    porcentaje_cobertura DECIMAL(5,2) NOT NULL,
    id_estudiante INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 35. FINANZAS
CREATE TABLE Finanzas (
    id_finanza INT IDENTITY(1,1) PRIMARY KEY,
    tipo_transaccion VARCHAR(50) NOT NULL, -- Ingreso / Egreso
    monto DECIMAL(12,2) NOT NULL,
    fecha DATETIME NOT NULL,
    id_pago INT,
    FOREIGN KEY (id_pago) REFERENCES Pagos_Matricula(id_pago)
);

-- 36. SEGURIDAD
CREATE TABLE Seguridad (
    id_seguridad INT IDENTITY(1,1) PRIMARY KEY,
    zona_asignada VARCHAR(100) NOT NULL,
    turno VARCHAR(30) NOT NULL,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES Personal_Administrativo(id_personal)
);

-- 37. ACCESOS
CREATE TABLE Accesos (
    id_acceso INT IDENTITY(1,1) PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    punto_acceso VARCHAR(50) NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 38. AUDITORÍA
CREATE TABLE Auditoria (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    accion_realizada VARCHAR(255) NOT NULL,
    tabla_afectada VARCHAR(50) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 39. TITULACIONES
CREATE TABLE Titulaciones (
    id_titulacion INT IDENTITY(1,1) PRIMARY KEY,
    fecha_titulacion DATE NOT NULL,
    modalidad VARCHAR(50) NOT NULL,
    id_estudiante INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 40. GRADUADOS
CREATE TABLE Graduados (
    id_graduado INT IDENTITY(1,1) PRIMARY KEY,
    anio_graduacion INT NOT NULL,
    id_estudiante INT UNIQUE NOT NULL,
    id_titulacion INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_titulacion) REFERENCES Titulaciones(id_titulacion)
);

-- 41. EMPRESAS ASOCIADAS
CREATE TABLE Empresas_Asociadas (
    id_empresa INT IDENTITY(1,1) PRIMARY KEY,
    razon_social VARCHAR(150) NOT NULL,
    ruc_nit VARCHAR(20) UNIQUE NOT NULL,
    contacto VARCHAR(100)
);

-- 42. CONVENIOS
CREATE TABLE Convenios (
    id_convenio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES Empresas_Asociadas(id_empresa)
);

-- 43. INTERCAMBIOS ESTUDIANTILES
CREATE TABLE Intercambios_Estudiantiles (
    id_intercambio INT IDENTITY(1,1) PRIMARY KEY,
    universidad_destino VARCHAR(150) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    id_estudiante INT NOT NULL,
    id_convenio INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_convenio) REFERENCES Convenios(id_convenio)
);

-- 44. PRÁCTICAS PROFESIONALES
CREATE TABLE Practicas_Profesionales (
    id_practica INT IDENTITY(1,1) PRIMARY KEY,
    horas_acumuladas INT NOT NULL,
    estado VARCHAR(30) NOT NULL,
    id_estudiante INT NOT NULL,
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_empresa) REFERENCES Empresas_Asociadas(id_empresa)
);

-- 45. EVALUACIONES DOCENTES Y ENCUESTAS ESTUDIANTILES
CREATE TABLE Evaluaciones_Docentes (
    id_evaluacion INT IDENTITY(1,1) PRIMARY KEY,
    puntaje DECIMAL(3,2) NOT NULL,
    comentario TEXT,
    id_docente INT NOT NULL,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- 1. FACULTADES
INSERT INTO Facultades (nombre,ubicacion)
SELECT TOP 3000 CONCAT('Nombre_Facultad',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CASE 
    WHEN CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 10) + 1 AS INT) % 2 = 0 THEN CONCAT('Ubicacion #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL)))
    ELSE NULL
END
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 2. EDIFICIOS
INSERT INTO Edificios (nombre,codigo)
SELECT TOP 3000 CONCAT('Nombre_Edificios #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('cod_edf_',ROW_NUMBER() OVER (ORDER BY (SELECT NULL)))
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 3. ROLES
INSERT INTO Roles (nombre,descripcion)
SELECT TOP 3000 CONCAT('Nombre_Rol',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CASE 
    WHEN CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 10) + 1 AS INT) % 2 = 0 THEN CONCAT('descrip #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL)))
    ELSE NULL
END
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 4. PERMISOS
INSERT INTO Permisos (nombre,descripcion)
SELECT TOP 3000 CONCAT('Nombre_Permisos',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CASE 
    WHEN CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 10) + 1 AS INT) % 2 = 0 THEN CONCAT('descrip #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL)))
    ELSE NULL
END
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 5. USUARIOS
INSERT INTO Usuarios (username,password_hash,email,id_rol)
SELECT TOP 3000 CONCAT('Nombre_Usuarios',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('password_hash #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('email #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 6. PERMISOS_ROLES (Tabla intermedia)
INSERT INTO Roles_Permisos (id_rol,id_permiso)
SELECT TOP 3000 
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)////////////////////////////////////////////
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 7. DEPARTAMENTOS ACADÉMICOS
INSERT INTO Departamentos (nombre,id_facultad)
SELECT TOP 3000 
CONCAT('Nombre_Departamentos',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 8. CARRERAS
INSERT INTO Carreras (nombre,id_facultad)
SELECT TOP 3000 
CONCAT('Nombre_Carreras',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 9. PLANES DE ESTUDIO
INSERT INTO Planes_Estudio (codigo,anio_vigencia,id_carrera)
SELECT TOP 3000 
CONCAT('Planes_Estudio',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 26) + 1 AS INT)+2000,
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 10. ESTUDIANTES
INSERT INTO Estudiantes (nombres, apellidos, dni, fecha_nacimiento, id_carrera, id_usuario)
SELECT TOP 3000 
CONCAT('Nombre_Estudiantes',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('apellidos_Estudiantes',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('dni #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 11. DOCENTES
INSERT INTO Docentes (nombres, apellidos, id_departamento, id_usuario)
SELECT TOP 3000 
CONCAT('Nombre_Docentes',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('apellidos_Docentes',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 12. PERSONAL ADMINISTRATIVO
INSERT INTO Personal_Administrativo (nombres, apellidos, cargo, id_usuario)
SELECT TOP 3000 
CONCAT('Nombre_Administrativo',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('apellidos_Administrativo',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('cargo #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 13. ASIGNATURAS
INSERT INTO Asignaturas (codigo, nombre, creditos, id_plan)
SELECT TOP 3000 
CONCAT('cod #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('Nombre_Asignaturas',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 100) + 1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 14. AULAS
INSERT INTO Aulas (codigo, capacidad, id_edificio)
SELECT TOP 3000 
CONCAT('cod #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 100) + 1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 15. CURSOS
INSERT INTO Cursos (periodo_academico, id_asignatura, id_docente)
SELECT TOP 3000 
CONCAT('periodo #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 16. HORARIOS
INSERT INTO Horarios (dia_semana, hora_inicio, hora_fin, id_curso, id_aula)
SELECT TOP 3000 
CONCAT('dia #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 86400 AS INT), '01:30:00') AS TIME),
CAST(DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 86400 AS INT), '02:30:00') AS TIME),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 17. INSCRIPCIONES
INSERT INTO Inscripciones (fecha_inscripcion, id_estudiante, id_curso)
SELECT TOP 3000 
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 18. NOTAS
INSERT INTO Notas (calificacion, tipo_evaluacion, id_inscripcion)
SELECT TOP 3000 
CAST(RAND(CHECKSUM(NEWID())) * 99.98 AS DECIMAL(4, 2)),
CONCAT('tipo',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 19. CALENDARIO ACADÉMICO
INSERT INTO Calendario_Academico (evento, fecha_inicio, fecha_fin, periodo)
SELECT TOP 3000 
CONCAT('evento #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CONCAT('periodo#',ROW_NUMBER() OVER (ORDER BY (SELECT NULL)))
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 20. EXÁMENES
INSERT INTO Examenes (tipo_examen, fecha_examen, id_curso, id_aula)
SELECT TOP 3000 
CONCAT('examen',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 31556952 AS INT), '2000-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 21. RESULTADOS EXÁMENES
INSERT INTO Resultados_Examenes (nota_obtenida, id_examen, id_estudiante)
SELECT TOP 3000 
CAST(RAND(CHECKSUM(NEWID())) * 100 AS DECIMAL(4, 2)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 22. BIBLIOTECA
INSERT INTO Biblioteca (nombre, id_edificio)
SELECT TOP 3000 
CONCAT('Nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 23. LIBROS
INSERT INTO Libros (isbn, titulo, autor, id_biblioteca)
SELECT TOP 3000 
CONCAT('isbn#',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('titulo#',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('autor#',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 24. PRÉSTAMOS BIBLIOTECA
INSERT INTO Prestamos_Biblioteca (fecha_prestamo, fecha_devolucion, id_libro, id_usuario)
SELECT TOP 3000 
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CASE 
    WHEN CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 10) + 1 AS INT) % 2 = 0 THEN DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01')
    ELSE NULL
END,
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 25. LABORATORIOS
INSERT INTO Laboratorios (nombre, id_edificio)
SELECT TOP 3000 
CONCAT('Nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 26. EQUIPOS LABORATORIO
INSERT INTO Equipos_Laboratorio (nombre, numero_serie, id_laboratorio)
SELECT TOP 3000 
CONCAT('Nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('Serie#',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 27. INVESTIGACIONES
INSERT INTO Investigaciones (titulo, linea_investigacion, id_departamento)
SELECT TOP 3000 
CONCAT('titulo',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('linea_investigacion#',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 28. PROYECTOS
INSERT INTO Proyectos (nombre, presupuesto, id_investigacion, id_docente)
SELECT TOP 3000 
CONCAT('nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(RAND(CHECKSUM(NEWID())) * 10000 AS DECIMAL(12, 2)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 29. PUBLICACIONES
INSERT INTO Publicaciones (titulo, revista_o_editorial, fecha_publicacion, id_investigacion)
SELECT TOP 3000 
CONCAT('titulo #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('revista_editorial #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 30. EVENTOS ACADÉMICOS
INSERT INTO Eventos_Academicos (nombre, fecha_evento, id_edificio)
SELECT TOP 3000 
CONCAT('nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 31. CONFERENCIAS
INSERT INTO Conferencias (tema, expositor, id_evento)
SELECT TOP 3000 
CONCAT('tema #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('expocicion #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 32. SEMINARIOS
INSERT INTO Seminarios (nombre, duracion_horas, id_evento)
SELECT TOP 3000 
CONCAT('nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 30) + 1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 33. PAGOS MATRÍCULA
INSERT INTO Pagos_Matricula (monto, fecha_pago, metodo_pago, id_estudiante)
SELECT TOP 3000 
CAST(RAND(CHECKSUM(NEWID())) * 3000 AS DECIMAL(10,2)),
DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 31556952 AS INT), '2000-01-01'),
CONCAT('metodo',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3) + 1 AS INT)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 34. BECAS
INSERT INTO Becas (nombre, porcentaje_cobertura, id_estudiante)
SELECT TOP 3000 
CONCAT('nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(RAND(CHECKSUM(NEWID())) * 100 AS DECIMAL(5, 2)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 35. FINANZAS
INSERT INTO Finanzas (tipo_transaccion, monto, fecha, id_pago)
SELECT TOP 3000 
CONCAT('tipo#',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 2) + 1 AS INT)),
CAST(RAND(CHECKSUM(NEWID())) * 3000 AS DECIMAL(12, 2)),
DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 31556952 AS INT), '2000-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 36. SEGURIDAD
INSERT INTO Seguridad (zona_asignada, turno, id_personal)
SELECT TOP 3000 
CONCAT('zona #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('tuurno #',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 4) + 1 AS INT)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 37. ACCESOS
INSERT INTO Accesos (fecha_hora, punto_acceso, id_usuario)
SELECT TOP 3000 
DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 31556952 AS INT), '2000-01-01'),
CONCAT('punto #',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 400) + 1 AS INT)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 38. AUDITORÍA
INSERT INTO Auditoria (accion_realizada, tabla_afectada, fecha_hora, id_usuario)
SELECT TOP 3000 
CONCAT('accion #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('tabla #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(SECOND, CAST(RAND(CHECKSUM(NEWID())) * 31556952 AS INT), '2000-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 39. TITULACIONES
INSERT INTO Titulaciones (fecha_titulacion, modalidad, id_estudiante)
SELECT TOP 3000 
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CONCAT('modalidad ',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 4) + 1 AS INT)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 40. GRADUADOS
INSERT INTO Graduados (anio_graduacion, id_estudiante, id_titulacion)
SELECT TOP 3000 
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 26) + 1 AS INT)+2000,
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 41. EMPRESAS ASOCIADAS
INSERT INTO Empresas_Asociadas (razon_social, ruc_nit, contacto)
SELECT TOP 3000 
CONCAT('razon #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('nit_ruc #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('contacto #',ROW_NUMBER() OVER (ORDER BY (SELECT NULL)))
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 42. CONVENIOS
INSERT INTO Convenios (nombre, fecha_inicio, fecha_fin, id_empresa)
SELECT TOP 3000 
CONCAT('Nombre',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT), '2026-01-01'),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 43. INTERCAMBIOS ESTUDIANTILES
INSERT INTO Intercambios_Estudiantiles (universidad_destino, pais, id_estudiante, id_convenio)
SELECT TOP 3000 
CONCAT('uni_dest',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CONCAT('pais #',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 50) + 1 AS INT)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 44. PRÁCTICAS PROFESIONALES
INSERT INTO Practicas_Profesionales (horas_acumuladas, estado, id_estudiante, id_empresa)
SELECT TOP 3000 
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 24) + 1 AS INT),
CONCAT('Estado',CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3) + 1 AS INT)),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;

-- 45. EVALUACIONES DOCENTES Y ENCUESTAS ESTUDIANTILES
INSERT INTO Evaluaciones_Docentes (puntaje, comentario, id_docente, id_estudiante, id_curso)
SELECT TOP 3000 
CAST(RAND(CHECKSUM(NEWID())) *9  AS DECIMAL(3, 2)),
CONCAT('comment',ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT),
CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 3000)+1 AS INT)
FROM master..spt_values a
CROSS JOIN master..spt_values b;
