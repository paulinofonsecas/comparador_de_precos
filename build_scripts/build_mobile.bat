@echo off
REM Script de build para Android e iOS (Windows)
REM Comparador de Preços - Build Mobile

echo ========================================
echo   Build Mobile - Android e iOS
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

REM Build Android APK
echo [3/5] Compilando Android APK...
call flutter build apk --release
if %errorlevel% neq 0 (
    echo ERRO: Falha ao compilar APK
    exit /b %errorlevel%
)
echo.

REM Build Android App Bundle
echo [4/5] Compilando Android App Bundle...
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
echo   Build Mobile concluido com sucesso!
echo ========================================
echo.
echo Arquivos gerados:
echo - APK: build\app\outputs\flutter-apk\app-release.apk
echo - App Bundle: build\app\outputs\bundle\release\app-release.aab
echo.
echo NOTA: Build iOS requer macOS com Xcode instalado
echo.
