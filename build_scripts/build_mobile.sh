#!/bin/bash
# Script de build para Android e iOS (Mac/Linux)
# Comparador de Preços - Build Mobile

set -e  # Parar execução em caso de erro

echo "========================================"
echo "  Build Mobile - Android e iOS"
echo "========================================"
echo ""

# Detectar sistema operacional
OS_TYPE="$(uname -s)"
case "${OS_TYPE}" in
    Linux*)     PLATFORM=Linux;;
    Darwin*)    PLATFORM=Mac;;
    *)          PLATFORM="UNKNOWN:${OS_TYPE}"
esac

echo "Sistema detectado: ${PLATFORM}"
echo ""

# Limpar builds anteriores
echo "[1/6] Limpando builds anteriores..."
flutter clean
echo ""

# Obter dependências
echo "[2/6] Obtendo dependencias..."
flutter pub get
echo ""

# Build Android APK
echo "[3/6] Compilando Android APK..."
flutter build apk --release
echo ""

# Build Android App Bundle
echo "[4/6] Compilando Android App Bundle..."
flutter build appbundle --release
echo ""

# Build iOS (apenas no Mac)
if [ "${PLATFORM}" = "Mac" ]; then
    echo "[5/6] Compilando iOS..."
    flutter build ios --release --no-codesign
    echo ""
else
    echo "[5/6] Pulando build iOS (requer macOS)"
    echo ""
fi

# Enviar todas as tags para o repositório remoto
echo "[6/6] Enviando tags para o repositorio remoto..."
if git push origin --tags; then
    echo "Tags enviadas com sucesso!"
else
    echo "AVISO: Falha ao enviar tags (verifique se ha tags para enviar)"
fi
echo ""

echo "========================================"
echo "  Build Mobile concluido com sucesso!"
echo "========================================"
echo ""
echo "Arquivos gerados:"
echo "- APK: build/app/outputs/flutter-apk/app-release.apk"
echo "- App Bundle: build/app/outputs/bundle/release/app-release.aab"

if [ "${PLATFORM}" = "Mac" ]; then
    echo "- iOS: build/ios/Release-iphoneos/"
fi
echo ""
