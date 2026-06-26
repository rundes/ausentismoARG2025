# Proyecto: Informe Ausentismo Electoral Argentina (2017-2025)

Documento de continuidad. Permite retomar el hilo en una sesion nueva.
Ultima actualizacion: 2026-06-26.

## Que es
Informe web del ausentismo electoral argentino, con foco en la eleccion legislativa 2025
y comparacion historica (PASO 2017, PASO 2019, Generales+Balotaje 2023, Legislativas 2025).
Sujeto = ausentismo de los habilitados a votar; el "infractor" es un subconjunto.

- **Sitio live:** https://rundes.github.io/ausentismoARG2025/
- **Repo:** github.com/rundes/ausentismoARG2025 (rama `main`, GitHub Pages source = main / root)

## Como regenerar y publicar
1. Editar el generador: `C:\Users\santiago\gen_report2.ps1` (copia tambien en este repo: `gen_report2.ps1`). Toda la data esta embebida en bloques here-string.
2. Ejecutar: `& "$env:USERPROFILE\gen_report2.ps1"` -> escribe `index.html`.
3. Publicar:
   ```
   $env:GH_TOKEN='<PAT con scope repo>'
   cd $env:USERPROFILE\ausentismoARG2025
   git add -A; git commit -m "..."; git push origin main
   ```
4. Build de Pages tarda ~30-60s. Verificar con `Invoke-WebRequest https://rundes.github.io/ausentismoARG2025/`.

> AUTH: el PAT usado en la sesion (ghp_OAJP8...) deberia revocarse. Para pushear de nuevo:
> generar PAT nuevo (scope `repo`) y setear `$env:GH_TOKEN` en la MISMA llamada PowerShell,
> o `gh auth login`. No hay `gcloud`/`gsutil`/`bq` instalados; subidas a GCS las hace el usuario (consola web o gcloud).

## Cifras nacionales 2025 (definicion vigente)
- Padron habilitado: 36.478.349
- Ausentes (no votaron): 11.288.010 = 30,9%
- **Infractor (amplio): 8.061.870 = 22,1%** del padron. Def = ausente obligado que no voto ni justifico, MAS tramites administrativos (pago de multa, CUE anulado, codigos sin clasificar). Equivale a: ausentes - exento_edad - justificado.
- Exento por edad: 3.015.385 (26,7% de ausentes) = mayores de 70 (motivo 3) + menores de 18 (motivo 4)
- Justificado: 210.755 (estados 4,5,14,16)

## Serie historica (tendencia nacional)
| | 2017 PASO | 2019 PASO | 2023 Generales | 2025 Legislativas |
|---|---|---|---|---|
| Ausentismo | 24,6% | 23,8% | 21,2% | 30,9% |
| Infraccion | n/d | n/d | 13,9% | 22,1% |
- Balotaje 2023: ausentismo 24,3-24,4%, infraccion 16,7%.
- 2021 EXCLUIDO por decision del usuario (anio COVID).
- Infraccion 2017/2019 = n/d (esos archivos solo traen DNI+sexo, sin motivo/estado).

