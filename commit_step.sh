#!/bin/sh
# Әр шақыру БІР коммит жасайды. Күніне 1-2 рет іске қосыңыз,
# сонда 15 коммит бірнеше аптаға табиғи түрде таралады.
# Бірінші рет: git init жасалады.
set -e
[ -d .git ] || git init -q

STEP_FILE=.git/commit_step
N=$(cat "$STEP_FILE" 2>/dev/null || echo 0)
N=$((N + 1))

commit() { git add $2 && git commit -q -m "$1" && echo "[$N/15] $1"; }

case $N in
  1)  commit "chore: add .gitignore (secrets, build output)" ".gitignore" ;;
  2)  commit "build: Maven project, Java 17, JUnit 5" "pom.xml" ;;
  3)  commit "docs: README with goals, usage and security notes" "README.md" ;;
  4)  commit "feat: Base32 encoder/decoder (RFC 4648)" "src/main/java/kz/totp/Base32.java" ;;
  5)  commit "test: Base32 and secret generation tests" "src/test/java/kz/totp/Base32Test.java" ;;
  6)  commit "feat: TOTP generation and verification, RFC 6238, HmacSHA1" "src/main/java/kz/totp/Totp.java" ;;
  7)  commit "test: RFC 6238 vectors and +-1 step drift tests" "src/test/java/kz/totp/TotpTest.java" ;;
  8)  commit "feat: SecureRandom secret generator" "src/main/java/kz/totp/SecretGenerator.java" ;;
  9)  commit "feat: encrypted secret vault (PBKDF2 + AES-GCM)" "src/main/java/kz/totp/SecretVault.java" ;;
  10) commit "test: vault encryption and wrong password tests" "src/test/java/kz/totp/SecretVaultTest.java" ;;
  11) commit "feat: console UI with live countdown and random theme" "src/main/java/kz/totp/Main.java" ;;
  12) commit "chore: add MIT license" "LICENSE" ;;
  13) commit "chore: run scripts for Linux/macOS and Windows" "run.sh run.bat" ;;
  14) commit "docs: add screenshot folder" "docs" ;;
  15) git add -A && git commit -q -m "chore: final cleanup" && echo "[$N/15] final cleanup" ;;
  *)  echo "15 коммит дайын."; exit 0 ;;
esac
echo "$N" > "$STEP_FILE"
