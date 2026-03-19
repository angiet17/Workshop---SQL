/* ----------------------------------------------------------
    ANÁLISIS DE INDICADORES ACADÉMICOS - FASE 1
    OBJETIVO: Diagnóstico de calificaciones y asistencia
    ENTORNO: Oracle Live SQL (DB: Academic AD)
    ----------------------------------------------------------
*/

-- 1. REVISIÓN DE PADRÓN DE ESTUDIANTES
-- Extrae la data maestra para validación de registros anuales.
SELECT 
    student_id AS "ID_ALUMNO", 
    first_name AS "NOMBRE", 
    student_reg_year AS "AÑO_REGISTRO", 
    email_addr AS "CORREO_INSTITUCIONAL"
FROM AD.AD_STUDENT_DETAILS;

-- 2. MAPEO DE CARGA ACADÉMICA
-- Cruce de tablas para identificar qué materias cursa cada alumno.
SELECT 
    st.student_id, 
    st.first_name, 
    crs.course_name AS "MATERIA", 
    crs.session_id AS "ID_SESION"
FROM AD.AD_STUDENT_DETAILS st
JOIN AD.AD_STUDENT_COURSE_DETAILS sc ON st.student_id = sc.student_id
JOIN AD.AD_COURSE_DETAILS crs ON sc.course_id = crs.course_id;

-- 3. DESGLOSE DE EVALUACIONES Y CALIFICACIONES
-- Se vinculan resultados con el tipo de examen (parcial, final, etc.)
SELECT 
    alu.first_name AS "ESTUDIANTE", 
    res.marks AS "PUNTAJE", 
    tip.exam_name AS "CATEGORIA_EXAMEN",
    det.name AS "DESCRIPCION_EVAL"
FROM AD.AD_STUDENT_DETAILS alu
JOIN AD.AD_EXAM_RESULTS res ON alu.student_id = res.student_id
JOIN AD.AD_EXAM_DETAILS det ON res.exam_id = det.exam_id
JOIN AD.AD_EXAM_TYPE tip ON det.exam_type = tip.exam_type;

-- 4. CONSOLIDADO PARA ANÁLISIS DE DESEMPEÑO
-- Integra asistencia y notas para detectar la causa de la baja en rendimiento.
SELECT 
    s.first_name AS "ALUMNO",
    c.course_name AS "ASIGNATURA",
    ed.name AS "TIPO_PRUEBA",
    er.marks AS "NOTA_OBTENIDA",
    NVL(TO_CHAR(sa.no_of_working_days), 'Dato no registrado') AS "DIAS_ASISTIDOS"
FROM AD.AD_STUDENT_DETAILS s
JOIN AD.AD_STUDENT_COURSE_DETAILS sc ON s.student_id = sc.student_id
JOIN AD.AD_COURSE_DETAILS c ON sc.course_id = c.course_id
LEFT JOIN AD.AD_EXAM_RESULTS er ON s.student_id = er.student_id
LEFT JOIN AD.AD_EXAM_DETAILS ed ON er.exam_id = ed.exam_id
LEFT JOIN AD.AD_STUDENT_ATTENDANCE sa ON s.student_id = sa.student_id;

-- 5. MÉTRICAS DE DIFICULTAD (PROMEDIOS)
-- Cálculo para determinar qué exámenes tienen las notas más críticas.
SELECT 
    ex.name AS "EVALUACION", 
    ROUND(AVG(rs.marks), 1) AS "PROMEDIO_CURSO"
FROM AD.AD_EXAM_DETAILS ex
JOIN AD.AD_EXAM_RESULTS rs ON ex.exam_id = rs.exam_id
GROUP BY ex.name
ORDER BY "PROMEDIO_CURSO" DESC;

-- 6. AUDITORÍA DE DATOS (REQUERIMIENTO DE INTEGRIDAD)
-- Identificación de registros incompletos en la base de datos de estudiantes.
SELECT 
    student_id, 
    first_name 
FROM AD.AD_STUDENT_DETAILS 
WHERE email_addr IS NULL OR student_reg_year IS NULL;
