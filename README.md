# Restauración Ecológica del Altiplano Mexicano

![Vista previa del algoritmo de ruteo](https://github.com/alcazar-dev/Restauracion-Ecologica-del-Altiplano-Mexicano/blob/main/Ruteo.gif)

## Descripción

Este repositorio acompaña al artículo titulado:  
**"Optimización del Proceso de Restauración Ecológica del Matorral Desértico en el Altiplano Mexicano"**  
Autores: *Mendoza, A.; Alcázar, L.; Coria, R.*

---

## Contexto

La mitigación del impacto del desarrollo humano sobre los ecosistemas nativos se ha convertido en una estrategia crítica y ampliamente adoptada en México. El éxito de los proyectos de restauración ecológica depende en gran medida de la capacidad para **predecir con precisión el tiempo y los recursos necesarios** para completarlos. Cualquier actividad no anticipada puede traducirse en **pérdidas económicas** que pongan en riesgo la viabilidad del proyecto.

---

## Objetivo del Proyecto

Este trabajo presenta **tres algoritmos matemáticos y computacionales** diseñados para optimizar la distribución de plantas en un proyecto de restauración en el Altiplano Mexicano. El problema se modeló como un **Problema de Ruteo con Capacidad (CVRP)**.

### Algoritmos desarrollados:

1. **Programación lineal** utilizando un solucionador de **Programación Entera Mixta (MIP)**.
2. Algoritmo basado en **metaheurísticas** con OR-Tools.
3. Algoritmo basado en **metaheurísticas KNN**.

---

## Resultados

- Los tres algoritmos mostraron resultados óptimos y eficientes computacionalmente en redes con **menos de 16 nodos**, donde cada nodo representa un cuadrante a restaurar.
- Al escalar el problema hasta **26 nodos**, se observó que la formulación exacta crece exponencialmente en tiempo de ejecución.
- Las soluciones basadas en metaheurísticas (OR-Tools y KNN) **mantuvieron tiempos de ejecución por debajo de un segundo** en todos los casos evaluados.

---

## Palabras clave

`CVRP`, `MIP`, `Metaheurísticas`, `Restauración Ecológica`, `Optimización`, `Algoritmo`

---

## Repositorio

Este proyecto se encuentra en:  
[Restauracion-Ecologica-del-Altiplano-Mexicano](https://github.com/alcazar-dev/Restauracion-Ecologica-del-Altiplano-Mexicano)

