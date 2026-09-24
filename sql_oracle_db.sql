
-- 1. FACULTADES
CREATE TABLE Facultades (
    id_facultad NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    ubicacion VARCHAR2(150)
);

-- 2. EDIFICIOS
CREATE TABLE Edificios (
    id_edificio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    codigo VARCHAR2(20) UNIQUE NOT NULL
);

-- 3. ROLES
CREATE TABLE Roles (
    id_rol NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    descripcion CLOB 
);

-- 4. PERMISOS
CREATE TABLE Permisos (
    id_permiso NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    descripcion CLOB 
);

-- 5. USUARIOS
CREATE TABLE Usuarios (
    id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    id_rol NUMBER NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

-- 6. PERMISOS_ROLES (Tabla intermedia)
CREATE TABLE Roles_Permisos (
    id_rol NUMBER NOT NULL,
    id_permiso NUMBER NOT NULL,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES Permisos(id_permiso)
);

-- 7. DEPARTAMENTOS ACADÉMICOS
CREATE TABLE Departamentos (
    id_departamento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_facultad NUMBER NOT NULL,
    FOREIGN KEY (id_facultad) REFERENCES Facultades(id_facultad)
);

-- 8. CARRERAS
CREATE TABLE Carreras (
    id_carrera NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_facultad NUMBER NOT NULL,
    FOREIGN KEY (id_facultad) REFERENCES Facultades(id_facultad)
);

-- 9. PLANES DE ESTUDIO
CREATE TABLE Planes_Estudio (
    id_plan NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(20) NOT NULL,
    anio_vigencia NUMBER NOT NULL,
    id_carrera NUMBER NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

-- 10. ESTUDIANTES
CREATE TABLE Estudiantes (
    id_estudiante NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    dni VARCHAR2(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    id_carrera NUMBER NOT NULL,
    id_usuario NUMBER UNIQUE,
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 11. DOCENTES
CREATE TABLE Docentes (
    id_docente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    id_departamento NUMBER NOT NULL,
    id_usuario NUMBER UNIQUE,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 12. PERSONAL ADMINISTRATIVO
CREATE TABLE Personal_Administrativo (
    id_personal NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    cargo VARCHAR2(100) NOT NULL,
    id_usuario NUMBER UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 13. ASIGNATURAS
CREATE TABLE Asignaturas (
    id_asignatura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(20) UNIQUE NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    creditos NUMBER NOT NULL,
    id_plan NUMBER NOT NULL,
    FOREIGN KEY (id_plan) REFERENCES Planes_Estudio(id_plan)
);

-- 14. AULAS
CREATE TABLE Aulas (
    id_aula NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(20) NOT NULL,
    capacidad NUMBER NOT NULL,
    id_edificio NUMBER NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 15. CURSOS
CREATE TABLE Cursos (
    id_curso NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    periodo_academico VARCHAR2(20) NOT NULL,
    id_asignatura NUMBER NOT NULL,
    id_docente NUMBER NOT NULL,
    FOREIGN KEY (id_asignatura) REFERENCES Asignaturas(id_asignatura),
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente)
);

-- 16. HORARIOS
CREATE TABLE Horarios (
    id_horario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dia_semana VARCHAR2(15) NOT NULL,
    hora_inicio DATE NOT NULL,
    hora_fin DATE NOT NULL,
    id_curso NUMBER NOT NULL,
    id_aula NUMBER NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_aula) REFERENCES Aulas(id_aula)
);

-- 17. INSCRIPCIONES
CREATE TABLE Inscripciones (
    id_inscripcion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_inscripcion DATE NOT NULL,
    id_estudiante NUMBER NOT NULL,
    id_curso NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- 18. NOTAS
CREATE TABLE Notas (
    id_nota NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    calificacion NUMBER(4,2) NOT NULL,
    tipo_evaluacion VARCHAR2(50) NOT NULL,
    id_inscripcion NUMBER NOT NULL,
    FOREIGN KEY (id_inscripcion) REFERENCES Inscripciones(id_inscripcion)
);

-- 19. CALENDARIO ACADÉMICO
CREATE TABLE Calendario_Academico (
    id_calendario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    evento VARCHAR2(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    periodo VARCHAR2(20) NOT NULL
);

-- 20. EXÁMENES
CREATE TABLE Examenes (
    id_examen NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_examen VARCHAR2(50) NOT NULL,
    fecha_examen DATE NOT NULL,
    id_curso NUMBER NOT NULL,
    id_aula NUMBER NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_aula) REFERENCES Aulas(id_aula)
);

-- 21. RESULTADOS EXÁMENES
CREATE TABLE Resultados_Examenes (
    id_resultado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nota_obtenida NUMBER(4,2) NOT NULL,
    id_examen NUMBER NOT NULL,
    id_estudiante NUMBER NOT NULL,
    FOREIGN KEY (id_examen) REFERENCES Examenes(id_examen),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 22. BIBLIOTECA
CREATE TABLE Biblioteca (
    id_biblioteca NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_edificio NUMBER NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 23. LIBROS
CREATE TABLE Libros (
    id_libro NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    isbn VARCHAR2(20) UNIQUE NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    autor VARCHAR2(100) NOT NULL,
    id_biblioteca NUMBER NOT NULL,
    FOREIGN KEY (id_biblioteca) REFERENCES Biblioteca(id_biblioteca)
);

-- 24. PRÉSTAMOS BIBLIOTECA
CREATE TABLE Prestamos_Biblioteca (
    id_prestamo NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    id_libro NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 25. LABORATORIOS
CREATE TABLE Laboratorios (
    id_laboratorio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_edificio NUMBER NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 26. EQUIPOS LABORATORIO
CREATE TABLE Equipos_Laboratorio (
    id_equipo NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    numero_serie VARCHAR2(50) UNIQUE NOT NULL,
    id_laboratorio NUMBER NOT NULL,
    FOREIGN KEY (id_laboratorio) REFERENCES Laboratorios(id_laboratorio)
);

-- 27. INVESTIGACIONES
CREATE TABLE Investigaciones (
    id_investigacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(200) NOT NULL,
    linea_investigacion VARCHAR2(100) NOT NULL,
    id_departamento NUMBER NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
);

-- 28. PROYECTOS
CREATE TABLE Proyectos (
    id_proyecto NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(150) NOT NULL,
    presupuesto NUMBER(12,2),
    id_investigacion NUMBER NOT NULL,
    id_docente NUMBER NOT NULL,
    FOREIGN KEY (id_investigacion) REFERENCES Investigaciones(id_investigacion),
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente)
);

-- 29. PUBLICACIONES
CREATE TABLE Publicaciones (
    id_publicacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(200) NOT NULL,
    revista_o_editorial VARCHAR2(100) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    id_investigacion NUMBER NOT NULL,
    FOREIGN KEY (id_investigacion) REFERENCES Investigaciones(id_investigacion)
);

-- 30. EVENTOS ACADÉMICOS
CREATE TABLE Eventos_Academicos (
    id_evento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(150) NOT NULL,
    fecha_evento DATE NOT NULL,
    id_edificio NUMBER NOT NULL,
    FOREIGN KEY (id_edificio) REFERENCES Edificios(id_edificio)
);

-- 31. CONFERENCIAS
CREATE TABLE Conferencias (
    id_conferencia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tema VARCHAR2(150) NOT NULL,
    expositor VARCHAR2(100) NOT NULL,
    id_evento NUMBER NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos_Academicos(id_evento)
);

-- 32. SEMINARIOS
CREATE TABLE Seminarios (
    id_seminario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(150) NOT NULL,
    duracion_horas NUMBER NOT NULL,
    id_evento NUMBER NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos_Academicos(id_evento)
);

-- 33. PAGOS MATRÍCULA
CREATE TABLE Pagos_Matricula (
    id_pago NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    monto NUMBER(10,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    metodo_pago VARCHAR2(50) NOT NULL,
    id_estudiante NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 34. BECAS
CREATE TABLE Becas (
    id_beca NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    porcentaje_cobertura NUMBER(5,2) NOT NULL,
    id_estudiante NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 35. FINANZAS
CREATE TABLE Finanzas (
    id_finanza NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_transaccion VARCHAR2(50) NOT NULL, -- Ingreso / Egreso
    monto NUMBER(12,2) NOT NULL,
    fecha DATE NOT NULL,
    id_pago NUMBER,
    FOREIGN KEY (id_pago) REFERENCES Pagos_Matricula(id_pago)
);

-- 36. SEGURIDAD
CREATE TABLE Seguridad (
    id_seguridad NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    zona_asignada VARCHAR2(100) NOT NULL,
    turno VARCHAR2(30) NOT NULL,
    id_personal NUMBER NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES Personal_Administrativo(id_personal)
);

-- 37. ACCESOS
CREATE TABLE Accesos (
    id_acceso NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_hora DATE NOT NULL,
    punto_acceso VARCHAR2(50) NOT NULL,
    id_usuario NUMBER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 38. AUDITORÍA
CREATE TABLE Auditoria (
    id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    accion_realizada VARCHAR2(255) NOT NULL,
    tabla_afectada VARCHAR2(50) NOT NULL,
    fecha_hora DATE NOT NULL,
    id_usuario NUMBER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 39. TITULACIONES
CREATE TABLE Titulaciones (
    id_titulacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_titulacion DATE NOT NULL,
    modalidad VARCHAR2(50) NOT NULL,
    id_estudiante NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- 40. GRADUADOS
CREATE TABLE Graduados (
    id_graduado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    anio_graduacion NUMBER NOT NULL,
    id_estudiante NUMBER UNIQUE NOT NULL,
    id_titulacion NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_titulacion) REFERENCES Titulaciones(id_titulacion)
);

-- 41. EMPRESAS ASOCIADAS
CREATE TABLE Empresas_Asociadas (
    id_empresa NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    razon_social VARCHAR2(150) NOT NULL,
    ruc_nit VARCHAR2(20) UNIQUE NOT NULL,
    contacto VARCHAR2(100)
);

-- 42. CONVENIOS
CREATE TABLE Convenios (
    id_convenio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(150) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    id_empresa NUMBER NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES Empresas_Asociadas(id_empresa)
);

-- 43. INTERCAMBIOS ESTUDIANTILES
CREATE TABLE Intercambios_Estudiantiles (
    id_intercambio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    universidad_destino VARCHAR2(150) NOT NULL,
    pais VARCHAR2(50) NOT NULL,
    id_estudiante NUMBER NOT NULL,
    id_convenio NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_convenio) REFERENCES Convenios(id_convenio)
);

-- 44. PRÁCTICAS PROFESIONALES
CREATE TABLE Practicas_Profesionales (
    id_practica NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    horas_acumuladas NUMBER NOT NULL,
    estado VARCHAR2(30) NOT NULL,
    id_estudiante NUMBER NOT NULL,
    id_empresa NUMBER NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_empresa) REFERENCES Empresas_Asociadas(id_empresa)
);

-- 45. EVALUACIONES DOCENTES Y ENCUESTAS ESTUDIANTILES
CREATE TABLE Evaluaciones_Docentes (
    id_evaluacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    puntaje NUMBER(3,2) NOT NULL,
    comentario CLOB ,
    id_docente NUMBER NOT NULL,
    id_estudiante NUMBER NOT NULL,
    id_curso NUMBER NOT NULL,
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);