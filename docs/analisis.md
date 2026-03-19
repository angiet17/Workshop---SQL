# Informe Técnico: Análisis Institucional - Oracle Academic (AD)

Este documento detalla los hallazgos, el diagnóstico administrativo y las propuestas de mejora para la universidad, basados en la auditoría de datos realizada en el esquema AD.

---

## 1. Diagnóstico Estudiantil y Desempeño (Punto 1)
Tras auditar la tabla `AD_EXAM_RESULTS` y cruzarla con `AD_STUDENT_DETAILS`, se han identificado los siguientes puntos clave:

- **Indicador de Calificaciones**: El promedio histórico de ciertos exámenes críticos presenta una tendencia a la baja (ver métricas en `Punto1.sql`).
- **Problema de Integridad**: Se detectaron registros sin correo institucional (email null) o sin año de registro, lo que dificulta la comunicación directa con el estudiante.
- **Relación Asistencia/Nota**: Al integrar la tabla `AD_STUDENT_ATTENDANCE`, se observa una correlación directa entre los días asistidos y el puntaje obtenido en evaluaciones parciales.

** Hallazgo Crítico:** Ciertos tipos de exámenes proyectan una dificultad significativamente mayor que otros.

---

## 2. Gestión de Capacidad Administrativa (Punto 2)
El análisis de carga operativa por facultad y departamento revela:

- **Saturación Docente**: Algunos profesores gestionan más de 5 cursos simultáneamente (detectado mediante el conteo en `AD_FACULTY_COURSE_DETAILS`), lo que puede afectar la calidad educativa.
- **Carga por Departamento**: Existe una disparidad en el volumen de cursos entre unidades académicas. Los departamentos con mayor número de asignaturas requieren una revisión de su estructura de liderazgo (Head of Department - HOD).
- **Cursos Huérfanos**: Se identificaron asignaturas en `AD_COURSE_DETAILS` que no tienen un `DEPARTMENT_ID` asignado, generando vacíos administrativos.

** Propuesta de Mejora:** Centralizar las notificaciones de jefatura de área mediante los correos directos mapeados en el análisis del subpunto 3 para agilizar la toma de decisiones.

---

## 3. Planificación y Proyección (Punto 3)
Preparación para la nueva temporada académica mediante la unificación de datos históricos:

- **Limpieza de Datos**: Se identificaron registros duplicados en `AD_COURSE_DETAILS` (mismo curso en la misma sesión). Es imperativo depurar la base antes del nuevo ciclo.
- **Fortalecimiento Institucional**: Los departamentos con menor oferta académica identificados en el análisis de volumen requieren una inversión proactiva para equilibrar el campus.
- **Proyección de Carga**: Al evaluar la relación Alumno-Docente, se ha proyectado que las facultades de mayor demanda (top en inscritos) necesitarán auxiliares administrativos adicionales.

---

## Conclusiones Finales
1. **Integridad**: Es urgente corregir los registros con valores nulos para garantizar la veracidad del reporte académico.
2. **Infraestructura**: Se recomienda la redistribución de asignaturas para aliviar la carga de los docentes más saturados.
3. **Optimización**: La creación de la vista `V_CONSOLIDADO_ACADEMICO_TOTAL` facilitará al administrador una visión 360° de la universidad en tiempo real.
