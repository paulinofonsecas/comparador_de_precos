#!/bin/bash
# Script de build apenas para iOS (Mac)
# Comparador de Preços - Build iOS

set -e  # Parar execução em caso de erro

echo "========================================"
echo "  Build iOS"
echo "========================================"
echo ""

# Verificar se está no macOS
OS_TYPE="$(uname -s)"
if [ "${OS_TYPE}" != "Darwin" ]; then
    echo "ERRO: Build iOS requer macOS!"
    echo "Sistema detectado: ${OS_TYPE}"
    exit 1
fi

# Limpar builds anteriores
echo "[1/4] Limpando builds anteriores..."
flutter clean
echo ""

# Obter dependências
echo "[2/4] Obtendo dependencias..."
flutter pub get
echo ""

# Build iOS
echo "[3/4] Compilando iOS (Release - sem code signing)..."
flutter build ios --release --no-codesign
echo ""

# Enviar todas as tags para o repositório remoto
echo "[4/4] Enviando tags para o repositorio remoto..."
if git push origin --tags; then
    echo "Tags enviadas com sucesso!"
else
    echo "AVISO: Falha ao enviar tags (verifique se ha tags para enviar)"
fi
echo ""

echo "========================================"
echo "  Build iOS concluido com sucesso!"
echo "========================================"
echo ""
echo "Arquivos gerados:"
echo "- iOS: build/ios/Release-iphoneos/"
echo ""
echo "NOTA: Para distribuir o app, voce precisara:"
echo "1. Abrir o projeto no Xcode"
echo "2. Configurar code signing"
echo "3. Fazer archive e upload para App Store Connect"
echo ""
