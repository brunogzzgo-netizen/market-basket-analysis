# Crear `market-basket-analysis-clean` en GitHub

No puedo crear el repositorio en tu cuenta sin un **token** o sin que lo crees en la web.

## Opción rápida (navegador)

1. Abre: **https://github.com/new**
2. **Repository name:** `market-basket-analysis-clean`
3. **Public**, sin README, sin .gitignore, sin licencia.
4. Pulsa **Create repository**.
5. En PowerShell, en la carpeta del proyecto:

```powershell
cd c:\Users\brugz\Downloads\Cod_clase
git push -u clean main
```

(Ya está configurado el remoto `clean` apuntando a ese URL.)

## Opción con token (crea el repo automático)

1. GitHub → Settings → Developer settings → Personal access tokens → genera un token con permiso **repo** (o Fine-grained con creación de repos).
2. En PowerShell:

```powershell
cd c:\Users\brugz\Downloads\Cod_clase
$env:GITHUB_TOKEN = "tu_token_aqui"
.\scripts\create_clean_repo.ps1
```

El script crea el repo por API y hace `git push -u clean main`.
