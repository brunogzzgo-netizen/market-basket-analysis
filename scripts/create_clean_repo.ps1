# Crea el repo market-basket-analysis-clean en tu cuenta de GitHub y sube main.
# Requisito: token con permiso "repo" (Fine-grained: Contents read/write, or classic: repo).
#
# Uso (PowerShell):
#   $env:GITHUB_TOKEN = "ghp_xxxxxxxx"   # o un Fine-grained PAT
#   .\scripts\create_clean_repo.ps1

$ErrorActionPreference = "Stop"
$repoName = "market-basket-analysis-clean"
$owner = "brunogzzgo-netizen"
$remoteUrl = "https://github.com/$owner/$repoName.git"

if (-not $env:GITHUB_TOKEN) {
    Write-Host "No hay GITHUB_TOKEN en el entorno." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Opcion A - Crear el repo en el navegador (sin token):" -ForegroundColor Cyan
    Write-Host "  1. Abre: https://github.com/new"
    Write-Host "  2. Repository name: $repoName"
    Write-Host "  3. Public, SIN README, SIN .gitignore"
    Write-Host "  4. Create repository"
    Write-Host "  5. En la carpeta del proyecto ejecuta:"
    Write-Host "     git remote add clean $remoteUrl"
    Write-Host "     git push -u clean main"
    Write-Host ""
    Write-Host "Opcion B - Con token (crea el repo por API):" -ForegroundColor Cyan
    Write-Host '  $env:GITHUB_TOKEN = "tu_pat"'
    Write-Host "  .\scripts\create_clean_repo.ps1"
    exit 1
}

$headers = @{
    Authorization = "Bearer $($env:GITHUB_TOKEN)"
    Accept        = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

$body = @{
    name        = $repoName
    description = "Market Basket Analysis - dbt + DuckDB + Python (clean history)"
    private     = $false
    auto_init   = $false
} | ConvertTo-Json

Write-Host "Creando repositorio $owner/$repoName ..."
try {
    Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
} catch {
    if ($_.Exception.Response.StatusCode -eq 422) {
        Write-Host "El repo quizas ya existe. Continuando con push..." -ForegroundColor Yellow
    } else {
        throw
    }
}

# Carpeta del proyecto (padre de scripts/)
$root = Split-Path $PSScriptRoot -Parent
Set-Location $root

git remote remove clean 2>$null
git remote add clean $remoteUrl
Write-Host "Subiendo main a clean ..."
git push -u clean main
Write-Host "Listo: https://github.com/$owner/$repoName" -ForegroundColor Green
