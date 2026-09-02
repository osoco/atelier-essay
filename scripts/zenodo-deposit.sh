#!/usr/bin/env bash
# Publica una nueva versión del registro Zenodo del ensayo (concept
# 10.5281/zenodo.22260777) con los PDFs construidos y una instantánea de las
# fuentes. Requiere ZENODO_TOKEN (scopes deposit:write + deposit:actions),
# curl y jq. Uso: zenodo-deposit.sh <tag>  (p. ej. v1.0.2-20260903)
set -euo pipefail

CONCEPT_RECID=22260777
API="https://zenodo.org/api"
AUTH="Authorization: Bearer ${ZENODO_TOKEN}"
TAG="${1:?falta el tag de la release}"

# Última versión (publicada o borrador huérfano de una ejecución fallida)
LATEST=$(curl -sf -H "$AUTH" \
  "$API/deposit/depositions?q=conceptrecid:$CONCEPT_RECID&sort=mostrecent&size=1")
LATEST_ID=$(echo "$LATEST" | jq -r '.[0].id')
SUBMITTED=$(echo "$LATEST" | jq -r '.[0].submitted')

if [ "$SUBMITTED" = "true" ]; then
  # newversion devuelve el borrador nuevo (o el existente, si quedó uno a
  # medias); según la variante de la API el borrador viene en
  # links.latest_draft o es la propia respuesta.
  NEWV=$(curl -sf -X POST -H "$AUTH" \
    "$API/deposit/depositions/$LATEST_ID/actions/newversion")
  DRAFT_ID=$(echo "$NEWV" | jq -r \
    'if .links.latest_draft then (.links.latest_draft | split("/") | last) else (.id | tostring) end')
else
  DRAFT_ID="$LATEST_ID"
fi
DRAFT_URL="$API/deposit/depositions/$DRAFT_ID"
echo "Borrador: $DRAFT_URL"

# Eliminar los ficheros heredados de la versión anterior
for FILE_ID in $(curl -sf -H "$AUTH" "$DRAFT_URL/files" | jq -r '.[].id'); do
  curl -sf -X DELETE -H "$AUTH" "$DRAFT_URL/files/$FILE_ID"
done

# Subir los PDFs y la instantánea de las fuentes
BUCKET=$(curl -sf -H "$AUTH" "$DRAFT_URL" | jq -r '.links.bucket')
git archive --format=zip --prefix="atelier-essay-$TAG/" \
  -o "atelier-essay-$TAG-sources.zip" HEAD
for F in "essay/Atelier_As_We_May_Think_Software-ES.pdf" \
         "essay/Atelier_As_We_May_Think_Software-EN.pdf" \
         "atelier-essay-$TAG-sources.zip"; do
  echo "Subiendo $(basename "$F")..."
  curl -sf -H "$AUTH" --upload-file "$F" "$BUCKET/$(basename "$F")" > /dev/null
done

# Actualizar metadatos: los heredados + los canónicos de .zenodo.json +
# versión y fecha de publicación
curl -sf -H "$AUTH" "$DRAFT_URL" \
  | jq --slurpfile z .zenodo.json --arg v "$TAG" --arg d "$(date -u +%F)" \
    '{metadata: (.metadata + $z[0] + {version: $v, publication_date: $d})}' \
  | curl -sf -X PUT -H "$AUTH" -H "Content-Type: application/json" \
      -d @- "$DRAFT_URL" > /dev/null

RECORD=$(curl -sf -X POST -H "$AUTH" "$DRAFT_URL/actions/publish")
echo "Publicado: $(echo "$RECORD" | jq -r '.doi_url')"
