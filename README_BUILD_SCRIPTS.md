# Scripts de Build - Comparador de Preços

Scripts automatizados para build do aplicativo em diferentes plataformas.

---

## � Localização dos Scripts

Todos os scripts de build estão localizados na pasta `build_scripts/` na raiz do projeto.

---

## �📱 Mobile (Android e iOS)

### Build Mobile Completo

**Windows:**

```cmd
build_scripts\build_mobile.bat
```

**Mac/Linux:**

```bash
chmod +x build_scripts/build_mobile.sh
./build_scripts/build_mobile.sh
```

**O que faz:**

- ✅ Limpa builds anteriores (`flutter clean`)
- ✅ Obtém dependências (`flutter pub get`)
- ✅ Compila Android APK (`flutter build apk --release`)
- ✅ Compila Android App Bundle (`flutter build appbundle --release`)
- ✅ Compila iOS (apenas no Mac, com `--no-codesign`)
- ✅ Envia tags Git para o repositório remoto

**Arquivos gerados:**

- `build/app/outputs/flutter-apk/app-release.apk`
- `build/app/outputs/bundle/release/app-release.aab`
- `build/ios/Release-iphoneos/` (Mac apenas)

**Detecção automática de plataforma:**

O script `.sh` detecta automaticamente se está rodando no Mac ou Linux e só compila iOS se estiver no macOS.

---

### Build Android Apenas

**Windows:**

```cmd
build_scripts\build_android.bat
```

**Mac/Linux:**

```bash
chmod +x build_scripts/build_android.sh
./build_scripts/build_android.sh
```

**O que faz:**

- ✅ Limpa builds anteriores
- ✅ Obtém dependências
- ✅ Compila Android APK
- ✅ Compila Android App Bundle
- ✅ Envia tags Git

**Arquivos gerados:**

- `build/app/outputs/flutter-apk/app-release.apk`
- `build/app/outputs/bundle/release/app-release.aab`

---

### Build iOS Apenas

**Mac apenas:**

```bash
chmod +x build_scripts/build_ios.sh
./build_scripts/build_ios.sh
```

**O que faz:**

- ✅ Verifica se está rodando no macOS (falha se não estiver)
- ✅ Limpa builds anteriores
- ✅ Obtém dependências
- ✅ Compila iOS sem code signing (`flutter build ios --release --no-codesign`)
- ✅ Envia tags Git

**Arquivos gerados:**

- `build/ios/Release-iphoneos/`

> **⚠️ Importante:** Para distribuir na App Store, você precisará:
>
> 1. Abrir o projeto no Xcode
> 2. Configurar code signing
> 3. Fazer archive e upload para App Store Connect

---

## 🏷️ Tags Git

**Todos os scripts executam automaticamente ao final:**

```bash
git push origin --tags
```

Se não houver tags para enviar ou se houver erro, o script exibe um aviso mas não falha.

### Como criar uma tag antes de rodar o build

```bash
git tag -a v0.1.3 -m "Versão 0.1.3"
```

### Verificar tags locais

```bash
git tag
```

### Verificar tags remotas

```bash
git ls-remote --tags origin
```

---

## 📋 Resumo dos Scripts

| Script | Plataforma | Localização | Compila |
|--------|-----------|-------------|---------|
| `build_mobile.bat` | Windows | `build_scripts/` | Android APK + AAB |
| `build_mobile.sh` | Mac/Linux | `build_scripts/` | Android APK + AAB + iOS (Mac) |
| `build_android.bat` | Windows | `build_scripts/` | Android APK + AAB |
| `build_android.sh` | Mac/Linux | `build_scripts/` | Android APK + AAB |
| `build_ios.sh` | Mac | `build_scripts/` | iOS (sem code signing) |

---

## ⚙️ Processo de Build

Todos os scripts seguem este fluxo padronizado:

### Scripts Android (`.bat` e `.sh`)

1. **[1/5] Limpeza:** `flutter clean`
2. **[2/5] Dependências:** `flutter pub get`
3. **[3/5] Compilação APK:** `flutter build apk --release`
4. **[4/5] Compilação App Bundle:** `flutter build appbundle --release`
5. **[5/5] Git Tags:** `git push origin --tags`

### Script iOS (`.sh`)

1. **[1/4] Verificação de plataforma:** Confirma que está no macOS
2. **[2/4] Limpeza:** `flutter clean`
3. **[3/4] Dependências:** `flutter pub get`
4. **[4/4] Compilação iOS:** `flutter build ios --release --no-codesign`
5. **[5/5] Git Tags:** `git push origin --tags`

### Script Mobile Completo (`.sh`)

1. **[1/6] Limpeza:** `flutter clean`
2. **[2/6] Dependências:** `flutter pub get`
3. **[3/6] Compilação APK:** `flutter build apk --release`
4. **[4/6] Compilação App Bundle:** `flutter build appbundle --release`
5. **[5/6] Compilação iOS:** `flutter build ios --release --no-codesign` (apenas Mac)
6. **[6/6] Git Tags:** `git push origin --tags`

---

## ⚠️ Requisitos

### Geral

- ✅ Flutter SDK instalado e configurado
- ✅ Git instalado e configurado
- ✅ Conexão com repositório Git remoto configurada

### Android

- ✅ Android SDK
- ✅ Java JDK
- ✅ Configuração de signing para release (arquivo `key.properties`)

### iOS (Mac apenas)

- ✅ macOS
- ✅ Xcode instalado
- ✅ CocoaPods instalado (`sudo gem install cocoapods`)
- ✅ Command Line Tools do Xcode

---

## 🐛 Troubleshooting

### Erro ao enviar tags

```bash
# Verificar tags locais
git tag

# Verificar repositório remoto
git remote -v

# Verificar se há tags para enviar
git log --oneline --decorate

# Enviar tags manualmente
git push origin --tags

# Enviar uma tag específica
git push origin v0.1.3
```

### Erro de permissão (Mac/Linux)

```bash
# Dar permissão de execução para todos os scripts
chmod +x build_scripts/*.sh

# Ou para um script específico
chmod +x build_scripts/build_mobile.sh
```

### Verificar configuração do Flutter

```bash
flutter doctor
flutter doctor -v  # Versão detalhada
```

### Build Android falha

```bash
# Limpar cache do Gradle
cd android
./gradlew clean
cd ..

# Ou usar o Flutter
flutter clean
flutter pub get
```

### Build iOS falha (Mac)

```bash
# Limpar pods
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# Ou usar o Flutter
flutter clean
flutter pub get
cd ios
pod install
cd ..
```

### Script não encontrado

Certifique-se de estar na raiz do projeto antes de executar os scripts:

```bash
# Verificar diretório atual
pwd  # Mac/Linux
cd   # Windows

# Listar scripts disponíveis
ls build_scripts/  # Mac/Linux
dir build_scripts\ # Windows
```

---

## 📝 Notas Adicionais

### Code Signing

- **Android:** Configure o arquivo `android/key.properties` com suas credenciais de assinatura
- **iOS:** O build usa `--no-codesign` para desenvolvimento. Para produção, use o Xcode

### Builds de Produção

Para builds de produção destinados às lojas (Google Play / App Store):

1. **Android:** Use o App Bundle (`.aab`) gerado pelo script
2. **iOS:** Abra o Xcode, configure signing e faça archive manual

### Versionamento

Atualize a versão no `pubspec.yaml` antes de criar uma tag:

```yaml
version: 0.1.3+3  # versão+buildNumber
```

---

## 📝 Versão Atual

**Versão:** 0.1.2+2

**Última atualização:** 2025-11-30
