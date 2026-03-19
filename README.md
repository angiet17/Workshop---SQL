# Workshop-SQL
En este repositorio se desarrollará el taller utilizando Oracle Live SQL con la base de datos Academic (AD)

# Taller de Base de Datos Academic (AD) - Oracle Live SQL

El objetivo es analizar el rendimiento académico de los estudiantes y la capacidad administrativa de las facultades para proponer mejoras institucionales.

## Estructura del Proyecto

```text
├── analysis/
│   └── analysis_report.md   # Documentación con análisis, hallazgos y propuestas
├── queries/
│   ├── point1.sql           # Consultas para análisis de notas
│   ├── point2.sql           # Consultas para análisis administrativo
│   └── point3.sql           # Consultas para caracterización general
├── views/
│   └── create_views.sql     # Script para la creación de las vistas requeridas
└── README.md                # Guía de uso y contexto del taller
```

## Entregables

1.  **Documentos con los análisis**: Se encuentran en la carpeta `analysis/`.
2.  **Vistas y resultados**: El script `views/create_views.sql` genera las vistas solicitadas.
3.  **Consultas**: Los scripts SQL detallados se encuentran en `queries/`.

## Instrucciones para Ejecución en Oracle Live SQL

1. Inicie sesión en [Oracle Live SQL](https://livesql.oracle.com/).
2. Cargue o asegúrese de tener acceso al esquema **Academic (AD)**.
3. Copie y pegue el contenido de `views/create_views.sql` en el SQL Worksheet y ejecútelo.
4. Para obtener los resultados específicos de cada punto, ejecute los scripts en la carpeta `queries/`.

## Análisis y Recomendaciones Generales

El análisis principal destaca la necesidad de:
* Fortalecer el acompañamiento estudiantil en cursos con altos índices de pérdida.
* Redistribuir las cargas administrativas de las facultades basándose en los resultados de la vista `V_FACULTY_COURSES`.
* Limpiar los datos duplicados identificados en la caracterización general.

---
