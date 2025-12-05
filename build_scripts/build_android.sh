#!/bin/bash
# Script de build apenas para Android (Mac/Linux)
# Comparador de Preços - Build Android

set -e  # Parar execução em caso de erro

echo "========================================"
echo "  Build Android - APK e App Bundle"
echo "========================================"
echo ""

# Limpar builds anteriores
echo "[1/5] Limpando builds anteriores..."
flutter clean
echo ""

# Obter dependências
echo "[2/5] Obtendo dependencias..."
flutter pub get
echo ""

# Build APK
echo "[3/5] Compilando APK (Release)..."
flutter build apk --release
echo ""

# Build App Bundle
echo "[4/5] Compilando App Bundle (Release)..."
flutter build appbundle --release
echo ""

# Enviar todas as tags para o repositório remoto
echo "[5/5] Enviando tags para o repositorio remoto..."
if git push origin --tags; then
    echo "Tags enviadas com sucesso!"
else
    echo "AVISO: Falha ao enviar tags (verifique se ha tags para enviar)"
fi
echo ""

echo "========================================"
echo "  Build Android concluido com sucesso!"
echo "========================================"
echo ""
echo "Arquivos gerados:"
echo "- APK: build/app/outputs/flutter-apk/app-release.apk"
echo "- App Bundle: build/app/outputs/bundle/release/app-release.aab"
echo ""
