@echo off
echo ====================================
echo  Executando Projeto no Chrome
echo ====================================
echo.

REM Procurar Flutter em locais comuns
set FLUTTER_PATH=

if exist "C:\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=C:\flutter\bin\flutter.bat
) else if exist "C:\src\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=C:\src\flutter\bin\flutter.bat
) else if exist "%LOCALAPPDATA%\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=%LOCALAPPDATA%\flutter\bin\flutter.bat
) else if exist "%USERPROFILE%\flutter\bin\flutter.bat" (
    set FLUTTER_PATH=%USERPROFILE%\flutter\bin\flutter.bat
)

if "%FLUTTER_PATH%"=="" (
    echo [ERRO] Flutter nao encontrado!
    echo.
    echo Por favor, informe o caminho do Flutter:
    echo Exemplo: C:\flutter\bin\flutter.bat
    echo.
    set /p FLUTTER_PATH="Digite o caminho completo: "
)

echo.
echo [INFO] Usando Flutter em: %FLUTTER_PATH%
echo.

echo [1/4] Habilitando suporte web...
call "%FLUTTER_PATH%" config --enable-web
echo.

echo [2/4] Criando arquivos web...
call "%FLUTTER_PATH%" create --platforms=web .
echo.

echo [3/4] Instalando dependencias...
call "%FLUTTER_PATH%" pub get
echo.

echo [4/4] Executando no Chrome...
echo.
echo ====================================
echo  Aguarde o Chrome abrir...
echo  Primeira execucao pode demorar!
echo ====================================
echo.
call "%FLUTTER_PATH%" run -d chrome

pause

