/* ----------------------------------------------------------
    ANÁLISIS DE CAPACIDAD Y GESTIÓN ACADÉMICA
    OBJETIVO: Evaluar carga operativa por facultad y departamento
    ENTORNO: Oracle Live SQL (Esquema AD)
    ----------------------------------------------------------
*/

-- 1. CARGA OPERATIVA POR DOCENTE
-- Cuantificación de asignaturas bajo la responsabilidad de cada profesor.
SELECT 
    doc.FIRST_NAME || ' ' || doc.LAST_NAME AS "DOCENTE_RESPONSABLE",
    doc.EMAIL AS "CONTACTO",
    COUNT(rel.COURSE_ID) AS "TOTAL_CURSOS"
FROM 
    AD.AD_FACULTY_DETAILS doc
LEFT JOIN 
    AD.AD_FACULTY_COURSE_DETAILS rel ON doc.FACULTY_ID = rel.FACULTY_ID
GROUP BY 
    doc.FIRST_NAME, doc.LAST_NAME, doc.EMAIL
ORDER BY 
    "TOTAL_CURSOS" DESC;

-- 2. DISTRIBUCIÓN POR DEPARTAMENTO
-- Análisis de volumen de cursos administrados por unidad académica.
SELECT 
    dep.DEPARTMENT_NAME AS "UNIDAD_ACADEMICA", 
    COUNT(crs.COURSE_ID) AS "VOLUMEN_CURSOS"
FROM 
    AD.AD_DEPARTMENTS dep
LEFT JOIN 
    AD.AD_COURSE_DETAILS crs ON dep.DEPARTMENT_ID = crs.DEPARTMENT_ID
GROUP BY 
    dep.DEPARTMENT_NAME
ORDER BY 
    "VOLUMEN_CURSOS" DESC;

-- 3. VALIDACIÓN DE LIDERAZGO (HOD)
-- Cruce para verificar correos de contacto de los jefes de departamento (HOD).
SELECT 
    d.DEPARTMENT_NAME AS "DEPARTAMENTO",
    d.HOD AS "JEFE_DE_AREA",
    f.EMAIL AS "EMAIL_DIRECTO",
    f.FACULTY_ID AS "ID_DOCENTE"
FROM 
    AD.AD_DEPARTMENTS d
LEFT JOIN 
    AD.AD_FACULTY_DETAILS f ON UPPER(d.HOD) = UPPER(f.FIRST_NAME || ' ' || f.LAST_NAME);

-- 4. VISTA INTEGRADA DE GESTIÓN
-- Creación de una vista maestra para consolidar la estructura institucional.
CREATE OR REPLACE VIEW V_ESTRUCTURA_ADMINISTRATIVA AS
SELECT 
    dep.DEPARTMENT_ID AS "ID_DEP",
    dep.DEPARTMENT_NAME AS "AREA",
    dep.HOD AS "LIDER_AREA",
    cur.COURSE_NAME AS "ASIGNATURA"
FROM 
    AD.AD_DEPARTMENTS dep
JOIN 
    AD.AD_COURSE_DETAILS cur ON dep.DEPARTMENT_ID = cur.DEPARTMENT_ID;

-- 5. AUDITORÍA DE REGISTROS HUÉRFANOS (CALIDAD DE DATOS)
-- Identificación de cursos que no han sido asignados a ningún departamento.
SELECT 
    COURSE_NAME AS "CURSO_SIN_AREA",
    COURSE_ID AS "CODIGO_CURSO"
FROM 
    AD.AD_COURSE_DETAILS 
WHERE 
    DEPARTMENT_ID IS NULL;
