@echo off
REM Script de build apenas para Android (Windows)
REM Comparador de Preços - Build Android

echo ========================================
echo   Build Android - APK e App Bundle
echo ========================================
echo.

REM Limpar builds anteriores
echo [1/5] Limpando builds anteriores...
call flutter clean
if %errorlevel% neq 0 (
    echo ERRO: Falha ao limpar projeto
    exit /b %errorlevel%
)
echo.

REM Obter dependências
echo [2/5] Obtendo dependencias...
call flutter pub get
if %errorlevel% neq 0 (
    echo ERRO: Falha ao obter dependencias
    exit /b %errorlevel%
)
echo.

REM Build APK
echo [3/5] Compilando APK (Release)...
call flutter build apk --release
if %errorlevel% neq 0 (
    echo ERRO: Falha ao compilar APK
    exit /b %errorlevel%
)
echo.

REM Build App Bundle
echo [4/5] Compilando App Bundle (Release)...
call flutter build appbundle --release
if %errorlevel% neq 0 (
    echo ERRO: Falha ao compilar App Bundle
    exit /b %errorlevel%
)
echo.

REM Enviar todas as tags para o repositório remoto
echo [5/5] Enviando tags para o repositorio remoto...
git push origin --tags
if %errorlevel% neq 0 (
    echo AVISO: Falha ao enviar tags (verifique se ha tags para enviar)
)
echo.

echo ========================================
echo   Build Android concluido com sucesso!
echo ========================================
echo.
echo Arquivos gerados:
echo - APK: build\app\outputs\flutter-apk\app-release.apk
echo - App Bundle: build\app\outputs\bundle\release\app-release.aab
echo.