## BigQuery (proyecto `cp-electoral`)
### Dataset `INFRACTORES2025` (lo construido)
- `infractores_2025_clean` — 11.288.010 filas, parseado nacional desde GCS (SPLIT por `;`, tab->`;`, fechas `%Y-%m-%d` y `%Y/%m/%d`, dedup).
- `infractores_2025_enriquecido` — clean + distrito/secc/circu (padron), edad/grupo_etario (ref 2025-10-26), estado_desc, es_infractor, motivo_desc, categoria.
- `dim_estados` (17 filas), `dim_motivos` (46) — diccionarios oficiales.
- `rep_por_provincia` — tabla de reporte 2025.
- Tablas externas (leen GCS en vivo): `ext_infract_raw` (2025 gen), `ext_bucket_discovery` (todo INFRACTORES/*), `ext_dicts` (t_estados+t_motivos), `ext_2023g`, `ext_2023b`, `ext_hist` (2019 gen+PASO, 2021).

### Dataset `Datos_Electorales` (padrones; nombres con sufijo "PBA" pero son NACIONALES)
- `2025-PADRON-PBA-OCT` — 36.478.349, 25 distritos. Join: campo `MATRICULA` = DNI.
- `2023-PADRON-PBA` — 35.779.405. Join: campo `NU_MATRICULA`.
- `2021-PADRON-PBA` — 34.807.059 (no usado, 2021 excluido).
- `2019-PADRON-EXTRANJEROS` — solo extranjeros (NO hay padron nativo 2019 en BQ).
- Padron 2017: NO esta en BQ. Se uso el xlsx local agregado a electores por distrito.

## GCS bucket `data_electoral/INFRACTORES/`
- `2017-INFRACTORES/distrito_NN_no_votantes.csv` (24) — subido por usuario. Formato `DOCUMENTO,SEXO`.
- `2019 - Infractores (PASO 2019)/distrito_NN_no_votantes.csv` (24, DNI+sexo) + archivos viejos `Infractores_PROV.csv`.
- `2019 - Infractores (GENERALES)/PROV.csv` (24, formato rico con TX_*).
- `2021 - Infractores (GENERALES PBA)/` (1 archivo, solo PBA) ; `2021 - Infractores - PASO/` (17 chunks + `02_novoto/t_estados.csv` + `t_motivos.csv`).
- `2023 - Infractores/No Votantes 2023 generales/NN_no_votantes_G.csv` (24) ; `No Votantes 2023 balotaje/NN_no_votantes_B.csv` (24).
- `2025 - Infractores (GENERALES)/NN_no_votantes.csv` (24) ; `2025 - Infractores (Septiembre PBA)/`.

## Estructura de datos clave
- Infractor 2023/2025: `matricula;sexo;apellido;[apellido dup];nombres;fecnac;secc;circu;t_estados_id;t_motivos_id` (9 o 10 campos). 2023 viene con comillas. Delimitador `;` (en 2025 archivos 05 y 11 = tab).
- t_estados: flag `infractor` (estado 2=NO VOTO etc). t_motivos: motivo->estado (motivo 3=MAYOR DE 70, 4=MENOR DE 18 -> estado 8 EXENTO; 26=TROQUEL LEIDO -> estado 2).
- 2017/2019 PASO: solo `DOCUMENTO,SEXO` (coma). Provincia = numero de archivo (distrito_NN).
- Mapeo distrito: 01 Capital Federal, 02 Buenos Aires, 03 Catamarca, 04 Cordoba, 05 Corrientes, 06 Chaco, 07 Chubut, 08 Entre Rios, 09 Formosa, 10 Jujuy, 11 La Pampa, 12 La Rioja, 13 Mendoza, 14 Misiones, 15 Neuquen, 16 Rio Negro, 17 Salta, 18 San Juan, 19 San Luis, 20 Santa Cruz, 21 Santa Fe, 22 Sgo del Estero, 23 Tucuman, 24 Tierra del Fuego (30 = exterior).

## Secciones del informe (index.html)
01 Composicion ausentismo · 02 Edad y sexo (piramide) · 03 Ranking provincias · 04 Comparacion (tabla 3 instancias 2023/2025, barras por provincia, cuadro 4 anios con %, tendencia linea, edad/sexo 2023vs2025) · 05 Provincia por provincia (24 fichas: composicion, edad, sexo, ranking de departamentos) · 06 Mapa (4 mapas de burbujas). Charts = SVG/CSS nativos responsivos (sin imagenes externas).

## Archivos locales
- `C:\Users\santiago\gen_report2.ps1` — generador (fuente de verdad, data embebida).
- `C:\Users\santiago\ausentismoARG2025\` — repo git (index.html, .nojekyll, este HANDOFF, gen_report2.ps1).
- `C:\Users\santiago\_paso_zip\infractores_2017_2019\` — PASO 2017/2019 extraidos.
- `C:\Users\santiago\_padron2017\Padron_2017.xlsx` + `_p2017x\` — padron 2017 (nivel mesa).
- `C:\Users\santiago\Downloads\Hoja 1_data.csv` — centroides + electores 2019.

## Pendientes / posibles mejoras
- Padron NATIVO nacional 2019 y 2021 si se quiere infraccion/edad de esos anios.
- Infractor 2019 usando `2019 - Infractores (GENERALES)` (formato rico, ya en bucket) en vez del PASO DNI+sexo.
- Poligonos reales de provincias (GeoJSON) para choropleth en vez de burbujas (el CSV no traia geometria, solo centroides).
- PASO 2023 si aparece (para arco completo PASO/Gral/Balotaje 2023).

## Entregables Drive (version texto previa)
Carpeta Drive "Informe Ausentismo Electoral 2025": 1 Google Doc narrativo + 2 Google Sheets (por provincia; segmentos/sexo/motivos). El sitio GitHub Pages es la version grafica definitiva.
