# atelier-essay

Fuentes LaTeX del ensayo **«As We May Think Software»** (ficción de diseño
sobre una cultura de software alternativa, continuación de la visión del
ensayo previo de Tomas Petricek), de Rafael Luque Leiva
([OSOCO](https://osoco.es)), en sus versiones en español e inglés.

El ensayo se publicó originalmente en el blog de OSOCO:

- Español: https://osoco.es/thoughts/2026/01/as-we-may-think-software/
- English: https://osoco.es/thoughts/2026/01/as-we-may-think-software-en/

## Estructura

- `essay/` — fuentes LaTeX y figuras (unidad autocontenida, lista para arXiv)
  - `as-we-may-think-software-es.tex` — versión en español
  - `as-we-may-think-software-en.tex` — versión en inglés
  - `figures/` — ilustraciones (imágenes conceptuales generadas mediante IA
    generativa, indicadas como tales en los pies de figura)
- `VERSION` — versión del ensayo, usada por la CI para etiquetar las releases

## Construir los PDFs en local

```bash
make
```

Los PDFs se generan junto a las fuentes, en `essay/`. El Makefile usa
[Tectonic](https://tectonic-typesetting.github.io/) si está instalado
(binario autocontenido, descarga los paquetes bajo demanda) y, en su defecto,
`latexmk` con una instalación TeX Live estándar.

Las fuentes usan un preámbulo condicional (`iftex`), de modo que compilan
igualmente con **pdflatex** (mathpazo/Palatino) y con **XeTeX/Tectonic**
(TeX Gyre Pagella).

## CI y releases

Cada push a `master` construye los PDFs mediante GitHub Actions y los publica
como release con la etiqueta `v<VERSION>-<fecha de build>` (varios pushes el
mismo día actualizan los adjuntos de esa misma release). Las últimas
versiones están siempre disponibles en:

- https://github.com/osoco/atelier-essay/releases/latest/download/As_We_May_Think_Software-ES.pdf
- https://github.com/osoco/atelier-essay/releases/latest/download/As_We_May_Think_Software-EN.pdf

## Publicación en repositorios de preprints

- **arXiv**: compila con pdflatex y solo usa paquetes estándar, así que basta
  con subir el contenido de `essay/` (el `.tex` correspondiente y
  `figures/`). arXiv requiere *endorsement* para el primer envío a una
  categoría (p. ej. cs.SE o cs.HC).
- **Zenodo**: acepta directamente el PDF construido y asigna DOI sin proceso
  de aprobación; es la vía más rápida para obtener un identificador citable.

## Licencia

Este trabajo se distribuye bajo la licencia
[Creative Commons Atribución-NoComercial-CompartirIgual 4.0 Internacional (CC BY-NC-SA 4.0)](LICENSE).
