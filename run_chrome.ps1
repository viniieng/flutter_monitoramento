# Script PowerShell para executar no Chrome

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Executando Projeto no Chrome" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Procurar Flutter em locais comuns
$flutterPaths = @(
    "C:\flutter\bin\flutter.bat",
    "C:\src\flutter\bin\flutter.bat",
    "$env:LOCALAPPDATA\flutter\bin\flutter.bat",
    "$env:USERPROFILE\flutter\bin\flutter.bat"
)

$flutterPath = $null
foreach ($path in $flutterPaths) {
    if (Test-Path $path) {
        $flutterPath = $path
        break
    }
}

if ($null -eq $flutterPath) {
    Write-Host "[ERRO] Flutter não encontrado automaticamente!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Procure onde o Flutter está instalado e execute:" -ForegroundColor Yellow
    Write-Host 'C:\caminho\para\flutter\bin\flutter run -d chrome' -ForegroundColor White
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "[INFO] Flutter encontrado em: $flutterPath" -ForegroundColor Green
Write-Host ""

Write-Host "[1/4] Habilitando suporte web..." -ForegroundColor Yellow
& $flutterPath config --enable-web
Write-Host ""

Write-Host "[2/4] Criando arquivos web..." -ForegroundColor Yellow
& $flutterPath create --platforms=web .
Write-Host ""

Write-Host "[3/4] Instalando dependências..." -ForegroundColor Yellow
& $flutterPath pub get
Write-Host ""

Write-Host "[4/4] Executando no Chrome..." -ForegroundColor Yellow
Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Aguarde o Chrome abrir..." -ForegroundColor Cyan
Write-Host " Primeira execução pode demorar!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

& $flutterPath run -d chrome

Write-Host ""
Write-Host "Pressione qualquer tecla para sair..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

