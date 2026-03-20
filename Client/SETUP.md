# Ejecutar dbt con BigQuery

Antes de ejecutar dbt run, define en PowerShell (usa tu propia ruta y proyecto):

1. Ruta al JSON de la cuenta de servicio de GCP (no subas ese archivo al repositorio):

   `$env:GOOGLE_APPLICATION_CREDENTIALS = "path/to/your-service-account.json"`

2. ID del proyecto de Google Cloud donde están las tablas:

   `$env:GCP_PROJECT_ID = "your-gcp-project-id"`

3. (Opcional) Nombre del dataset en BigQuery si difiere del valor por defecto en `sources.yml`:

   `$env:BQ_DATASET = "your_dataset_name"`

Luego, desde la carpeta `Client`:

   `dbt clean`
   `dbt run --profiles-dir .`

Los modelos se materializan en el archivo DuckDB local configurado en `profiles.yml` (por defecto `jordan.duckdb`), leyendo desde BigQuery.
