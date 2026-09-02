# atelier-essay

Fuentes LaTeX del ensayo **«Atelier: As We May Think Software»** (ficción de diseño
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
- `.zenodo.json` / `CITATION.cff` — metadatos para el depósito en Zenodo y
  para la cita del repositorio

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

## DOI vía Zenodo

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22260777.svg)](https://doi.org/10.5281/zenodo.22260777)

Cada push a `master` queda archivado en Zenodo como una versión con
DOI propio; el *concept DOI*
[10.5281/zenodo.22260777](https://doi.org/10.5281/zenodo.22260777) apunta
siempre a la última versión. El depósito lo hace la propia CI mediante la
API de Zenodo (`scripts/zenodo-deposit.sh`), de modo que cada versión
contiene los **PDFs construidos** (ES y EN) además de una instantánea de las
fuentes. Los metadatos del primer depósito se tomaron de
[`.zenodo.json`](.zenodo.json); las versiones siguientes los heredan.

Configuración necesaria (una sola vez):

- Secret `ZENODO_TOKEN` en el repo: un *personal access token* de Zenodo
  con los scopes `deposit:write` y `deposit:actions`.
- El interruptor de la integración GitHub–Zenodo
  (*Settings → GitHub* en Zenodo) debe estar **desactivado** para este repo:
  de lo contrario cada release generaría dos versiones (la del webhook, solo
  con fuentes, y la de la CI).

Nota: el ensayo se envió a arXiv (cs.SE) en septiembre de 2026 y fue
rechazado por los moderadores por tipo de contenido — arXiv no acepta
ensayos ni piezas de visión, solo artículos de investigación convencionales.

## Licencia

Este trabajo se distribuye bajo la licencia
[Creative Commons Atribución-NoComercial-CompartirIgual 4.0 Internacional (CC BY-NC-SA 4.0)](LICENSE).
