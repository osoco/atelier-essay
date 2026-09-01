# atelier-essay

Fuentes LaTeX del ensayo **«As We May Think Software»** (ficción de diseño
sobre una cultura de software alternativa), de Rafael Luque (OSOCO), en sus
versiones en español e inglés.

El ensayo se publicó originalmente en el blog de OSOCO:

- Español: https://osoco.es/thoughts/2026/01/as-we-may-think-software/
- English: https://osoco.es/thoughts/2026/01/as-we-may-think-software-en/

## Estructura

- `as-we-may-think-software-es.tex` — versión en español
- `as-we-may-think-software-en.tex` — versión en inglés
- `figures/` — ilustraciones (imágenes conceptuales generadas mediante IA
  generativa, indicadas como tales en los pies de figura)

## Construir los PDFs

```bash
make
```

El Makefile usa [Tectonic](https://tectonic-typesetting.github.io/) si está
instalado (binario autocontenido, descarga los paquetes bajo demanda) y, en su
defecto, `latexmk` con una instalación TeX Live estándar.

Las fuentes usan un preámbulo condicional (`iftex`), de modo que compilan
igualmente con **pdflatex** (mathpazo/Palatino) y con **XeTeX/Tectonic**
(TeX Gyre Pagella).

## Publicación en repositorios de preprints

- **arXiv**: compila con pdflatex y solo usa paquetes estándar, así que basta
  con subir el `.tex` correspondiente junto con el directorio `figures/`.
  arXiv requiere *endorsement* para el primer envío a una categoría
  (p. ej. cs.SE o cs.HC).
- **Zenodo**: acepta directamente el PDF construido y asigna DOI sin proceso
  de aprobación; es la vía más rápida para obtener un identificador citable.
